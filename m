Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265681AbUFXVRR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265681AbUFXVRR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 17:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265654AbUFXVRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 17:17:17 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:39649 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S265681AbUFXVQy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 17:16:54 -0400
Subject: Oops with 2.6.7-bk
From: Marcel Holtmann <marcel@holtmann.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1088111809.4160.1.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 24 Jun 2004 23:16:49 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I got this oops on boot with the latest Bitkeeper snapshot of 2.6.7

NET: Registered protocol family 23
cs: IO port probe 0x0100-0x04ff: excluding 0x378-0x37f 0x4d0-0x4d7
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0a00-0x0aff: clean.
Unable to handle kernel paging request at virtual address e012fa84
 printing eip:
c015052f
*pde = 00000000
Oops: 0002 [#1]
Modules linked in: ds irda binfmt_misc yenta_socket pcmcia_core ehci_hcd ohci_hcd 8250_pci 8250 serial_core snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_mi
xer_oss snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd soundcore hci_usb bluetooth usbhid uhci_hcd usbcore intel_agp agpgart evdev nls_i
so8859_1 nls_cp437 vfat fat eth1394 st w83781d i2c_sensor i2c_i801 i2c_core ohci1394 ieee1394 sd_mod aic7xxx scsi_mod e100 mii unix
CPU:    0
EIP:    0060:[<c015052f>]    Not tainted
EFLAGS: 00010297   (2.6.7) 
EIP is at page_follow_link_light+0x2b/0x3b
eax: c0157ed4   ebx: dfbcff14   ecx: 00000017   edx: dc466000
esi: dc9445c8   edi: dfbcff14   ebp: 00000017   esp: dfbcfef0
ds: 007b   es: 007b   ss: 0068
Process tar (pid: 3346, threadinfo=dfbce000 task=dfb948c0)
Stack: dc9445c8 dfbcfef8 c1388cc0 00000000 c015022b dc9445c8 dfbcff14 dc9445c8 
       b96990f5 df5fd005 00000012 dffd5200 de3173cc 40db43b2 3ad56960 de317408 
       c0157ed4 de3173cc 00000001 dfbcff40 40db43b2 3ad56960 40db43b2 3ad56960 
Call Trace:
 [<c015022b>] generic_readlink+0x2a/0x84
 [<c0157ed4>] update_atime+0xd0/0xd5
 [<c0149f39>] sys_readlink+0xb1/0xb5
 [<c0103be3>] syscall_call+0x7/0xb
Code: 89 54 83 20 31 d2 89 d0 8b 5c 24 0c 83 c4 10 c3 83 ec 0c 89 

Regards

Marcel


