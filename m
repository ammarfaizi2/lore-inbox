Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263537AbUA0MHH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 07:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263522AbUA0MHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 07:07:07 -0500
Received: from mail.poliba.it ([193.204.49.50]:17373 "EHLO mail.poliba.it")
	by vger.kernel.org with ESMTP id S263462AbUA0MHB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 07:07:01 -0500
Date: Tue, 27 Jan 2004 13:07:09 +0100
From: "Angelo Dell'Aera" <buffer@antifork.org>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Linux-Net <linux-net@vger.kernel.org>
Subject: airo_cs problem - kernel 2.6.1
Message-Id: <20040127130709.50a3eaae.buffer@antifork.org>
Organization: Antifork Research, Inc.
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
X-PGP-Program: GNU Privacy Guard (http://www.gnupg.org)
X-PGP-PublicKey: http://buffer.antifork.org/privacy/buffer-gpg.asc
X-PGP-Fingerprint: 48CC B0D8 C394 CD30 355F E36D A4E3 48CF 19C1 5CA2
X-Operating-System: GNU-Linux
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Today I experienced this problem with a Cisco Aironet 350.
I just want to point out it's the first time it happens. 
In fact, I still used this NIC on this kernel (2.6.1) without 
any kind of problem. Attached is an extract from my log.


airo:  Probing for PCI adapters
Unable to handle kernel paging request at virtual address e0b397b8
 printing eip:
c01b524f
*pde = 1ed80067
*pte = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c01b524f>]    Not tainted
EFLAGS: 00010296
EIP is at kobject_add+0x6f/0x120
eax: c0350460   ebx: e0bd379c   ecx: e0b397b8   edx: e0bd37b8
esi: c0350468   edi: 00000000   ebp: e0bd3784   esp: d90b5f0c
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 3780, threadinfo=d90b4000 task=ca604080)
Stack: c0350468 e0bd37a0 e0bd379c e0bd379c e0bd379c 00000000 c01b5323 e0bd379c
       e0bd379c c0350400 e0bd379c c0350400 c0217a5a e0bd379c e0bd01e0 e0bd3760
       00000000 e0bd37f8 d90b4000 c0217f1f e0bd3784 e0bd10a3 d90b5f8c c017d388
Call Trace:
 [<c01b5323>] kobject_register+0x23/0x60
 [<c0217a5a>] bus_add_driver+0x4a/0xa0
 [<c0217f1f>] driver_register+0x2f/0x40
 [<c017d388>] create_proc_entry+0x88/0xd0
 [<c01bcecc>] pci_register_driver+0x5c/0x90
 [<e0b2d0d1>] airo_init_module+0xd1/0xf8 [airo]
 [<c01319bc>] sys_init_module+0x12c/0x250
 [<c01091a7>] syscall_call+0x7/0xb

Code: 89 11 89 4a 04 8b 43 28 8b 38 8d 4f 48 89 c8 ba ff ff 00 00
 <4>airo_cs: Unknown symbol init_airo_card
airo_cs: Unknown symbol stop_airo_card
airo_cs: Unknown symbol reset_airo_card
airo_cs: Unknown symbol init_airo_card
airo_cs: Unknown symbol stop_airo_card
airo_cs: Unknown symbol reset_airo_card


Regards.

- --

Angelo Dell'Aera 'buffer' 
Antifork Research, Inc.	  	http://buffer.antifork.org

PGP information in e-mail header


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAFlRtpONIzxnBXKIRAuhkAJ4xsLc4IBE65CPW+2tMG7g0XKbpGwCgixVY
nES3gWlgWnWlD3KGqM4wv8Q=
=PN9/
-----END PGP SIGNATURE-----
