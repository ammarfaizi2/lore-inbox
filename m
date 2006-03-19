Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751428AbWCSF23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbWCSF23 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 00:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbWCSF23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 00:28:29 -0500
Received: from mx1.suse.de ([195.135.220.2]:25728 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751428AbWCSF23 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 00:28:29 -0500
From: Neil Brown <neilb@suse.de>
To: linux-kernel@vger.kernel.org
Date: Sun, 19 Mar 2006 16:27:04 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17436.60328.242450.249552@cse.unsw.edu.au>
Subject: Who uses the 'nodev' flag in /proc/filesystems ???
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi, 
 I just noticed that the FS_REQUIRES_DEV flag is used for just two
 things in the kernel.

  1/ to place the text 'nodev' at the start of the line in
       /proc/filesystems
  2/ to tell nfsd that it is reasonably OK to use the s_dev field 
     in the superblock as a stable, unique identifier for the
     filesystem.

I have a filesystem I am playing with for which I am quite happy to
lose the second aspect of FS_REQUIRES_DEV (it does use a device, but
there could well be multiple devices, and the fs can migrate from one
device to another so s_dev is even less stable than normal).  However
I would like to understand the implications of losing the first aspect
of FS_REQUIRES_DEV before deciding whether to provide the flag or not.

Hence the question in the subject:

  Who uses the 'nodev' flag in /proc/filesystems?

Are there any known users of this flag?

Thanks,
NeilBrown

