Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbTFKM6u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 08:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbTFKM6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 08:58:50 -0400
Received: from bonifac.e98.hu ([195.70.36.120]:27571 "HELO bonifac.e98.hu")
	by vger.kernel.org with SMTP id S261222AbTFKM6t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 08:58:49 -0400
From: szazol@e98.hu
Date: Wed, 11 Jun 2003 15:12:31 +0200
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: buffer layer error at fs/buffer.c:127
Message-ID: <20030611131231.GA10718@bonifac.e98.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I found this message in dmesg:

buffer layer error at fs/buffer.c:127
Pass this trace through ksymoops for reporting
Call Trace: [<c013f145>]  [<c0114898>]  [<c0114898>]  [<c018e69a>]  [<c018e730>]  [<c018e91d>]  [<c018c527>]  [<c018c98c>]  [<c017bc8e>]  [<c0192800>]  [<c017ce2d>]  [<c02631bc>]  [<c013ee28>]  [<c013d80c>]  [<c013d888>]  [<c0108d53>] 


Here's the ksymoops output:

ksymoops 2.4.8 on i686 2.5.67.  Options used
     -V (default)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.5.67/ (default)
     -m /boot/System.map-2.5.67 (default)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Call Trace: [<c013f145>]  [<c0114898>]  [<c0114898>]  [<c018e69a>]  [<c018e730>]  [<c018e91d>]  [<c018c527>]  [<c018c98c>]  [<c017bc8e>]  [<c0192800>]  [<c017ce2d>]  [<c02631bc>]  [<c013ee28>]  [<c013d80c>]  [<c013d888>]  [<c0108d53>] 
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; c013f145 <__wait_on_buffer+d0/d2>
Trace; c0114898 <autoremove_wake_function+0/4f>
Trace; c0114898 <autoremove_wake_function+0/4f>
Trace; c018e69a <reiserfs_unmap_buffer+62/9c>
Trace; c018e730 <unmap_buffers+5c/5e>
Trace; c018e91d <indirect2direct+1eb/2e2>
Trace; c018c527 <reiserfs_cut_from_item+3c3/4e6>
Trace; c018c98c <reiserfs_do_truncate+2eb/5a4>
Trace; c017bc8e <reiserfs_truncate_file+df/209>
Trace; c0192800 <journal_end+27/2b>
Trace; c017ce2d <reiserfs_file_release+229/43f>
Trace; c02631bc <ide_do_request+1d4/34f>
Trace; c013ee28 <__fput+9b/9d>
Trace; c013d80c <filp_close+4d/79>
Trace; c013d888 <sys_close+50/5f>
Trace; c0108d53 <syscall_call+7/b>


1 warning issued.  Results may not be reliable.

No module support was compiled into the kernel.

Regards,
SZALONTAI Zoltan
