Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264667AbUD2UB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264667AbUD2UB2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 16:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264950AbUD2UB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 16:01:28 -0400
Received: from ida.rowland.org ([192.131.102.52]:12036 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S264667AbUD2T7k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 15:59:40 -0400
Date: Thu, 29 Apr 2004 15:59:36 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Soeren Sonnenburg <kernel@nn7.de>
cc: Marcel Holtmann <marcel@holtmann.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] 2.6.6-rc3 still oops on unplugging usb bluetooth
 bcm203x dongle
In-Reply-To: <1083218706.3942.5.camel@localhost>
Message-ID: <Pine.LNX.4.44L0.0404291557550.1314-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Apr 2004, Soeren Sonnenburg wrote:

> Hi...
> 
> I still get:
> 
> usb 2-1: USB disconnect, address 3
> Oops: kernel access of bad area, sig: 11 [#1]
> NIP: C02134B4 LR: F205D414 SP: EFE87DD0 REGS: efe87d20 TRAP: 0600    Not tainted
> MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> DAR: 6B6B6BB7, DSISR: 00000120
> TASK = effa4030[5] 'khubd' THREAD: efe86000Last syscall: -1 
> GPR00: FFFF0001 EFE87DD0 EFFA4030 EE77C828 6B6B6B6B 00000000 EB8EE83C 00000000 
> GPR08: 00001388 EF0EE858 00010C00 C0213480 82008022 00000000 00000000 00000000 
> GPR16: 00000000 00000000 00000000 00000000 00000000 00220000 00230000 00000000 
> GPR24: 00000000 C0400000 00000001 6B6B6B6B 6B6B6BB7 EF07B8A0 EE77C828 EE77C6FC 
> NIP [c02134b4] class_device_del+0x34/0x140
> LR [f205d414] hci_unregister_sysfs+0x14/0x24 [bluetooth]
> Call trace:
>  [f205d414] hci_unregister_sysfs+0x14/0x24 [bluetooth]
>  [f205876c] hci_unregister_dev+0x18/0xb0 [bluetooth]
>  [f204cd94] hci_usb_disconnect+0x48/0x90 [hci_usb]

Marcel Holtman is working on this; some other people have reported the 
same problem.  Have you been in touch with him?  It appears to be a 
problem in the Bluetooth driver, not in the USB stack.

Alan STern


