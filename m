Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266467AbUIOPfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266467AbUIOPfZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 11:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266474AbUIOPfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 11:35:25 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:56151 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266467AbUIOPfR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 11:35:17 -0400
Message-ID: <9e47339104091508354280713c@mail.gmail.com>
Date: Wed, 15 Sep 2004 11:35:16 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] DRM: add missing pci_enable_device()
Cc: Dave Airlie <airlied@linux.ie>, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, Evan Paul Fletcher <evanpaul@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1095250966.19930.25.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200409131651.05059.bjorn.helgaas@hp.com>
	 <Pine.LNX.4.58.0409140026430.15167@skynet>
	 <200409140845.59389.bjorn.helgaas@hp.com>
	 <Pine.LNX.4.58.0409150008130.23838@skynet>
	 <9e47339104091416416b9ae310@mail.gmail.com>
	 <1095250966.19930.25.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2004 13:22:48 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Mer, 2004-09-15 at 00:41, Jon Smirl wrote:
> > pci_enable/disable_device are correct in the dyn-minor patch. They
> > also appear to correct in the currently checked in DRM cvs. If fbdev
> > is loaded DRM does not do pci_enable/disable_device. It is assumed
> > that these calls are handled by the fbdev device.
> 
> If you are calling pci_disable_device at all in the fb driver or DRI
> driver it is wrong, always wrong, always will be wrong for the main
> head. The video device is almost unique in that when you unload all
> the video drivers vgacon still owns and is using it. On some devices
> that needs PCI master enabled because of internal magic (like
> rendering text modes from the bios via SMM traps)
> 

How do I trigger this mode on a card supported by DRM so that we can test it?

-- 
Jon Smirl
jonsmirl@gmail.com
