Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbTJYAuc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 20:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262177AbTJYAuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 20:50:32 -0400
Received: from mail.kroah.org ([65.200.24.183]:45455 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262176AbTJYAua (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 20:50:30 -0400
Date: Fri, 24 Oct 2003 17:50:02 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test8 oops in find_inode_fast
Message-ID: <20031025005002.GA1845@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just got this on my laptop.  It's not too reproducable, as I've been
running this kernel since it came out.  I'll switch to 2.6.0-test8-bk in
a bit.

Anything anyone wants me to try?

thanks,

greg k-h



Unable to handle kernel paging request at virtual address 0031314d
 printing eip:
c0162596
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c0162596>]    Not tainted
EFLAGS: 00010206
EIP is at find_inode_fast+0x26/0x60
eax: 0031314d   ebx: cb70d164   ecx: 00007fff   edx: 0031314d
esi: 000be80d   edi: d650e000   ebp: d6f7f224   esp: c4f45d70
ds: 007b   es: 007b   ss: 0068
Process ls (pid: 7439, threadinfo=c4f44000 task=c817a0c0)
Stack: 000be80d d6f7f224 000be80d d650e000 c01629db d650e000 d6f7f224 000be80d 
       c36ea9d0 00000000 c744b900 00000246 fffffff4 c4f45f00 c013c225 c02a0507 
       000be80d d650e000 c744b720 cc472320 c017ed30 d650e000 000be80d cc67e438 
Call Trace:
 [<c01629db>] iget_locked+0x3b/0x80
 [<c013c225>] kmem_cache_alloc+0x25/0x60
 [<c017ed30>] ext3_lookup+0x50/0xb0
 [<c0160f3b>] d_alloc+0x1b/0x1b0
 [<c0161369>] d_lookup+0x29/0x50
 [<c0158652>] real_lookup+0x62/0xd0
 [<c015888a>] do_lookup+0x4a/0x90
 [<c0158dd6>] link_path_walk+0x506/0x830
 [<c0167b07>] __mark_inode_dirty+0x27/0xa0
 [<c0141c60>] handle_mm_fault+0x70/0x110
 [<c0178946>] ext3_readdir+0x486/0x4a0
 [<c013c225>] kmem_cache_alloc+0x25/0x60
 [<c015836e>] getname+0x5e/0xa0
 [<c01594e4>] __user_walk+0x24/0x40
 [<c0155014>] vfs_lstat+0x14/0x50
 [<c01556e1>] sys_lstat64+0x11/0x30
 [<c0108fb3>] syscall_call+0x7/0xb

