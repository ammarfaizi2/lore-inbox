Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbWDDP6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWDDP6t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 11:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbWDDP6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 11:58:49 -0400
Received: from o-hand.com ([70.86.75.186]:1488 "EHLO o-hand.com")
	by vger.kernel.org with ESMTP id S1750724AbWDDP6s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 11:58:48 -0400
Subject: Re: [PATCH RFC/testing] Upgrade the zlib_inflate library code to a
	recent version
From: Richard Purdie <richard@openedhand.com>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
In-Reply-To: <20060404153354.GD25130@wohnheim.fh-wedel.de>
References: <1144163888.6441.48.camel@localhost.localdomain>
	 <20060404153354.GD25130@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=ISO-8859-1
Date: Tue, 04 Apr 2006 16:56:51 +0100
Message-Id: <1144166212.6441.57.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-04 at 17:33 +0200, Jörn Engel wrote:
> On Tue, 4 April 2006 16:18:08 +0100, Richard Purdie wrote: 
> > Upgrade the zlib_inflate implementation in the kernel from a patched
> > version 1.1.3 to a patched 1.2.3. 
> 
> s/1.1.3/1.1.4/
>
> I once pulled all the bugfixes between the versions into the kernel.

That's not what the header says :)

> > +#if 0
> > +int zlib_inflatePrime(z_streamp strm, int bits, int value)
> 
> Was this code dead in 1.2.3 as well?

This code was commented out in the kernel by Adrian Bunk as it has no
users and I just followed that example when updating  I'm sure if
someone needed it, it could be enabled.

> > +#ifndef PKZIP_BUG_WORKAROUND
> 
> For the kernel, we can remove compat code against DOS compilers, etc.
> In this particular case, I believe we can just consider data
> compressed with PKZIP to be illegal and throw an error.

Agreed, there are places it can be tidied up a bit further. I was trying
not to make too many changes so any future updates against zlib are
easier.

Richard

