Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751583AbWCTErr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751583AbWCTErr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 23:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751584AbWCTErr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 23:47:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:8903 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751562AbWCTErr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 23:47:47 -0500
From: Neil Brown <neilb@suse.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Date: Mon, 20 Mar 2006 15:46:22 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17438.13214.307942.212773@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Who uses the 'nodev' flag in /proc/filesystems ???
In-Reply-To: message from Jan Engelhardt on Sunday March 19
References: <17436.60328.242450.249552@cse.unsw.edu.au>
	<Pine.LNX.4.61.0603191024420.1409@yvahk01.tjqt.qr>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday March 19, jengelh@linux01.gwdg.de wrote:
> >
> >Hence the question in the subject:
> >
> >  Who uses the 'nodev' flag in /proc/filesystems?
> >
> >Are there any known users of this flag?
> >
> 
> pam_mount. If a specific filesystem is nodev, --bind or --move, fsck is 
> skipped. If you want to change /proc/filesystems, you can do so as long as 
> you provide an alternative ;) Does not need to be stable, as 
> /proc/filesystems is only used when a volume is initially mounted in 
> pam_mount.

Pam_mount .. (google...) you learn something new every day, don't you!

That sounds like a reasonable usage of 'nodev', though testing for
/sbin/fsck.$FSTYPE might do as well...

I guess in my case I could live without the auto-fsck, and as there
isn't necessarily just one device to take part in the fsck, it might
be awkward anyway.

Thanks.

I wonder if there are any others....

NeilBrown
