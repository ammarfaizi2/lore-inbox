Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265126AbUAHPaN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 10:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265148AbUAHPaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 10:30:13 -0500
Received: from vsmtp2.tin.it ([212.216.176.222]:54716 "EHLO vsmtp2.tin.it")
	by vger.kernel.org with ESMTP id S265126AbUAHP3z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 10:29:55 -0500
From: andreamrl <andreamrl@tiscali.it>
Reply-To: andreamrl@tiscali.it
To: linux-kernel@vger.kernel.org
Subject: Oops in 2.6.1-rc1-mm2
Date: Thu, 8 Jan 2004 16:29:20 +0100
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_QdX//cRYHN33FBt"
Message-Id: <200401081629.20497.andreamrl@tiscali.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_QdX//cRYHN33FBt
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

When i stop to messing around with a sane backend and i disconnect the power 
cord of my USB scanner, system generates a kernel oops (kernel 
2.6.1-rc1-mm2). 
I attach the oops log hoping be useful.

Merello Andrea
andreamrl@tiscali.it
--Boundary-00=_QdX//cRYHN33FBt
Content-Type: text/plain;
  charset="us-ascii";
  name="oops"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="oops"

usb 3-2: USB disconnect, address 3
Unable to handle kernel NULL pointer dereference at virtual address 0000001e
 printing eip:
f18a624c
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<f18a624c>]    Tainted: PF  VLI
EFLAGS: 00010292
EIP is at disconnect_scanner+0x2c/0x6d [scanner]
eax: e8367780   ebx: e8367794   ecx: f18a6220   edx: 00000005
esi: 00000000   edi: ee7f9440   ebp: f18a9dbc   esp: efd41e44
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 5, threadinfo=efd40000 task=eff8e040)
Stack: e8367780 f18a9e38 e8367780 f18a9ea0 c02b8a0b e8367780 e8367780 e8367794
       e8367794 f18a9ec0 c0240e94 e8367794 e83677c0 ee7f947c ee7f9468 f18a5ba7
       e8367794 e8367780 ee7f947c f18a9dcc 00000000 00000000 c020afe8 ee7f947c
Call Trace:
 [<c02b8a0b>] usb_unbind_interface+0x7b/0x80
 [<c0240e94>] device_release_driver+0x64/0x70
 [<f18a5ba7>] destroy_scanner+0x77/0xd0 [scanner]
 [<c020afe8>] kobject_cleanup+0x98/0xa0
 [<c02b8a0b>] usb_unbind_interface+0x7b/0x80
 [<c0240e94>] device_release_driver+0x64/0x70
 [<c0241008>] bus_remove_device+0x78/0xc0
 [<c023fe9c>] device_del+0x6c/0xa0
 [<c02bef3f>] usb_disable_device+0x6f/0xb0
 [<c02b92ab>] usb_disconnect+0xbb/0x110
 [<c02bba6f>] hub_port_connect_change+0x32f/0x340
 [<c02bb353>] hub_port_status+0x43/0xb0
 [<c02bbdb8>] hub_events+0x338/0x3a0
 [<c02bbe4d>] hub_thread+0x2d/0xf0
 [<c0357a86>] ret_from_fork+0x6/0x14
 [<c011dba0>] default_wake_function+0x0/0x20
 [<c02bbe20>] hub_thread+0x0/0xf0
 [<c0109009>] kernel_thread_helper+0x5/0xc

Code: ec 10 8b 44 24 14 89 5c 24 08 89 74 24 0c 8d 58 14 8b 73 78 c7 44 24 04 38 9e 8a f1 89 04 24 e8 ab a4 a1 ce c7 43 78 00 00 00 00 <80> 7e 1e 00 75 2e 85 f6 74 17 8d 46 3c 8b 5c 24 08 8b 74 24 0c

--Boundary-00=_QdX//cRYHN33FBt--

