Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267573AbTBRDUx>; Mon, 17 Feb 2003 22:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267574AbTBRDUx>; Mon, 17 Feb 2003 22:20:53 -0500
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:26897 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id <S267573AbTBRDUw>; Mon, 17 Feb 2003 22:20:52 -0500
From: Bob Johnson <livewire@gentoo.org>
Reply-To: livewire@gentoo.org
To: linux-kernel@vger.kernel.org
Subject: 2.5.62 oops
Date: Mon, 17 Feb 2003 22:29:21 -0500
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302172229.21528.livewire@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running a stress test of 50 concurrent kernel tree cp's + md5sum the files on
2.5.62 results in the following:

Feb 17 21:53:41 livewire kernel: VFS: brelse: Trying to free free buffer
Feb 17 21:53:41 livewire kernel: buffer layer error at fs/buffer.c:1170
Feb 17 21:53:41 livewire kernel: Pass this trace through ksymoops for 
reporting
Feb 17 21:53:42 livewire kernel: Call Trace: [__brelse+53/64]  
[bh_lru_install+169/224]  [__find_get_block+113/128]  [__getblk+43/96]  
[ext3_getblk+171/752]  [ext3_bread+51/176]  [dx_probe+158/784]  
[ext3_bread+51/176]  [ext3_dx_find_entry+183/560]  [ext3_find_entry+989/1040]  
[journal_stop+346/496]  [ext3_dirty_inode+147/256]  [d_alloc+32/496]  
[ext3_lookup+90/256]  [real_lookup+192/240]  [do_lookup+159/176]  
[link_path_walk+833/1584]  [__user_walk+73/96]  [vfs_lstat+28/96]  
[sys_lstat64+27/64]  [syscall_call+7/11] 
Feb 17 21:53:42 livewire kernel: Call Trace: [<c0149e85>]  [<c014a049>]  
[<c014a0f1>]  [<c014a12b>]  [<c017edab>]  [<c017f023>]  [<c01824be>]  
[<c017f023>]  [<c0183227>]  [<c018313d>]  [<c018b81a>]  [<c0181b83>]  
[<c015de20>]  [<c01833fa>]  [<c0154880>]  [<c0154abf>]  [<c0154e11>]  
[<c0155559>]  [<c015095c>]  [<c0150ffb>]  [<c010941f>] 

