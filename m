Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264416AbTLGMke (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 07:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264423AbTLGMkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 07:40:17 -0500
Received: from main.gmane.org ([80.91.224.249]:56508 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264416AbTLGMkL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 07:40:11 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: 2.6.0-test11 modules-trouble
Date: Sun, 7 Dec 2003 12:26:28 +0000 (UTC)
Message-ID: <slrnbt673j.ej3.adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: slrn/0.9.7.4 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2.6.0-test11 is running fine on one box (Debian unstable).

Trying to put another box to 2.6.0-test11 failes because modules
cannot get loaded:

------------[ cut here ]------------
kernel BUG at kernel/module.c:1021!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c012b7e4>]    Not tainted
EFLAGS: 00010246
EIP is at sys_init_module+0x604/0x13e0
eax: 00000000   ebx: 00000001   ecx: c1269f1c   edx: c0259630
esi: c8808600   edi: c023f207   ebp: 0804e0d0   esp: c1269e6c
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 21, threadinfo=c1268000 task=c12eed00)
Stack: c11a42d8 c11a0220 c11a42c0 c11b68a0 c7da4220 c0186005 c11a0220 c11a42c0
       00000002 c7df8e80 c1250de0 0000000f c1250e6c 00000003 c1268000 00000286
       c7da4220 c1269ec8 00000246 c1268000 c11a42c0 c7da4220 00000000 c8808380
Call Trace:
 [<c0186005>] journal_dirty_metadata+0x105/0x1c0
 [<c013b689>] __vma_link+0x29/0xa0
 [<c013b74a>] vma_link+0x4a/0x80
 [<c013c803>] do_mmap_pgoff+0x343/0x620
 [<c014693c>] filp_close+0x3c/0x80
 [<c01469d0>] sys_close+0x50/0xa0
 [<c0108027>] syscall_call+0x7/0xb

Code: 0f 0b fd 03 62 f1 23 c0 ff b4 24 b0 00 00 00 bb f8 ff ff ff

This happens when I try to modprobe/mount ext2, loading of any other
module isn't possible afterwards.


-- 
mail: adi@thur.de  	http://adi.thur.de	PGP: v2-key via keyserver

Geht die Sonne auf im Westen, muﬂt du deinen Kompaﬂ testen

