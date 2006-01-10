Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbWAJP0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWAJP0s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 10:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbWAJP0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 10:26:48 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:23728 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751126AbWAJP0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 10:26:47 -0500
Date: Tue, 10 Jan 2006 10:26:46 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: LKML List <linux-kernel@vger.kernel.org>, <gregkh@suse.de>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] 2.6.15-mm2 allyesconfig build failure in
 drivers/usb/ip/
In-Reply-To: <9a8748490601100546s2dcf9a25hcfd369e397bd7938@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.0601101024210.5060-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jan 2006, Jesper Juhl wrote:

> allyesconfig currently doesn't build completely for me in 2.6.15-mm2
> 
> Here's what I did and the results :
> 
> 
> $ make allyesconfig
>  ...
> $ make -j 3
>  ...
>   CC      drivers/scsi/53c700.o
>   CC      net/sysctl_net.o
>   LD      net/xfrm/built-in.o
>   LD      net/built-in.o
>   LD      drivers/scsi/built-in.o
> make: *** [drivers] Error 2
> make: *** Waiting for unfinished jobs....
> $ make
>   CHK     include/linux/version.h
>   CHK     include/linux/compile.h
>   CHK     usr/initramfs_list
>   LD      drivers/usb/ip/built-in.o
> drivers/usb/ip/stub.o(.text+0xc7d): In function `usbip_pack_pdu':
> drivers/usb/ip/usbip_common.c:748: multiple definition of `usbip_pack_pdu'
> drivers/usb/ip/vhci-hcd.o(.text+0xc7d):drivers/usb/ip/usbip_common.c:748:
> first defined here

The usbip driver is very new and, oddly enough, also out-of-date.  Until
the maintainer can fix it, it should be marked BROKEN.

Alan Stern

