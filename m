Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261392AbVADMJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbVADMJg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 07:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbVADMJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 07:09:35 -0500
Received: from mail45.messagelabs.com ([140.174.2.179]:19105 "HELO
	mail45.messagelabs.com") by vger.kernel.org with SMTP
	id S261392AbVADMJO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 07:09:14 -0500
X-VirusChecked: Checked
X-Env-Sender: justin.piszcz@mitretek.org
X-Msg-Ref: server-20.tower-45.messagelabs.com!1104840551!9045869!1
X-StarScan-Version: 5.4.5; banners=-,-,-
X-Originating-IP: [66.10.26.57]
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: Kernel 2.6.10 kernel BUG at fs/inode.c:250!
Date: Tue, 4 Jan 2005 07:09:10 -0500
Message-ID: <2E314DE03538984BA5634F12115B3A4E01BC420B@email1.mitretek.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Kernel 2.6.10 kernel BUG at fs/inode.c:250!
Thread-Index: AcTyVjK+fTMZRQ80Q1GS2Vbvr/j+TQ==
From: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Under VMware Workstation 4.5.2 build-8848:

Using Debian Sarge 3.1rc2 under VMware with XFS as the filesystem.

Any ideas?

------------[ cut here ]------------
kernel BUG at fs/inode.c:250!
invalid operand: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<c0161541>]    Not tainted VLI
EFLAGS: 00010202   (2.6.10)
EIP is at clear_inode+0x21/0xe0
eax: 00000080   ebx: cd430cfc   ecx: 00001000   edx: cd430cfc
esi: 00000000   edi: cd430cfc   ebp: cb829f70   esp: cb829f2c
ds: 007b   es: 007b   ss: 0068
Process apt-get (pid: 6484, threadinfo=cb828000 task=d69850a0)
Stack: cd430cfc cd430cfc 00000000 c016256a cd430cfc 00000000 00000000
cd430cfc c224a000 c0162783 cd430cfc c04cb4e0 00000000 c01581d3 cd430cfc
d59eea6c d59eea6c d59eeaf4 dfee4280 24cfc0ad 0000000c c224a00f 00000010
00000000
Call Trace:
 [<c016256a>] generic_delete_inode+0xda/0x110
 [<c0162783>] iput+0x63/0x90
 [<c01581d3>] sys_unlink+0xd3/0x130
 [<c0147bf9>] filp_close+0x59/0x90
 [<c0147c91>] sys_close+0x61/0xa0
 [<c01024ff>] syscall_call+0x7/0xb
Code: b4 4c c0 eb c4 90 8d 74 26 00 83 ec 0c 89 5c 24 04 8b 5c 24 10 89
74 24 08 89 1c 24 e8 59 92 fe ff 8b 83 c0 00 00 00 85 c0 74 08 <0f> 0b
fa 00 d9 de 3c c0 8b 83 04 01 00 00 a8 10 75 08 0f 0b fc
