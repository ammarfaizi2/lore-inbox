Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932383AbWA0AsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbWA0AsO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 19:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbWA0AsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 19:48:13 -0500
Received: from mail.kroah.org ([69.55.234.183]:1935 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932383AbWA0AsN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 19:48:13 -0500
Date: Thu, 26 Jan 2006 16:47:46 -0800
From: Greg KH <greg@kroah.com>
To: Oskar Senft <osk-lkml@sirrix.de>
Cc: Aleksey Gorelov <Aleksey_Gorelov@Phoenix.com>,
       linux-kernel@vger.kernel.org
Subject: Re: USB host pci-quirks
Message-ID: <20060127004746.GA17030@kroah.com>
References: <0EF82802ABAA22479BC1CE8E2F60E8C3AA3641@scl-exch2k3.phoenix.com> <43D94F62.2090707@sirrix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43D94F62.2090707@sirrix.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2006 at 11:38:26PM +0100, Oskar Senft wrote:
> Dear Aleksey,
> 
> thank you for your e-mail!
> 
> >>Is there a special need, that the "drivers/usb/host/pci-quirks.c" is
> >>compiled into the kernel even if USB support is disabled?
> > 
> >   Yes, there is. USB handoff is necessary even if USB support is
> > disabled completely in kernel. In fact, initially early usb handoff code
> > was under pci, but since USB drivers do handoff anyway, it was decided
> > to move everything into usb with a goal of merging them together. 
> >   Just search for USB handoff in kernel archives.
> 
> I see ... but as David Brownell already stated on Thu Sep 02 2004 -
> 20:07:57 EST:
> For backwards compatibility, the early reset should not be the
> default. There aren't many systems where it's a problem.
> 
> What happened to that argument?

In the year and a half since then, we have changed our mind :)

A major distro has shipped for a while with this always enabled with no
problems, which has helped with this.

thanks,

greg k-h
