Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265547AbUBPNul (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 08:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265540AbUBPNuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 08:50:20 -0500
Received: from arhont1.eclipse.co.uk ([81.168.98.121]:19136 "EHLO
	pingo.core.arhont.com") by vger.kernel.org with ESMTP
	id S265547AbUBPNs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 08:48:28 -0500
Message-ID: <4030CA24.1090106@arhont.com>
Date: Mon, 16 Feb 2004 13:48:20 +0000
From: Andrei Mikhailovsky <andrei@arhont.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.2 khubd oops
X-Enigmail-Version: 0.83.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.9 (----)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

If anyone interested, I have an oops everytime i use and disconnect a
scanner device (Mustec 1200 UB Plus). Here is the dmesg output. (If
required, I can produce more debuging output).

hub 3-1:1.0: new USB device on port 2, assigned address 3
drivers/usb/image/scanner.c: USB scanner device (0x05d8/0x4002) now
attached to usb/scanner0
usb 3-1.2: USB disconnect, address 3
Unable to handle kernel NULL pointer dereference at virtual address 0000001e
~ printing eip:
e18b10dc
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<e18b10dc>]    Tainted: PF
EFLAGS: 00010282
EIP is at disconnect_scanner+0x2c/0x69 [scanner]
eax: c28dd9c0   ebx: c28dd9d4   ecx: e18b10b0   edx: 00000002
esi: 00000000   edi: cf72b0e8   ebp: e18b4bfc   esp: dfe11e50
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 5, threadinfo=dfe10000 task=c151c040)
Stack: c28dd9c0 e18b4c78 c28dd9c0 e18b4ce0 c02a02db c28dd9c0 c28dd9c0
c28dda00
~       c28dd9d4 e18b4d00 c0258854 c28dd9d4 c28dda00 cf72b0fc cf72b0c0
e18b0a5f
~       c28dd9d4 c28dd9c0 cf72b0fc e18b4c0c 00000000 00000000 c020c0f8
cf72b0fc
Call Trace:
~ [<c02a02db>] usb_unbind_interface+0x7b/0x80
~ [<c0258854>] device_release_driver+0x64/0x70
~ [<e18b0a5f>] destroy_scanner+0x4f/0xb0 [scanner]
~ [<c020c0f8>] kobject_cleanup+0x98/0xa0
~ [<c02a02db>] usb_unbind_interface+0x7b/0x80
~ [<c0258854>] device_release_driver+0x64/0x70
~ [<c0258985>] bus_remove_device+0x55/0xa0
~ [<c02578bd>] device_del+0x5d/0xa0
~ [<c02a68ff>] usb_disable_device+0x6f/0xb0
~ [<c02a0d26>] usb_disconnect+0x96/0xf0
~ [<c02a349f>] hub_port_connect_change+0x30f/0x320
~ [<c02a2dd3>] hub_port_status+0x43/0xb0
~ [<c02a377a>] hub_events+0x2ca/0x340
~ [<c02a381d>] hub_thread+0x2d/0xf0
~ [<c010925e>] ret_from_fork+0x6/0x14
~ [<c011bb60>] default_wake_function+0x0/0x20
~ [<c02a37f0>] hub_thread+0x0/0xf0
~ [<c0107289>] kernel_thread_helper+0x5/0xc

Code: 80 7e 1e 00 75 2a 85 f6 74 1a 8d 46 3c 8b 5c 24 08 8b 74 24



- --
Andrei Mikhailovsky
Arhont Ltd

Web: http://www.arhont.com
Tel: +44 (0)870 4431337
Fax: +44 (0)1454 201200
PGP: Key ID - 0xFF67A4F4
PGP: Server - keyserver.pgp.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFAMMoj5bSBOf9npPQRAlGcAJ4lJ2MCTfUDNWCR/ugegOgI4ZGoFwCeJVk1
2lD9W7BFiUqEkFyUXHdhkes=
=GUeK
-----END PGP SIGNATURE-----
