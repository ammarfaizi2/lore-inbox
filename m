Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267323AbUIOSOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267323AbUIOSOL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 14:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267324AbUIOSNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 14:13:10 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:60866 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267325AbUIOSLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 14:11:45 -0400
Subject: Re: [PATCH] DRM: add missing pci_enable_device()
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Dave Airlie <airlied@linux.ie>, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, Evan Paul Fletcher <evanpaul@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <9e47339104091508354280713c@mail.gmail.com>
References: <200409131651.05059.bjorn.helgaas@hp.com>
	 <Pine.LNX.4.58.0409140026430.15167@skynet>
	 <200409140845.59389.bjorn.helgaas@hp.com>
	 <Pine.LNX.4.58.0409150008130.23838@skynet>
	 <9e47339104091416416b9ae310@mail.gmail.com>
	 <1095250966.19930.25.camel@localhost.localdomain>
	 <9e47339104091508354280713c@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095268058.19921.71.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 15 Sep 2004 18:07:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-09-15 at 16:35, Jon Smirl wrote:
> > the video drivers vgacon still owns and is using it. On some devices
> > that needs PCI master enabled because of internal magic (like
> > rendering text modes from the bios via SMM traps)
> > 
> How do I trigger this mode on a card supported by DRM so that we can test it?

I don't know which DRM supporting cards are affected and which platforms
will turn off enough for disable_device to break. I guess
vgacon will need a place in the vga class driver stuff that way the
"ISA" console space would always be owned ?

