Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261609AbULPQq2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbULPQq2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 11:46:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbULPQq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 11:46:28 -0500
Received: from mailr.eris.qinetiq.com ([128.98.1.9]:34716 "HELO
	mailr.qinetiq-tim.net") by vger.kernel.org with SMTP
	id S261609AbULPQo6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 11:44:58 -0500
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: linux-kernel@vger.kernel.org
Subject: kernel oops on 2.6.3
Date: Thu, 16 Dec 2004 16:50:44 +0000
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200412161650.44171.m.watts@eris.qinetiq.com>
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.29.0.5; VDF: 6.29.0.20; host: mailr.qinetiq-tim.net)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


One of my servers (Running Mandrake 10.0/2.6.3) has taken to giving the 
following oops whenever certian scripts are run:


Dec 16 16:12:25 server kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 000007a4
Dec 16 16:12:25 server kernel:  printing eip:
Dec 16 16:12:25 server kernel: c0215017
Dec 16 16:12:25 server kernel: *pde = 2a644001
Dec 16 16:12:25 server kernel: Oops: 0000 [#1]
Dec 16 16:12:25 server kernel: CPU:    0
Dec 16 16:12:25 server kernel: EIP:    0060:[init_dev+39/1360]    Not tainted 
VLI
Dec 16 16:12:25 server kernel: EIP:    0060:[<c0215017>]    Not tainted VLI
Dec 16 16:12:25 server kernel: EFLAGS: 00010246
Dec 16 16:12:25 server kernel: EIP is at init_dev+0x27/0x550
Dec 16 16:12:25 server kernel: eax: 00000024   ebx: c046cd80   ecx: c039f0fc   
edx: 000001e0
Dec 16 16:12:25 server kernel: esi: ea881000   edi: ea7943a0   ebp: ea721edc   
esp: ea721e90
Dec 16 16:12:25 server kernel: ds: 007b   es: 007b   ss: 0068
Dec 16 16:12:25 server kernel: Process update.sh (pid: 8113, 
threadinfo=ea720000 task=f63a0080)
Dec 16 16:12:25 server kernel: Stack: 000001e0 00299a31 00000003 ea721ef8 
ea721f68 f7a0b3c0 00000000 00000000
Dec 16 16:12:25 server kernel:        000021b6 ea721ec0 c0137357 00000000 
ea721ed8 c017119b 00000000 00000006
Dec 16 16:12:25 server kernel:        c046cd80 ea881000 ea7943a0 ea721f10 
c0215ef6 ea881000 000001e0 ea721efc
Dec 16 16:12:25 server kernel: Call Trace:
Dec 16 16:12:25 server kernel:  [in_group_p+39/48] in_group_p+0x27/0x30
Dec 16 16:12:25 server kernel:  [<c0137357>] in_group_p+0x27/0x30
Dec 16 16:12:25 server kernel:  [vfs_permission+267/320] 
vfs_permission+0x10b/0x140
Dec 16 16:12:25 server kernel:  [<c017119b>] vfs_permission+0x10b/0x140
Dec 16 16:12:25 server kernel:  [tty_open+246/880] tty_open+0xf6/0x370
Dec 16 16:12:25 server kernel:  [<c0215ef6>] tty_open+0xf6/0x370
Dec 16 16:12:25 server kernel:  [chrdev_open+216/496] chrdev_open+0xd8/0x1f0
Dec 16 16:12:25 server kernel:  [<c016cb78>] chrdev_open+0xd8/0x1f0
Dec 16 16:12:25 server kernel:  [get_empty_filp+93/224] 
get_empty_filp+0x5d/0xe0
Dec 16 16:12:25 server kernel:  [<c0163f3d>] get_empty_filp+0x5d/0xe0
Dec 16 16:12:25 server kernel:  [dentry_open+314/480] dentry_open+0x13a/0x1e0
Dec 16 16:12:25 server kernel:  [<c016249a>] dentry_open+0x13a/0x1e0
Dec 16 16:12:25 server kernel:  [filp_open+90/96] filp_open+0x5a/0x60
Dec 16 16:12:25 server kernel:  [<c016235a>] filp_open+0x5a/0x60
Dec 16 16:12:25 server kernel:  [sys_open+85/160] sys_open+0x55/0xa0
Dec 16 16:12:25 server kernel:  [<c01627b5>] sys_open+0x55/0xa0
Dec 16 16:12:25 server kernel:  [sysenter_past_esp+82/113] 
sysenter_past_esp+0x52/0x71
Dec 16 16:12:25 server kernel:  [<c010b3f1>] sysenter_past_esp+0x52/0x71
Dec 16 16:12:25 server kernel:
Dec 16 16:12:25 server kernel: Code: 00 00 00 00 55 89 e5 57 56 53 83 ec 40 8b 
45 0c c7 45 cc 00 00 00 00 8b 75 08 89 04 24 e8 a2 ff ff ff 8b 86 a4 00 00 00 
8b 55 0c <8b> 1c 90 85 db 74
 42 8b 83 a0 00 00 00 a9 80 00 00 00 0f 85 d7

update.sh is a bash script which ultimatly rsync's a few files to two other 
servers.
It is called from some Java code by Tomcat5 and is invoked via sudo.
Up until yesterday this has worked just fine when it was the 'ant' process 
that gets called before this script that causes the oops.

The server is a Dell PowerEdge 1750 with an LSI perc 4 card and 2GB ram.

Does anyone have an idea what might be causing this oops?

Whatever it is, it takes the machine out in a nasty way - you can no-longer 
make any new connections to the box but if you still have an ssh session you 
can do certain things, but launching any new processes (eg: top) causes that 
session to freeze.

I'd rather not have to upgrade the kernel, although if it is a kernel issue I 
may have to.

Regards,

Mark.

- -- 
Mark Watts
Senior Systems Engineer
QinetiQ Trusted Information Management
Trusted Solutions and Services group
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBwbzkBn4EFUVUIO0RAuZLAKDW/g7l5C981yqoGcWpLRKmtn3VkACfQL+i
UW7Dk3wRFpurw1n6KZK1nG4=
=9bb0
-----END PGP SIGNATURE-----
