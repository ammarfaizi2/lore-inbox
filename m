Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbUKMVPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbUKMVPV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 16:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbUKMVNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 16:13:06 -0500
Received: from mail.kroah.org ([69.55.234.183]:21708 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261173AbUKMVKw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 16:10:52 -0500
Date: Sat, 13 Nov 2004 13:10:38 -0800
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] More Driver Core patches for 2.6.10-rc1
Message-ID: <20041113211038.GA7060@kroah.com>
References: <20041112225850.GA6550@kroah.com> <Pine.LNX.4.58.0411131249340.12386@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411131249340.12386@ppc970.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 13, 2004 at 12:51:41PM -0800, Linus Torvalds wrote:
> 
> 
> On Fri, 12 Nov 2004, Greg KH wrote:
> > 
> > David Brownell:
> >   o driver core: shrink struct device a bit
> > 
> > Greg Kroah-Hartman:
> >   o driver core: fix up some missed power_state changes from David's patch
> 
> Hmm. Apparently drivers/ide/ppc/pmac.c wasn't among those fixed up:
> 
> 	drivers/ide/ppc/pmac.c: In function `pmac_ide_macio_suspend':
> 	drivers/ide/ppc/pmac.c:1363: error: structure has no member named `power_state'
> 	drivers/ide/ppc/pmac.c:1366: error: structure has no member named `power_state'
> 	...

Oops, sorry about that.

> Is it always valid to just replace
> 
> 	dev->dev.power_state
> 
> with
> 
> 	dev->dev.power.power_state

Yes it is.

> or is there anything subtler going on?

Nope, nothing subtle here :)

thanks,

greg k-h
