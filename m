Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751783AbWHTW6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783AbWHTW6S (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 18:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751784AbWHTW6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 18:58:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:30426 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751783AbWHTW6R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 18:58:17 -0400
From: Neil Brown <neilb@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Date: Mon, 21 Aug 2006 08:58:10 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17640.59650.383208.804821@cse.unsw.edu.au>
Cc: ext2-devel@lists.sourceforge.net, Eric Sandeen <sandeen@sandeen.net>,
       linux-kernel@vger.kernel.org
Subject: Re: CVE-2006-3468: which patch to use?
In-Reply-To: message from Adrian Bunk on Sunday August 20
References: <20060820192750.GR7813@stusta.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday August 20, bunk@stusta.de wrote:
> While going through patches for 2.6.16.x, I stumbled over the following 
> regarding the "NFS export of ext2/ext3" security vulnerabilities (the 
> ext3 one is  CVE-2006-3468, I don't whether there's a number for the 
> ext2 one):
> 
> There are three patches available:
> have-ext2-reject-file-handles-with-bad-inode-numbers-early.patch
> have-ext3-reject-file-handles-with-bad-inode-numbers-early.patch
> ext3-avoid-triggering-ext3_error-on-bad-nfs-file-handle.patch
> 
> The first two patches are except for a s/ext2/ext3/ identical.
> 
> The two ext3 patches fix the same issue in slightly different ways.
> 
> It seems there was already some agreement that the first of the two ext3 
> patches should be preferred due to being more the same as the ext2 patch
> (see [1] and followups).
> 
> But the only patch that is applied in 2.6.18-rc4 (and in 2.6.17.9) is 
> the ext3 patch that is _not_ identical to the ext2 one.
> 
> Is it the correct solution to revert this ext3 patch in both 2.6.18-rc 
> and 2.6.17 and to apply the other two patches?

There is no point in reverting the ext3 patch.  It is a good and
proper patch to have.
Apply the ext2 patch is definitely a good idea.
Applying the other ext3 patch is also a good idea.

NeilBrown
