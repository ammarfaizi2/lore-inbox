Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751543AbWIME0o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543AbWIME0o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 00:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751544AbWIME0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 00:26:44 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:40086 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751542AbWIME0n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 00:26:43 -0400
Date: Wed, 13 Sep 2006 14:26:27 +1000
From: David Chinner <dgc@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: xfs-masters@oss.sgi.com,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: Re: [xfs-masters] Re: 2.6.18-rc6-mm2
Message-ID: <20060913042627.GE3024@melbourne.sgi.com>
References: <20060912000618.a2e2afc0.akpm@osdl.org> <6bffcb0e0609120554j5e69e2sd2c8ebb914c4c9f5@mail.gmail.com> <6bffcb0e0609120842s6a38b326u4e1fff2e562a6832@mail.gmail.com> <20060912162555.d71af631.akpm@osdl.org> <6bffcb0e0609121634l7db1808cwa33601a6628ee7eb@mail.gmail.com> <20060912163749.27c1e0db.akpm@osdl.org> <20060913015850.GB3034@melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060913015850.GB3034@melbourne.sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2006 at 11:58:50AM +1000, David Chinner wrote:
> Call Trace:
> [<c013ae74>] lock_release_non_nested+0xd8/0x143
> [<c013b291>] lock_release+0x178/0x19f
> [<c02f7dc5>] __mutex_unlock_slowpath+0xbb/0x131
> [<c02f7e43>] mutex_unlock+0x8/0xa
> [<c017655f>] generic_shutdown_super+0x9c/0xd9
> [<c01765bc>] kill_block_super+0x20/0x32
> [<c017667c>] deactivate_super+0x5d/0x6f
> [<c01892bc>] mntput_no_expire+0x52/0x85
> [<c017b2c9>] path_release_on_umount+0x15/0x18
> [<c018a469>] sys_umount+0x1e1/0x215
> [<c018a4aa>] sys_oldumount+0xd/0xf
> [<c0103156>] sysenter_past_esp+0x5f/0x99
> 
> I'm not sure why XFS would cause this - the crash is outside XFS releasing
> a mutex (sb->s_lock) that XFS code has never touched. I doubt anyone
> in the XFS team has done any testing on this -mm kernel...
> 
> What is the test case, Michal? Can you post the script you used?

I've booted 2.6.18-rc6-mm2 and mounted and unmounted several xfs
filesystems. I'm currently running xfsqa on it, and I haven't seen
any failures on unmount yet.

That test case would be really handy, Michal.

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
