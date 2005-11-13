Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750838AbVKMTFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbVKMTFK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 14:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbVKMTFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 14:05:10 -0500
Received: from mail.kroah.org ([69.55.234.183]:6570 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750838AbVKMTFI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 14:05:08 -0500
Date: Sun, 13 Nov 2005 11:04:21 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Bernhard Rosenkraenzer <bero@arklinux.org>, linux-kernel@vger.kernel.org
Subject: Re: [partial patch] 2.6.14-mm2 bugs and fixes
Message-ID: <20051113190421.GA1520@kroah.com>
References: <200511131441.18443.bero@arklinux.org> <20051113105552.68705c3c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051113105552.68705c3c.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 13, 2005 at 10:55:52AM -0800, Andrew Morton wrote:
> Bernhard Rosenkraenzer <bero@arklinux.org> wrote:
> > drivers/usb/core/message.c no longer exports usb_get_string, this
> > breaks some external drivers (probably most notably ndiswrapper) --
> > attached patch #2 reverts this.
> 
> Agree.  We shouldn't be ripping out exported symbols with zero notice like
> this.  We have a process for doing this.

I had no idea no one else used this symbol, as nothing in-kernel does,
sorry.  Care to tell me why you need this function?  A USB driver should
not use it, but rather use the already-cached strings the USB core
provides for you.

thanks,

greg k-h
