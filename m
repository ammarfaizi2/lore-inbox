Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752040AbWG1RBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752040AbWG1RBi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 13:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752046AbWG1RBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 13:01:38 -0400
Received: from ns2.g-housing.de ([81.169.133.75]:18314 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S1752040AbWG1RBh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 13:01:37 -0400
Date: Fri, 28 Jul 2006 17:01:24 +0000 (UTC)
From: Christian Kujau <evil@g-house.de>
X-X-Sender: evil@sheep.housecafe.de
To: Nathan Scott <nathans@sgi.com>
cc: linux-kernel@vger.kernel.org, xfs@oss.sgi.com
Subject: Re: XFS breakage in 2.6.18-rc1
In-Reply-To: <20060724090138.C2083275@wobbly.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.64.0607281526220.1882@sheep.housecafe.de>
References: <20060718222941.GA3801@stargate.galaxy>
 <20060719085731.C1935136@wobbly.melbourne.sgi.com>
 <Pine.LNX.4.64.0607221722500.8407@prinz64.housecafe.de>
 <20060724090138.C2083275@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again,

On Mon, 24 Jul 2006, Nathan Scott wrote:
> filesystem too.  See the FAQ entry for a description on how to
> translate inums to paths, and also the repair -n step to detect
> any corruption ondisk.

I had two xfs filesystems and I first noticed that /data/Scratch was 
befallen from this bug. I did not care much about this (hence the
name :)) and I wanted to postpone the xfs_db surgery.

Unfortunately I forgot that "/" was also an XFS and it crashed 
yesterday. remounting ro helped a bit (so no process attempted to write 
on it. however, cp'ing from the ro-mounted xfs sometimes hung, 
unkillable), I setup a mini-root somewhere else and followed the
instructions in the FAQ. It did not go too well, lots of 
stuff was moved to lost+found, but every subsequent xfs_repair run 
found more and more errors. I decided to mkfs the partition and make use 
of my backups. my other "scratch" partition is still XFS but mounted ro 
and I'll try the xfsprogs fixes Nathan published on this one.

Oh, and I dd'ed the corrupt xfs-filesystem to a file, so I can play 
around with this one as well.

If anyone is interested, here are the typescripts from the horrible 
xfs_repair runs: http://nerdbynature.de/bits/2.6.18-rc2/log/

cheers,
Christian.
-- 
BOFH excuse #21:

POSIX compliance problem
