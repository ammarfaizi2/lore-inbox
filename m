Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317881AbSGKTik>; Thu, 11 Jul 2002 15:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317882AbSGKTij>; Thu, 11 Jul 2002 15:38:39 -0400
Received: from t6o53p79.telia.com ([212.181.176.199]:10375 "EHLO
	best.localdomain") by vger.kernel.org with ESMTP id <S317881AbSGKTii>;
	Thu, 11 Jul 2002 15:38:38 -0400
To: linux-kernel@vger.kernel.org
Cc: akpm@zip.com.au
Subject: 2.5.25: buffer layer error at buffer.c:406
From: Peter Osterlund <petero2@telia.com>
Date: 11 Jul 2002 21:40:15 +0200
Message-ID: <m2ofderr34.fsf@best.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I booted 2.5.25 I got the error "buffer layer error at
buffer.c:406". It happened three times within one second. After that it
didn't happen again. The error messages didn't seem to cause any harm.

I rebooted the machine, but the error didn't show up again. The only
difference was that on the first boot, the machine decided to run an
ext2 file system check.

All three back traces were identical:

c2391e08 00000196 00000000 c02dc6c0 c3f430c0 c013a0d0 c3f430c0 0029a000 
       00000000 00000000 00000000 00000800 0029a000 00000400 c013a4b5 c3f430c0 
       0029a000 00000000 00000800 00000005 00000400 c013aa37 00000000 c013aa67 
Call Trace: [<c013a0d0>] [<c013a4b5>] [<c013aa37>] [<c013aa67>] [<c012703a>] 
   [<c013b370>] [<c01618d0>] [<c01294af>] [<c01618d0>] [<c0123500>] [<c0137dbc>]
   [<c0125f85>] [<c0137eba>] [<c0106f17>] 
Warning (Oops_read): Code line not seen, dumping what data is available

Trace; c013a0d0 <__find_get_block+c0/e0>
Trace; c013a4b5 <unmap_underlying_metadata+15/50>
Trace; c013aa37 <__block_prepare_write+187/3e0>
Trace; c013aa67 <__block_prepare_write+1b7/3e0>
Trace; c012703a <__add_to_page_cache+1a/d0>
Trace; c013b370 <block_prepare_write+20/40>
Trace; c01618d0 <ext2_get_block+0/420>
Trace; c01294af <generic_file_write+5ff/7b0>
Trace; c01618d0 <ext2_get_block+0/420>
Trace; c0123500 <unmap_page_range+40/60>
Trace; c0137dbc <vfs_write+9c/130>
Trace; c0125f85 <do_munmap+115/120>
Trace; c0137eba <sys_write+2a/40>
Trace; c0106f17 <syscall_call+7/b>

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
