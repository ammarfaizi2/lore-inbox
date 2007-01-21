Return-Path: <linux-kernel-owner+w=401wt.eu-S1751479AbXAUMhA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbXAUMhA (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 07:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751533AbXAUMhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 07:37:00 -0500
Received: from server077.de-nserver.de ([62.27.12.245]:33308 "EHLO
	server077.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbXAUMg7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 07:36:59 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Jan 2007 07:36:58 EST
Message-ID: <45B35CD7.4080801@profihost.com>
Date: Sun, 21 Jan 2007 13:30:15 +0100
From: Stefan Priebe - FH <studium@profihost.com>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: stefan@priebe.ws
Subject: XFS or Kernel Problem / Bug
References: <20060801141545.B2326184@wobbly.melbourne.sgi.com> <44CED76B.20507@profihost.com> <20060801142755.C2326184@wobbly.melbourne.sgi.com> <44CED8F4.9080208@profihost.com> <20060801143212.D2326184@wobbly.melbourne.sgi.com> <44CEDA1D.5060607@profihost.com> <20060801143803.E2326184@wobbly.melbourne.sgi.com> <44CF36FB.6070606@profihost.com> <20060802090915.C2344877@wobbly.melbourne.sgi.com> <44D07AB7.3020409@profihost.com> <20060802201805.A2360409@wobbly.melbourne.sgi.com>
In-Reply-To: <20060802201805.A2360409@wobbly.melbourne.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-User-Auth: Auth by hostmaster@profihost.com through 91.3.6.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I've 3 Servers which works wonderful with 2.6.16.X (also testet the
latest 2.6.16.37)

but with 2.6.18.6 i get these errors:

"general protection fault: 0000 [#1]"
"Modules linked in:"
"CPU:    0"
"EIP:    0060:[<c01c8fd2>]    Not tainted VLI"
"EFLAGS: 00010246   (2.6.18.6 #1) "
"EIP is at xfs_bmap_add_extent_hole_delay+0x58d/0x59b"
"eax: 00000000   ebx: fffe0007   ecx: 0071a4cd   edx: 00000000"
"esi: 00000000   edi: 00000000   ebp: 00000015   esp: ce35f8f0"
"ds: 0000   es: 007b   ss: 0068"
"Process mysqld (pid: 1836, ti=ce35e000 task=ee618550 task.ti=ce35e000)"
"Stack: 00000232 00000000 00000233 00000000 00000000 00000000 0000000c
00000000 "
"       00000007 00000000 eca90250 eca90278 00000001 eca90200 00000000
000003c3 "
"       00000000 010003c3 ffffffc0 ce35fa58 ce35fa58 00000001 00000000
00000000 "
"Call Trace:"
" [<c01b6c58>] xfs_trans_dqresv+0x3f9/0x405"
" [<c01c6485>] xfs_bmap_add_extent+0x163/0x377"
" [<c01cd2c3>] xfs_bmapi+0xa4e/0x1109"
" [<c01ebbe3>] xfs_iomap_write_delay+0x233/0x2fa"
" [<c01eaa31>] xfs_imap_to_bmap+0x29/0x1d6"
" [<c01eae1a>] xfs_iomap+0x23c/0x3e1"
" [<c01eaebe>] xfs_iomap+0x2e0/0x3e1"
" [<c020a71a>] xfs_bmap+0x1a/0x1e"
" [<c020471e>] __xfs_get_blocks+0x5d/0x195"


and sometimes this one:

"BUG: unable to handle kernel NULL pointer dereference at virtual
address 00000288"
" printing eip:"
"c0142ff7"
"*pde = 00000000"
"Oops: 0000 [#1]"
"SMP "
"Modules linked in: iptable_filter ip_tables x_tables"
"CPU:    0"
"EIP:    0060:[<c0142ff7>]    Not tainted VLI"
"EFLAGS: 00010246   (2.6.18.6 #1) "
"EIP is at generic_file_buffered_write+0x390/0x6cf"
"eax: 00000000   ebx: 000001ec   ecx: ea029a40   edx: 00008002"
"esi: 00000000   edi: e3b28c9c   ebp: 000001ec   esp: dd04bd18"
"ds: 007b   es: 007b   ss: 0068"
"Process proftpd (pid: 3615, ti=dd04a000 task=eba88a70 task.ti=dd04a000)"
"Stack: e3b28d44 00000001 00000010 000001fc c036d793 000001fc c14765c0
00000010 "
"       080d404c 000001ec e3b28c9c c03e78c0 e3b28d44 ea029a40 000001fc
00000000 "
"       00000000 000001ec dd04beac 00d420b1 00000000 00000000 dd04bd80
45b1fa67 "
"Call Trace:"
" [<c036d793>] sock_def_readable+0x7f/0x81"
" [<c017a03a>] file_update_time+0xad/0xcb"
" [<c0232015>] xfs_iunlock+0x55/0x9f"
" [<c0262eeb>] xfs_write+0xa74/0xc61"
" [<c036a253>] sock_aio_read+0x95/0x99"
" [<c025d9fb>] xfs_file_aio_write+0x8f/0xa0"
" [<c015fb94>] do_sync_write+0xc9/0x10f"
" [<c0133ad6>] autoremove_wake_function+0x0/0x57"
" [<c015f3d5>] generic_file_llseek+0x95/0xbc"
" [<c015facb>] do_sync_write+0x0/0x10f"
" [<c015fc80>] vfs_write+0xa6/0x179"
" [<c015fe24>] sys_write+0x51/0x80"
" [<c0102d3f>] syscall_call+0x7/0xb"

"Code: 04 89 10 8b 44 24 40 85 c0 0f 85 db 00 00 00 8b 5c 24 24 85 db 0f
88 c3 00 00 00 8b 4c 24 34 8b 51 18 f6 c6 10 75 73 8b 7c 24 28 <8b> 85
9c 00 00 00 f6 40 30 10 75 63 f6 87 48 01 00 00 01 75 5a "

"EIP: [<c0142ff7>] generic_file_buffered_write+0x390/0x6cf SS:ESP
0068:dd04bd18"

Stefan

