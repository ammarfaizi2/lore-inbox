Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265125AbTLKP6I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 10:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265136AbTLKP6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 10:58:08 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:62106 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S265125AbTLKP5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 10:57:50 -0500
Date: Thu, 11 Dec 2003 07:57:46 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 1671] New: when mount smbfs, gnome filemanager die
Message-ID: <1303950000.1071158266@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1671

           Summary: when mount smbfs, gnome filemanager die.
    Kernel Version: 2.6.0-test11
            Status: NEW
          Severity: normal
             Owner: fs_samba-smb@kernel-bugs.osdl.org
         Submitter: ganadist@chollian.net


Distribution: Gentoo 1.4
Hardware Environment: Athlon-XP 2500+ Nforce2 M/B 1GB ram
Software Environment: Glibc 2.3.2, gcc 3.3.2, binutils 2.14.90.0.7, GNOME cvs HEAD,
Problem Description: when I mount smbfs, nautilus crashed and kernel says like this.
 <5>smb_lookup: find //.Trash-ganadist failed, error=-5
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
00000000
*pde = 00000000
Oops: 0000 [#2]
CPU:    0
EIP:    0060:[<00000000>]    Tainted: P
EFLAGS: 00010246
EIP is at 0x0
eax: e739c280   ebx: f5b63f34   ecx: c0169780   edx: d7e7a280
esi: f5b63fa0   edi: c181adf8   ebp: d5dffc80   esp: f5b63f00
ds: 007b   es: 007b   ss: 0068
Process nautilus (pid: 24522, threadinfo=f5b62000 task=f5b68cc0)
Stack: f8e44c8d d5dffc80 f5b63fa0 c0169780 f5b63f34 00000000 00000002 00000004
       d0cae124 00000000 f3df3000 d7e7a280 d0df2180 007b7e7b 017656f2 007c7f7c
       00000000 00000000 f3df3000 00000002 00000000 00000000 00000001 00000004
Call Trace:
 [<f8e44c8d>] smb_readdir+0x4cd/0x6b0 [smbfs]
 [<c0169780>] filldir64+0x0/0x110
 [<c016949c>] vfs_readdir+0x9c/0xa0
 [<c0169780>] filldir64+0x0/0x110
 [<c01698ff>] sys_getdents64+0x6f/0xa9
 [<c0169780>] filldir64+0x0/0x110
 [<c010abc7>] syscall_call+0x7/0xb
 
Code:  Bad EIP value.

Steps to reproduce:
1. login gnome desktop
2. open terminal
3. mount smbfs


