Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264915AbUDUF3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264915AbUDUF3m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 01:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264917AbUDUF3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 01:29:42 -0400
Received: from smtp808.mail.sc5.yahoo.com ([66.163.168.187]:13921 "HELO
	smtp808.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264915AbUDUF3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 01:29:40 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [OOPS] 2.6.6-rc2: OOPS unplugging USB hub
Date: Wed, 21 Apr 2004 00:29:37 -0500
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404210029.37876.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Keep getting the following OOPS when unpulling a hub from my laptop.
Has been happening in -rc1 also. 

Oops: 0002 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<e1b2b044>]    Tainted: P
EFLAGS: 00010246   (2.6.6-rc2)
EIP is at hiddev_cleanup+0x24/0x40 [usbhid]
eax: 00000060   ebx: d50a6060   ecx: 00000000   edx: e1871874
esi: e1b2fb60   edi: ca8d1c00   ebp: dfbe1e50   esp: dfbe1e44
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 433, threadinfo=dfbe0000 task=df11c810)
Stack: d50a607c e1b2fc5c c79f0000 dfbe1e64 e1b2aac8 d50a6060 e1b2fb60 c40aa460
       dfbe1e80 e1858106 c40aa460 c40aa460 c9ba9580 c40aa470 e1b2fb80 dfbe1e98
       c02108c6 c40aa470 c40aa498 c40aa470 ca8d1ccc dfbe1eb0 c0210a03 c40aa470
Call Trace:
 [<e1b2aac8>] hid_disconnect+0xb8/0xe0 [usbhid]
 [<e1858106>] usb_unbind_interface+0x76/0x80 [usbcore]
 [<c02108c6>] device_release_driver+0x66/0x70
 [<c0210a03>] bus_remove_device+0x53/0xa0
 [<c020f8dd>] device_del+0x5d/0xa0
 [<c020f934>] device_unregister+0x14/0x30
 [<e185e480>] usb_disable_device+0x70/0xb0 [usbcore]
 [<e1858d16>] usb_disconnect+0xa6/0x100 [usbcore]
 [<e1858d58>] usb_disconnect+0xe8/0x100 [usbcore]
 [<e185afef>] hub_port_connect_change+0x28f/0x2a0 [usbcore]
 [<e185a971>] hub_port_status+0x41/0xb0 [usbcore]
 [<e185b343>] hub_events+0x343/0x3b0 [usbcore]
 [<e185b3e5>] hub_thread+0x35/0xf0 [usbcore]
 [<c0115ef0>] default_wake_function+0x0/0x20
 [<e185b3b0>] hub_thread+0x0/0xf0 [usbcore]
 [<c01032e5>] kernel_thread_helper+0x5/0x10

Code: 89 0c 85 80 ff b2 e1 89 5d 08 8b 5d fc 89 ec 5d e9 17 03 61

-- 
Dmitry
