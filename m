Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263428AbTDUDfl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 23:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263516AbTDUDfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 23:35:40 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:64711
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S263428AbTDUDfj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 23:35:39 -0400
Message-ID: <3EA369B7.5070905@redhat.com>
Date: Sun, 20 Apr 2003 20:47:03 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030420
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: oops with bk version as of 20030420T20:00:00-0700
X-Enigmail-Version: 0.74.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I got this oops right at startup time.  The machine is a UP P4 HT
(Northwood core).

VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 312k freed
Unable to handle kernel paging request at virtual address 2000006f
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<cffbea24>]    Not tainted
EFLAGS: 00010006
EIP is at 0xcffbea24
eax: 2000006f   ebx: 00000000   ecx: c032bc54   edx: 000041b0
esi: c0370000   edi: 00000400   ebp: 00000008   esp: c037bf74
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c037a000 task=c0328ac0)
Stack: c010ce5e 00000008 c037bf98 cffbea20 c010880e c037a000 c037a000
c010880e
       c010b3bc c010880e cfdb8800 c037a000 c037a000 c037a000 c010880e
00000000
       0000007b c032007b ffffff08 c0108838 00000060 00000246 c01088ae
00020809
Call Trace:
 [<c010ce5e>] do_IRQ+0x8c/0xf8
 [<c010880e>] default_idle+0x0/0x2d
 [<c010880e>] default_idle+0x0/0x2d
 [<c010b3bc>] common_interrupt+0x18/0x20
 [<c010880e>] default_idle+0x0/0x2d
 [<c010880e>] default_idle+0x0/0x2d
 [<c0108838>] default_idle+0x2a/0x2d
 [<c01088ae>] cpu_idle+0x39/0x42
 [<c0105000>] rest_init+0x0/0x52
 [<c037c83d>] start_kernel+0x18c/0x1b3
 [<c037c414>] unknown_bootoption+0x0/0xff


Code: 00 00 00 20 00 00 00 00 28 10 30 c0 00 00 00 00 00 00 00 00
 <0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing


- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+o2m32ijCOnn/RHQRAlVPAJ9fAkSPtDZMyH1chGvPfeTGTmvYvwCgwkHi
SjYAYTi9Uhx0E7nC+O7Y+E0=
=ap7S
-----END PGP SIGNATURE-----

