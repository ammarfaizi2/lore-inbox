Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275667AbTHODvH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 23:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275674AbTHODvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 23:51:07 -0400
Received: from waste.org ([209.173.204.2]:4278 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S275667AbTHODvF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 23:51:05 -0400
Date: Thu, 14 Aug 2003 22:50:56 -0500
From: Matt Mackall <mpm@selenic.com>
To: James Morris <jmorris@intercode.com.au>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cryptoapi: Fix sleeping
Message-ID: <20030815035056.GW325@waste.org>
References: <20030814201847.GO325@waste.org> <Mutt.LNX.4.44.0308151337390.26882-100000@excalibur.intercode.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Mutt.LNX.4.44.0308151337390.26882-100000@excalibur.intercode.com.au>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 15, 2003 at 01:39:03PM +1000, James Morris wrote:
> On Thu, 14 Aug 2003, Matt Mackall wrote:
> 
> > Leaves no room actually. I figured this would be easy to move around
> > after the fact.
> 
> Ok.
> 
> > On the subject of flags, what's the best way for an algorithm init
> > function to get at the tfm structures (and thereby the flags) given a
> > ctxt? Pointer math on a ctxt?
> 
> The algorithms should not access the tfm structure.  In the case of 
> ciphers, we pass the tfm flags in via setkey.
> 
> What do you need this for?

This is back to turning off padding and getting at the raw hash
transforms, and we were talking about doing this via flags. The
FIPS-180-1 padding is done in sha1.c:digest which has no visibility to
such flags.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
