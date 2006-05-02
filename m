Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751243AbWEBJ6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbWEBJ6n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 05:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWEBJ6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 05:58:43 -0400
Received: from orfeus.profiwh.com ([82.100.20.117]:5905 "EHLO
	orfeus.profiwh.com") by vger.kernel.org with ESMTP id S1751243AbWEBJ6m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 05:58:42 -0400
Message-ID: <44572D5E.3020100@gmail.com>
Date: Tue, 02 May 2006 11:58:31 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: "Robert F. Merrill" <rfm@CSUA.Berkeley.EDU>
CC: linux-kernel@vger.kernel.org
Subject: locking bug
References: <200605020742.k427gj7W022835@soda.csua.berkeley.edu>
In-Reply-To: <200605020742.k427gj7W022835@soda.csua.berkeley.edu>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
X-SpamReason: {Bypass=00}-{0,00}-{0,00}-{0,00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Robert F. Merrill napsal(a):
> ------------[ cut here ]------------
> kernel BUG at fs/locks.c:1932!
> invalid operand: 0000 [#8]
> SMP 
> Modules linked in: thermal fan button processor ac battery nfs lockd nfs_acl sunrpc ipv6 quota_v1 ide_cd cdrom generic joydev evdev e1000 mousedev piix psmouse i2c_i801 serio_raw pcspkr i2c_core ide_core floppy rtc uhci_hcd ehci_hcd usbcore parport_pc parport shpchp pci_hotplug
> CPU:    0
> EIP:    0060:[<c015fe6a>]    Not tainted VLI
> EFLAGS: 00010246   (2.6.15.7-soda0) 
Is is possible to reproduce this in 2.6.16.latest kernel?
> EIP is at locks_remove_flock+0xbb/0xd7
> eax: d87f0cfc   ebx: ca0b0ebc   ecx: 00000000   edx: 00000000
> esi: cf340900   edi: ca0b0e18   ebp: c5d75834   esp: cb585efc
> ds: 007b   es: 007b   ss: 0068
> Process mutt (pid: 2295, threadinfo=cb585000 task=e29f2030)
> Stack: 00000000 00000000 00000000 00000000 00000000 cf340900 000008f7 00000000 
>        00000000 00000000 cf340900 00000202 00000000 00000000 ffffffff 7fffffff 
>        00000000 00000000 00000000 00000000 00000000 00000000 f6cb0b40 00000008 
> Call Trace:
>  [<c014da9d>] __fput+0x6d/0x125
>  [<c014c5ca>] filp_close+0x4e/0x57
>  [<c014c63b>] sys_close+0x68/0x7c
>  [<c01027b1>] syscall_call+0x7/0xb

regards,
- --
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEVy1eMsxVwznUen4RAmA9AKC4xe12APAaHOsFBMr5VqNt2s9YlACdHDbM
jaczIRplTICXzfJ/CGCu6J4=
=WrrO
-----END PGP SIGNATURE-----
