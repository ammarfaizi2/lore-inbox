Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271821AbTGRVg6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 17:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270373AbTGRVg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 17:36:57 -0400
Received: from 015.atlasinternet.net ([212.9.93.15]:31686 "EHLO
	ponti.gallimedina.net") by vger.kernel.org with ESMTP
	id S271989AbTGRVgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 17:36:22 -0400
From: Ricardo Galli <gallir@uib.es>
Organization: UIB
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Linux 2.6.0-test1 Ext3 Ooops. Reboot needed.
Date: Fri, 18 Jul 2003 23:51:17 +0200
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <200307181228.40142.gallir@uib.es> <200307182313.23288.gallir@uib.es> <20030718142720.40983f6a.akpm@osdl.org>
In-Reply-To: <20030718142720.40983f6a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307182351.17694.gallir@uib.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 July 2003 23:27, Andrew Morton shaped the electrons to shout:
> Ricardo Galli <gallir@uib.es> wrote:
> > "File alteration monitor", from Debian.
>
> OK.
>
> > $ apt-cache show fam
>
> I was attacked by dselect as a small child and have since avoided debian.

I tried Debian after I was 30 and apt-get was already born, never used that 
beast.

> Is there a tarball anywhere?

I just download the sources for you:
http://mnm.uib.es/~gallir/tmp/fam_2.6.10.orig.tar.gz
http://mnm.uib.es/~gallir/tmp/fam_2.6.10-1.diff.gz (Debian patch)

> > Nevertheless I saw the same message the morning after updatedb run.
>
> But was the "Process:" also famd in that case?

It was updatedb:

 Code: 8b 11 0f 18 02 90 39 59 18 89 c8 74 13 85 d2 89 d1 75 ed 31
  <6>note: updatedb[25529] exited with preempt_count 1
 bad: scheduling while atomic!
 Call Trace:
  [<c0118667>] schedule+0x3b7/0x3c0
  [<c014084b>] unmap_page_range+0x4b/0x80
  [<c0140a4d>] unmap_vmas+0x1cd/0x230
  [<c0144608>] exit_mmap+0x78/0x190
  [<c011a084>] mmput+0x64/0xc0
  [<c011dd23>] do_exit+0x113/0x440
  [<c0116c60>] do_page_fault+0x0/0x479
  [<c010a360>] do_divide_error+0x0/0x100
  [<c0116d8c>] do_page_fault+0x12c/0x479
  [<c015233b>] __getblk+0x2b/0x60
  [<c0186263>] ext3_getblk+0x93/0x260
  [<c0150b5f>] wake_up_buffer+0xf/0x30
  [<c0150bac>] unlock_buffer+0x2c/0x50
  [<c015435c>] ll_rw_block+0x5c/0x90
  [<c0152293>] __find_get_block+0x73/0xf0
  [<c018a1d4>] ext3_find_entry+0x354/0x410
  [<c0116c60>] do_page_fault+0x0/0x479
  [<c0109cc5>] error_code+0x2d/0x38
  [<c0168790>] find_inode_fast+0x20/0x70
  [<c0168e42>] iget_locked+0x52/0xc0
  [<c018a54b>] ext3_lookup+0x6b/0xd0
  [<c015cd92>] real_lookup+0xd2/0x100
  [<c015d036>] do_lookup+0x96/0xb0
  [<c015d4e0>] link_path_walk+0x490/0x8a0
  [<c015ddf9>] __user_walk+0x49/0x60
  [<c0158fac>] vfs_lstat+0x1c/0x60
  [<c015965b>] sys_lstat64+0x1b/0x40
  [<c01092bb>] syscall_call+0x7/0xb
 
 
> A bug in the dnotify code is unsurprising - it doesn't get used or tested
> much, and many things around it have changed.

-- 
  ricardo galli       GPG id C8114D34
  http://mnm.uib.es/~gallir/

