Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274788AbTHPPv6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 11:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274804AbTHPPv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 11:51:58 -0400
Received: from waste.org ([209.173.204.2]:28346 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S274788AbTHPPv5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 11:51:57 -0400
Date: Sat, 16 Aug 2003 10:51:10 -0500
From: Matt Mackall <mpm@selenic.com>
To: James Morris <jmorris@intercode.com.au>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Jamie Lokier <jamie@shareable.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, davem@redhat.com
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-ID: <20030816155110.GH325@waste.org>
References: <20030815221211.GA4306@think> <Mutt.LNX.4.44.0308160927070.30515-100000@excalibur.intercode.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Mutt.LNX.4.44.0308160927070.30515-100000@excalibur.intercode.com.au>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 16, 2003 at 09:35:24AM +1000, James Morris wrote:
> On Fri, 15 Aug 2003, Theodore Ts'o wrote:
> 
> > > d) not disable preemption for long stretches while hashing (a
> > >    limitation of cryptoapi)
> > 
> > Sounds like a bug in CryptoAPI that should be fixed in CryptoAPI.
> 
> This is for the case of hashing from a per cpu context, which is an
> inherently unsafe context for introducing schedule points.  This is not
> a crypto API specific problem.

Yes, but it's introduced by the requirements imposed by cryptoapi. The
current code uses the stack (though currently rather a lot of it),
which lets it be fully re-entrant. Not an option with cryptoapi.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
