Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751745AbWHTWb3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745AbWHTWb3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 18:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751751AbWHTWb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 18:31:29 -0400
Received: from sandeen.net ([209.173.210.139]:58720 "EHLO sandeen.net")
	by vger.kernel.org with ESMTP id S1751744AbWHTWb2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 18:31:28 -0400
Message-ID: <44E8E2BF.7020000@sandeen.net>
Date: Sun, 20 Aug 2006 17:31:27 -0500
From: Eric Sandeen <sandeen@sandeen.net>
User-Agent: Thunderbird 1.5.0.5 (Macintosh/20060719)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
Cc: ext2-devel@lists.sourceforge.net, Neil Brown <neilb@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: CVE-2006-3468: which patch to use?
References: <20060820192750.GR7813@stusta.de>
In-Reply-To: <20060820192750.GR7813@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
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
> 
> cu
> Adrian
> 
> BTW: I've attached all three patches.
> 
> [1] http://lkml.org/lkml/2006/8/4/192

IMO the first two should be used; i.e. those that add ext[23]_get_dentry().

-Eric
