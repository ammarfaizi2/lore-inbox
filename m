Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266971AbSKWG06>; Sat, 23 Nov 2002 01:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266980AbSKWG06>; Sat, 23 Nov 2002 01:26:58 -0500
Received: from whitsun.whitsunday.net.au ([203.25.188.10]:8714 "EHLO
	mail1.whitsunday.net.au") by vger.kernel.org with ESMTP
	id <S266971AbSKWG05> convert rfc822-to-8bit; Sat, 23 Nov 2002 01:26:57 -0500
From: John W Fort <johnf@whitsunday.net.au>
To: linux-kernel@vger.kernel.org
Subject: FS corruption with 2.5.47
Date: Sat, 23 Nov 2002 16:33:50 +1000
Message-ID: <o68utu0ji6v2jq0gagm92v78f2k84uaqbj@4ax.com>
X-Mailer: Forte Agent 1.92/32.572
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got this just before I went away on a trip.

Nov 20 13:46:47 localhost kernel: buffer layer error at fs/buffer.c:399
Nov 20 13:46:47 localhost kernel: Pass this trace through ksymoops for reporting
Nov 20 13:46:47 localhost kernel: Call Trace: [<c0139526>]  [<c013a447>]  [<c013a9e6>]  [<c013aa17>]  [<c012d554>]  [<c013b45c>]  [<c0160050>]  [<c0127e42>]  [<c0160050>]  [<c011133b>]  [<c0128226>]  [<c0137f32>]  [<c017a3e3>]  [<c0137ff8>]  [<c0108a0f>] 
ksymoops 2.4.4 on i686 2.5.47.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.47/ (default)
     -m /boot/System.map-2.5.47 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Nov 20 13:46:47 localhost kernel: Call Trace: [<c0139526>]  [<c013a447>]  [<c013a9e6>]  [<c013aa17>]  [<c012d554>]  [<c013b45c>]  [<c0160050>]  [<c0127e42>]  [<c0160050>]  [<c011133b>]  [<c0128226>]  [<c0137f32>]  [<c017a3e3>]  [<c0137ff8>]  [<c0108a0f>] 
Warning (Oops_read): Code line not seen, dumping what data is available

Trace; c0139526 <__find_get_block_slow+a6/e0>
Trace; c013a447 <unmap_underlying_metadata+17/50>
Trace; c013a9e6 <__block_prepare_write+166/420>
Trace; c013aa17 <__block_prepare_write+197/420>
Trace; c012d554 <buffered_rmqueue+c4/d0>
Trace; c013b45c <block_prepare_write+1c/40>
Trace; c0160050 <ext2_get_block+0/390>
Trace; c0127e42 <generic_file_write_nolock+5e2/960>
Trace; c0160050 <ext2_get_block+0/390>
Trace; c011133b <do_page_fault+11b/41f>
Trace; c0128226 <generic_file_write+46/60>
Trace; c0137f32 <vfs_write+b2/110>
Trace; c017a3e3 <copy_to_user+33/40>
Trace; c0137ff8 <sys_write+28/40>
Trace; c0108a0f <syscall_call+7/b>


3 warnings issued.  Results may not be reliable.

Hope this helps, or even better is fixed already.



