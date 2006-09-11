Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965035AbWIKWIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965035AbWIKWIU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 18:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965043AbWIKWIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 18:08:20 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:48320 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S965035AbWIKWIT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 18:08:19 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] 2.6.18-rc6-mm1
Date: Tue, 12 Sep 2006 00:08:19 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       USB development list <linux-usb-devel@lists.sourceforge.net>
References: <Pine.LNX.4.44L0.0609081636310.7953-100000@iolanthe.rowland.org> <200609090057.49518.rjw@sisk.pl>
In-Reply-To: <200609090057.49518.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609120008.19714.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 9 September 2006 00:57, Rafael J. Wysocki wrote:
> On Friday, 8 September 2006 22:44, Alan Stern wrote:
> > On Fri, 8 Sep 2006, Andrew Morton wrote:
> > 
> > > Alan, is this likely to be due to your USB PM changes?
> > 
> > It's possible.  Most of those changes are innocuous.  They add routines
> > that don't get used until a later patch.  However one of them might be
> > responsible.
> 
> Well, after recompiling the kernel for several times (because of a different
> problem) I'm no longer able to reproduce the problem.

Now I have another symtom: during the _second_ suspend the suspending of
USB controllers fails with messages like this:

usb_hcd_pci_suspend(): ehci_pci_suspend+0x0/0xab [ehci_hcd]() returns -22
pci_device_suspend(): usb_hcd_pci_suspend+0x0/0x16d [usbcore]() returns -22
suspend_device(): pci_device_suspend+0x0/0x4b() returns -22
Could not suspend device 0000:00:13.2: error -22

Could you please tell me which patches might have caused this, in your opinion?

Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
