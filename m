Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbUCZVbn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 16:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbUCZVbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 16:31:43 -0500
Received: from hmarson.gotadsl.co.uk ([81.6.239.220]:51010 "EHLO
	ballbreaker.travellingkiwi.com") by vger.kernel.org with ESMTP
	id S261253AbUCZVba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 16:31:30 -0500
Message-ID: <4064A12E.7070502@travellingkiwi.com>
Date: Fri, 26 Mar 2004 21:31:26 +0000
From: hamish <hamish@travellingkiwi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Bug in Kernel 2.6.4?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all.

I got this message from my Kernel tonight when unplugging my USB 
BlueTooth adapter form my laptop. It WAS working fine, then suddenly 
after transferring about 10 files using kbtobexclient, I kept getting 
messgae about unable to connect transport frm the obex client software. 
Upon unplugging the adapter I got the following in my messages file...

Thought someone might be interested...


Mar 26 21:26:08 ballbreaker kernel: usb 1-1: USB disconnect, address 2
Mar 26 21:26:08 ballbreaker kernel: Call Trace:
Mar 26 21:26:08 ballbreaker kernel:  [kfree+741/1040] kfree+0x2e5/0x410
Mar 26 21:26:08 ballbreaker kernel:  [_end+543601752/1069281088] 
hci_usb_unlink_urbs+0xa8/0x110 [hci_usb]
Mar 26 21:26:08 ballbreaker kernel:  [_end+543601752/1069281088] 
hci_usb_unlink_urbs+0xa8/0x110 [hci_usb]
Mar 26 21:26:08 ballbreaker kernel:  [_end+543601907/1069281088] 
hci_usb_close+0x33/0x40 [hci_usb]
Mar 26 21:26:08 ballbreaker kernel:  [_end+543605030/1069281088] 
hci_usb_disconnect+0x26/0x90 [hci_usb]
Mar 26 21:26:08 ballbreaker kernel:  [_end+541663318/1069281088] 
usb_unbind_interface+0x76/0x80 [usbcore]
Mar 26 21:26:08 ballbreaker kernel:  [device_release_driver+102/112] 
device_release_driver+0x66/0x70
Mar 26 21:26:09 ballbreaker kernel:  [bus_remove_device+83/160] 
bus_remove_device+0x53/0xa0
Mar 26 21:26:09 ballbreaker kernel:  [device_del+93/160] 
device_del+0x5d/0xa0
Mar 26 21:26:09 ballbreaker kernel:  [_end+541687008/1069281088] 
usb_disable_device+0x70/0xb0 [usbcore]
Mar 26 21:26:09 ballbreaker kernel:  [_end+541666340/1069281088] 
usb_disconnect+0xa4/0x100 [usbcore]
Mar 26 21:26:09 ballbreaker kernel:  [_end+541674303/1069281088] 
hub_port_connect_change+0x27f/0x290 [usbcore]
Mar 26 21:26:09 ballbreaker kernel:  [_end+541672673/1069281088] 
hub_port_status+0x41/0xb0 [usbcore]
Mar 26 21:26:09 ballbreaker kernel:  [_end+541675016/1069281088] 
hub_events+0x2b8/0x310 [usbcore]
Mar 26 21:26:09 ballbreaker kernel:  [_end+541675157/1069281088] 
hub_thread+0x35/0x100 [usbcore]
Mar 26 21:26:09 ballbreaker kernel:  [default_wake_function+0/32] 
default_wake_function+0x0/0x20
Mar 26 21:26:09 ballbreaker kernel:  [_end+541675104/1069281088] 
hub_thread+0x0/0x100 [usbcore]
Mar 26 21:26:09 ballbreaker kernel:  [kernel_thread_helper+5/12] 
kernel_thread_helper+0x5/0xc
Mar 26 21:26:09 ballbreaker kernel:
Mar 26 21:26:09 ballbreaker kernel: ------------[ cut here ]------------
Mar 26 21:26:09 ballbreaker kernel: kernel BUG at mm/slab.c:1740!
Mar 26 21:26:09 ballbreaker kernel: invalid operand: 0000 [#1]
Mar 26 21:26:09 ballbreaker kernel: DEBUG_PAGEALLOC
Mar 26 21:26:09 ballbreaker kernel: CPU:    0
Mar 26 21:26:09 ballbreaker kernel: EIP:    0060:[kfree+635/1040]    Not 
tainted
Mar 26 21:26:09 ballbreaker kernel: EFLAGS: 00010002
Mar 26 21:26:09 ballbreaker kernel: EIP is at kfree+0x27b/0x410
Mar 26 21:26:09 ballbreaker kernel: eax: dbe83000   ebx: 80010c00   ecx: 
00001000   edx: 00000008
Mar 26 21:26:09 ballbreaker kernel: esi: dffef5c0   edi: dbe83000   ebp: 
debade50   esp: debade20
Mar 26 21:26:09 ballbreaker kernel: ds: 007b   es: 007b   ss: 0068
Mar 26 21:26:09 ballbreaker kernel: Process khubd (pid: 51, 
threadinfo=debac000 task=dec18a60)
Mar 26 21:26:09 ballbreaker kernel: Stack: dffef5c0 dbe83008 5a5a5a5a 
00000007 1be83008 e0aaa518 dbe83008 dffe0f78
Mar 26 21:26:09 ballbreaker kernel:        00000282 c2b1ff8c c2b1ff78 
db439fd0 debade74 e0aaa518 dbe83f40 db439fb0
Mar 26 21:26:09 ballbreaker kernel:        db439fd0 00000000 c28f2df8 
c28f2df8 c3041df8 debade84 e0aaa5b3 db439f38
Mar 26 21:26:09 ballbreaker kernel: Call Trace:
Mar 26 21:26:09 ballbreaker kernel:  [_end+543601752/1069281088] 
hci_usb_unlink_urbs+0xa8/0x110 [hci_usb]
Mar 26 21:26:09 ballbreaker kernel:  [_end+543601752/1069281088] 
hci_usb_unlink_urbs+0xa8/0x110 [hci_usb]
Mar 26 21:26:09 ballbreaker kernel:  [_end+543601907/1069281088] 
hci_usb_close+0x33/0x40 [hci_usb]
Mar 26 21:26:09 ballbreaker kernel:  [_end+543605030/1069281088] 
hci_usb_disconnect+0x26/0x90 [hci_usb]
Mar 26 21:26:09 ballbreaker kernel:  [_end+541663318/1069281088] 
usb_unbind_interface+0x76/0x80 [usbcore]
Mar 26 21:26:09 ballbreaker kernel:  [device_release_driver+102/112] 
device_release_driver+0x66/0x70
Mar 26 21:26:09 ballbreaker kernel:  [bus_remove_device+83/160] 
bus_remove_device+0x53/0xa0
Mar 26 21:26:09 ballbreaker kernel:  [device_del+93/160] 
device_del+0x5d/0xa0
Mar 26 21:26:09 ballbreaker kernel:  [_end+541687008/1069281088] 
usb_disable_device+0x70/0xb0 [usbcore]
Mar 26 21:26:09 ballbreaker kernel:  [_end+541666340/1069281088] 
usb_disconnect+0xa4/0x100 [usbcore]
Mar 26 21:26:09 ballbreaker kernel:  [_end+541674303/1069281088] 
hub_port_connect_change+0x27f/0x290 [usbcore]
Mar 26 21:26:09 ballbreaker kernel:  [_end+541672673/1069281088] 
hub_port_status+0x41/0xb0 [usbcore]
Mar 26 21:26:09 ballbreaker kernel:  [_end+541675016/1069281088] 
hub_events+0x2b8/0x310 [usbcore]
Mar 26 21:26:09 ballbreaker kernel:  [_end+541675157/1069281088] 
hub_thread+0x35/0x100 [usbcore]
Mar 26 21:26:09 ballbreaker kernel:  [default_wake_function+0/32] 
default_wake_function+0x0/0x20
Mar 26 21:26:09 ballbreaker kernel:  [_end+541675104/1069281088] 
hub_thread+0x0/0x100 [usbcore]
Mar 26 21:26:09 ballbreaker kernel:  [kernel_thread_helper+5/12] 
kernel_thread_helper+0x5/0xc
Mar 26 21:26:09 ballbreaker kernel:
Mar 26 21:26:09 ballbreaker kernel: Code: 0f 0b cc 06 e4 9a 32 c0 e9 e1 
fe ff ff 0f 0b cb 06 e4 9a 32

