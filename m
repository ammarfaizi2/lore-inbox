Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263830AbTKFVkr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 16:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263846AbTKFVkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 16:40:46 -0500
Received: from hal-5.inet.it ([213.92.5.24]:36813 "EHLO hal-5.inet.it")
	by vger.kernel.org with ESMTP id S263830AbTKFVko (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 16:40:44 -0500
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: test9 and bluetooth
Date: Thu, 6 Nov 2003 22:40:38 +0100
User-Agent: KMail/1.5.4
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200311021853.47300.cova@ferrara.linux.it> <1068031899.10388.180.camel@pegasus>
In-Reply-To: <1068031899.10388.180.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200311062240.38099.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 12:31, mercoledì 05 novembre 2003, Marcel Holtmann ha scritto:

>
> please try this with a non SMP kernel and/or a non preempt kernel. Do
> you have enabled the Bluetooth SCO support for the HCI USB driver?

As said I've tried 2.6.0-test9 [UP, SMP] preemp and SMP non preempt, all with 
the same behaviour, that means immediate machine freeze whenever the usb 
bluetooth dongle is removed from USB port. 
I've also got crashes whenever I've turned off the machine, with bluetooth and 
hci_usb modules loaded.
I've wrote down the message (by hand, so errors are possible) , hoping that 
this can help. If it's possible to get the full message, please let me know, 
a part of it has scrolled out of the screen (i can use a serial port 
terminal, if needed).

here is the trace:

uhci_irq+0x67/0x16c [uhci_hcd]
do_IRQ+0xC1/0x141
usb_hcd_irq+0x36/0x5f
handle_IRQ_event+0x3a/0x64
do_IRQ+0x95/0x141
common_interrupt+0x18/0x20
poll_freewait+0x2/0x40
sys_poll+0x252/0x288
--pollwait+0x0/0xc7
syscall_call+0x7/0xb

Code: 89 79 34 89 47 04 89 02 89 50 04 C6 85 14 02 00 00 01 53 9d
<0> Kernel panic: Fatal exception in interrupt
Interrupt handler - not syncing

Hope this help,
Regards


-- 
Fabio Coatti       http://www.ferrara.linux.it/members/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.

