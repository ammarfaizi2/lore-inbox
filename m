Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130423AbRCGU3n>; Wed, 7 Mar 2001 15:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131175AbRCGU3d>; Wed, 7 Mar 2001 15:29:33 -0500
Received: from [199.183.24.200] ([199.183.24.200]:11061 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S130423AbRCGU3X>; Wed, 7 Mar 2001 15:29:23 -0500
Date: Wed, 7 Mar 2001 15:28:47 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: zaitcev@redhat.com
Subject: Q. about oops backtrace
Message-ID: <20010307152847.C19671@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

I was investigating an oops and the trace looked like this:

>>EIP; c01c54a9 <lvm_do_remove_proc_entry_of_vg+9/c0>   <=====
Trace; c01c3654 <lvm_do_vg_rename+84/250>
Trace; c01c0f0f <lvm_chr_ioctl+30f/6d0>
Trace; c015e7e2 <ext2_getblk+72/e0>
Trace; c01155a6 <do_page_fault+166/440>
Trace; c01272a9 <do_no_page+49/a0>
Trace; c0127414 <handle_mm_fault+114/1a0>
Trace; c0136a2d <kunmap_high+7d/90>
Trace; c012722e <do_anonymous_page+de/110>
Trace; c0127290 <do_no_page+30/a0>
Trace; c0127414 <handle_mm_fault+114/1a0>
Trace; c014cdec <dput+1c/170>
Trace; c0143f80 <cached_lookup+10/50>
Trace; c0144aae <path_walk+85e/940>
Trace; c014cdec <dput+1c/170>
Trace; c01392c9 <chrdev_open+59/a0>
Trace; c0138130 <dentry_open+c0/150>
Trace; c013805d <filp_open+4d/60>
Trace; c0148b97 <sys_ioctl+247/2a0>
Trace; c01091c7 <system_call+33/38>

What is with those recursive handle_mm_fault calls?
That does not look quite right. I _assume_ that the
stack would collapse properly upon return, but still...
I would appreciate a suggestion about what .S file to read
for the explanation.

-- Pete
