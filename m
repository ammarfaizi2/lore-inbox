Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932478AbVKWDBb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbVKWDBb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 22:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbVKWDBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 22:01:31 -0500
Received: from ns.suse.de ([195.135.220.2]:41090 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932478AbVKWDBa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 22:01:30 -0500
From: Neil Brown <neilb@suse.de>
To: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 23 Nov 2005 14:01:25 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17283.56197.347658.787608@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pivot_root broken in 2.6.15-rc1-mm2
In-Reply-To: message from Al Viro on Wednesday November 23
References: <17283.52960.913712.454816@cse.unsw.edu.au>
	<20051123021545.GP27946@ftp.linux.org.uk>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday November 23, viro@ftp.linux.org.uk wrote:
> On Wed, Nov 23, 2005 at 01:07:28PM +1100, Neil Brown wrote:
> > After putting in copious tracing printk, the offending test is:
> > 
> > 	if (user_nd.mnt->mnt_parent == user_nd.mnt)
> > 		goto out2; /* not attached */
> > 
> > If I remove this, it works (or seems to).
> > Presumably the initial root file system is 'not attached'.  But that
> > shouldn't be a problem, should it?
> 
> Initial root is root and will remain root, period.
> 
> > Could this be related to the new shared mounts stuff???
> 
> No.  And no, it's not going to change - any memory you win on killing
> initramfs is not going to be worth the extra code needed to special-case
> it.

Ah, OK.
It's just that pivot_root works in this context in 2.6.11.9, so I
figured it was a breakage.

I'll go read ramfs-rootfs-initramfs.txt 

Thanks,
NeilBrown
