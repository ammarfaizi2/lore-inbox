Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264945AbTAJMnG>; Fri, 10 Jan 2003 07:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264673AbTAJMnG>; Fri, 10 Jan 2003 07:43:06 -0500
Received: from mail0.epfl.ch ([128.178.50.57]:6417 "HELO mail0.epfl.ch")
	by vger.kernel.org with SMTP id <S264945AbTAJMnD>;
	Fri, 10 Jan 2003 07:43:03 -0500
Date: Fri, 10 Jan 2003 13:49:37 +0100 (CET)
From: Pascal Junod <pascal.junod@epfl.ch>
X-X-Sender: pjunod@lasecpc10.epfl.ch
To: linux-kernel@vger.kernel.org
Subject: KERNEL BUG: assertion failure in reiserfs code
Message-ID: <Pine.LNX.4.44.0301101340520.1906-100000@lasecpc10.epfl.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My /tmp partition is using reiserfs and I get following message when
copying a large file on it (there is enough room, and fsck.reiserfs says
everything is ok...). Is this issue known ? My kernel version is the
linux-2.4.19-gentoo-r10 one.

Please CC me, as I am not on the list...

A+

Pascal

Jan 10 13:38:04 lasecpc29 kernel: reiserfs:warning: CONFIG_REISERFS_CHECK
is set ON
Jan 10 13:38:04 lasecpc29 kernel: reiserfs:warning: - it is slow mode for debugging.
Jan 10 13:38:04 lasecpc29 kernel: reiserfs: checking transaction log (device 03:06) ...
Jan 10 13:38:04 lasecpc29 kernel: journal-1153: found in header: first_unflushed_offset 871, last_flushed_trans_id 1231
Jan 10 13:38:04 lasecpc29 kernel: journal-1206: Starting replay from offset 871, trans_id 1232
Jan 10 13:38:04 lasecpc29 kernel: journal-1299: Setting newest_mount_id to 36
Jan 10 13:38:04 lasecpc29 kernel: Using r5 hash to sort names
Jan 10 13:38:04 lasecpc29 kernel: ReiserFS version 3.6.25
Jan 10 13:38:34 lasecpc29 kernel: vs-4010: is_reusable: block number is out of range 248999 (248999)
Jan 10 13:38:34 lasecpc29 kernel: 0: reiserfs_get_block
Jan 10 13:38:34 lasecpc29 kernel: reiserfs[3234]: assertion !(
(((((s)->u.reiserfs_sb.s_ap_bitmap)[i
])->b_state & (1UL << BH_Lock)) != 0) || is_reusable (s, search_start, 0)
== 0 ) failed at bitmap.c:
417:do_reiserfs_new_blocknrs: vs-4140: bitmap block is locked or bad block number found
Jan 10 13:38:34 lasecpc29 kernel: kernel BUG at prints.c:334!
Jan 10 13:38:34 lasecpc29 kernel: invalid operand: 0000
Jan 10 13:38:34 lasecpc29 kernel: CPU:    0
Jan 10 13:38:34 lasecpc29 kernel: EIP:    0010:[<c0188044>]    Not tainted
Jan 10 13:38:34 lasecpc29 kernel: EFLAGS: 00010282
Jan 10 13:38:34 lasecpc29 kernel: eax: 00000101   ebx: 00000000   ecx: 00000001   edx: d8aba000
Jan 10 13:38:34 lasecpc29 kernel: esi: 0003cca7   edi: 00000000   ebp: d8935dc4   esp: d8935cd8
Jan 10 13:38:34 lasecpc29 kernel: ds: 0018   es: 0018   ss: 0018
Jan 10 13:38:34 lasecpc29 kernel: Process scp (pid: 3234, stackpage=d8935000)
Jan 10 13:38:34 lasecpc29 kernel: Stack: c02748da c0334a20 c0282ae0 d8935cf8 ddb42c00 c01769c8 00000000 c0282ae0
Jan 10 13:38:34 lasecpc29 kernel:        00000ca2 000001a1 00000001 d8935dc4 00000007 00004ca7 00000007 0003cca6
Jan 10 13:38:34 lasecpc29 kernel:        db83f780 00000000 c0176caa d8935e08 d8935dc4 0003cca7 00000001 00000000
Jan 10 13:38:34 lasecpc29 kernel: Call Trace:    [<c01769c8>] [<c0176caa>] [<c017e326>] [<c021e36f>] [<c021e4a4>]
Jan 10 13:38:34 lasecpc29 kernel:   [<c017d7d6>] [<c01331ff>] [<c0133946>] [<c017e0ce>] [<c0180984>] [<c017e0ce>]
Jan 10 13:38:34 lasecpc29 kernel:   [<c01252e1>] [<c0131150>] [<c0108577>]
Jan 10 13:38:34 lasecpc29 kernel:
Jan 10 13:38:34 lasecpc29 kernel: Code: 0f 0b 4e 01 5e 94 27 c0 85 db 68 20 4a 33 c0 74 0d 0f b7 43

