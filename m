Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265162AbUAORLn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 12:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265161AbUAORLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 12:11:42 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:31203 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id S265205AbUAORLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 12:11:17 -0500
Date: Thu, 15 Jan 2004 18:10:27 +0100
From: kladit@t-online.de (Klaus Dittrich)
To: sane-devel@lists.alioth.debian.org
Cc: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: linux-2.6.1-smp,usb,oops,sane-backends-1.0.13,epson-1640
Message-ID: <20040115171027.GA487@xeon2.local.here>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
X-Seen: false
X-ID: ZemVemZb8e3e+HaFh-1xzui7pERYd1mql6S8krvAYUv9nqYsknPkwS
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-2.6.1-smp,usb,oops,sane-backends-1.0.13,epson-1640

After power-up of the scanner sane-find-scanner finds the sanner.

sane-backends-1.0.13 scanimage -d epson:/dev/usb/scanner0 --test hangs.

After scanimage was killed  neither sane-find-scanner nor scanimage -L -d epson:/dev/usb/scanner0 
find the sanner again.

That is because of a oops of the usb-driver.

Jan 15 15:37:44 xeon2 kernel: usb 2-1: bulk timeout on ep1in
Jan 15 15:37:59 xeon2 kernel: usb 2-1: USB disconnect, address 2
Jan 15 15:38:17 xeon2 kernel: hub 2-0:1.0: new USB device on port 1, assigned address 3
Jan 15 15:38:18 xeon2 /sbin/hotplug: Detected usb product 4b8/10a/106
Jan 15 15:38:18 xeon2 /sbin/hotplug: detected Epson_Perfection_1640SU
Jan 15 15:38:18 xeon2 /sbin/hotplug:   /proc/bus/usb/002/003 
Jan 15 15:38:18 xeon2 /sbin/hotplug: Needed actions are done by the scanner driver of the kernel.
Jan 15 15:38:18 xeon2 kernel: drivers/usb/image/scanner.c: USB scanner device (0x04b8/0x010a) now attached to usb/scanner0
Jan 15 15:40:09 xeon2 kernel: usb 2-1: bulk timeout on ep1in
Jan 15 15:41:09 xeon2 kernel: usb 2-1: bulk timeout on ep1in
Jan 15 15:43:09 xeon2 kernel: usb 2-1: bulk timeout on ep1in
Jan 15 15:43:42 xeon2 kernel: request_module: failed /sbin/modprobe -- net-pf-10. error = 256
Jan 15 15:44:23 xeon2 kernel: usb 2-1: bulk timeout on ep1in
Jan 15 15:45:23 xeon2 kernel: usb 2-1: bulk timeout on ep1in
Jan 15 15:47:23 xeon2 kernel: usb 2-1: bulk timeout on ep1in
Jan 15 15:49:23 xeon2 kernel: usb 2-1: bulk timeout on ep1in
Jan 15 15:51:23 xeon2 kernel: usb 2-1: bulk timeout on ep1in
Jan 15 15:53:23 xeon2 kernel: usb 2-1: bulk timeout on ep1in
Jan 15 15:53:57 xeon2 kernel: drivers/usb/image/scanner.c: read_scanner(48): funky result:-71. Consult Documentation/usb/scanner.txt.
Jan 15 15:53:57 xeon2 kernel: usb 2-1: USB disconnect, address 3
Jan 15 15:53:57 xeon2 kernel: Unable to handle kernel NULL pointer dereference at virtual address 0000001e
Jan 15 15:53:57 xeon2 kernel:  printing eip:
Jan 15 15:53:57 xeon2 kernel: c03b0845
Jan 15 15:53:57 xeon2 kernel: *pde = 00000000
Jan 15 15:53:57 xeon2 kernel: Oops: 0000 [#1]
Jan 15 15:53:57 xeon2 kernel: CPU:    1
Jan 15 15:53:57 xeon2 kernel: EIP:    0060:[<c03b0845>]    Not tainted
Jan 15 15:53:57 xeon2 kernel: EFLAGS: 00010282
Jan 15 15:53:57 xeon2 kernel: EIP is at disconnect_scanner+0x2c/0x66
Jan 15 15:53:57 xeon2 kernel: eax: c26e1080   ebx: c26e1094   ecx: c03b0819   edx: 00000000
Jan 15 15:53:57 xeon2 kernel: esi: 00000000   edi: f6d729ac   ebp: c058e7dc   esp: f7d55e50
Jan 15 15:53:57 xeon2 kernel: ds: 007b   es: 007b   ss: 0068
Jan 15 15:53:57 xeon2 kernel: Process khubd (pid: 18, threadinfo=f7d54000 task=f7d57940)
Jan 15 15:53:57 xeon2 kernel: Stack: c26e1080 c058e858 c26e1080 c058e8c0 c0390d0b c26e1080 c26e1080 c26e10c0 
Jan 15 15:53:57 xeon2 kernel:        c26e1094 c058e8e0 c02d9a2b c26e1094 c26e10c0 f6d729c4 f6d72980 c03b01b6 
Jan 15 15:53:57 xeon2 kernel:        c26e1094 c26e1080 f6d729c4 c058e7f0 00000000 00000000 c026c843 f6d729c4 
Jan 15 15:53:57 xeon2 kernel: Call Trace:
Jan 15 15:53:57 xeon2 kernel:  [<c0390d0b>] usb_unbind_interface+0x7b/0x7d
Jan 15 15:53:57 xeon2 kernel:  [<c02d9a2b>] device_release_driver+0x64/0x66
Jan 15 15:53:57 xeon2 kernel:  [<c03b01b6>] destroy_scanner+0x51/0xa8
Jan 15 15:53:57 xeon2 kernel:  [<c026c843>] kobject_cleanup+0x98/0x9a
Jan 15 15:53:57 xeon2 kernel:  [<c0390d0b>] usb_unbind_interface+0x7b/0x7d
Jan 15 15:53:57 xeon2 kernel:  [<c02d9a2b>] device_release_driver+0x64/0x66
Jan 15 15:53:57 xeon2 kernel:  [<c02d9b52>] bus_remove_device+0x56/0x98
Jan 15 15:53:57 xeon2 kernel:  [<c02d8bf8>] device_del+0x5f/0x9d
Jan 15 15:53:57 xeon2 kernel:  [<c03971bb>] usb_disable_device+0x71/0xac
Jan 15 15:53:57 xeon2 kernel:  [<c03916f2>] usb_disconnect+0x9c/0xeb
Jan 15 15:53:57 xeon2 kernel:  [<c0393da1>] hub_port_connect_change+0x311/0x316
Jan 15 15:53:57 xeon2 kernel:  [<c03936f0>] hub_port_status+0x45/0xb0
Jan 15 15:53:57 xeon2 kernel:  [<c039408f>] hub_events+0x2e9/0x364
Jan 15 15:53:57 xeon2 kernel:  [<c0394137>] hub_thread+0x2d/0xe8
Jan 15 15:53:57 xeon2 kernel:  [<c010b2ce>] ret_from_fork+0x6/0x14
Jan 15 15:53:57 xeon2 kernel:  [<c01208aa>] default_wake_function+0x0/0x12
Jan 15 15:53:57 xeon2 kernel:  [<c039410a>] hub_thread+0x0/0xe8
Jan 15 15:53:57 xeon2 kernel:  [<c0109269>] kernel_thread_helper+0x5/0xb
Jan 15 15:53:57 xeon2 kernel: 
Jan 15 15:53:57 xeon2 kernel: Code: 80 7e 1e 00 75 27 85 f6 74 17 8d 46 44 8b 5c 24 08 8b 74 24 


No such problems with sane-backends-1.0.12. (yes I always removed all that was installed before)

Hope that help to fix the bugs. (please cc me, I'm not subscribed)

--
Klaus


~

~

