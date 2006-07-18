Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932407AbWGRW5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbWGRW5w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 18:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbWGRW5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 18:57:52 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:47780 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932405AbWGRW5u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 18:57:50 -0400
Date: Wed, 19 Jul 2006 08:57:31 +1000
From: Nathan Scott <nathans@sgi.com>
To: Torsten Landschoff <torsten@debian.org>
Cc: linux-kernel@vger.kernel.org, xfs@oss.sgi.com
Subject: Re: XFS breakage in 2.6.18-rc1
Message-ID: <20060719085731.C1935136@wobbly.melbourne.sgi.com>
References: <20060718222941.GA3801@stargate.galaxy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20060718222941.GA3801@stargate.galaxy>; from torsten@debian.org on Wed, Jul 19, 2006 at 12:29:41AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2006 at 12:29:41AM +0200, Torsten Landschoff wrote:
> Hi friends, 

Hi Torsten,

> I upgraded to 2.6.18-rc1 on sunday, with the following results (taken
> from my /var/log/kern.log), which ultimately led me to reinstall my 
> system:
> 
> Jul 17 07:33:53 pulsar kernel: xfs_da_do_buf: bno 16777216
> Jul 17 07:33:53 pulsar kernel: dir: inode 54526538

I suspect you had some residual directory corruption from using the
2.6.17 XFS (which is known to have a lurking dir2 corruption issue,
fixed in the latest -stable point release).

> of programs fail in mysterious ways. I tried to recover using xfs_repair
> but I feel that my partition is thorougly borked. Of course no data was 
> lost due to backups but still I'd like this bug to be fixed ;-)

2.6.18-rc1 should be fine (contains the corruption fix).  Did you
mkfs and restore?  Or at least get a full repair run?  If you did,
and you still see issues in .18-rc1, please let me know asap.

thanks.

-- 
Nathan
