Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131132AbRBVDbl>; Wed, 21 Feb 2001 22:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131148AbRBVDbb>; Wed, 21 Feb 2001 22:31:31 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:4871 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131132AbRBVDbM>; Wed, 21 Feb 2001 22:31:12 -0500
Date: Wed, 21 Feb 2001 19:30:47 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Phillips <phillips@innominate.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [rfc] Near-constant time directory index for Ext2
In-Reply-To: <3A947953.B88A23E2@innominate.de>
Message-ID: <Pine.LNX.4.10.10102211929070.1129-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 22 Feb 2001, Daniel Phillips wrote:
> 
> In the first heat of hash races - creating 20,000 files in one directory
> - dentry::hash lost out to my original hack::dx_hash, causing a high
> percentage of leaf blocks to remain exactly half full and slowing down
> the whole thing by about 5%.  (This was under uml - I haven't tried it
> native yet but I expect the results to be similar.)
> 
> 	  Contender			Result
> 	  =========			======
> 	dentry::hash		Average fullness = 2352 (57%)
> 	hack::dx_hash		Average fullness = 2758 (67%)
> 
> This suggests that dentry::hash is producing distinctly non-dispersed
> results and needs to be subjected to further scrutiny.  I'll run the
> next heat of hash races tomorrow, probably with R5, and CRC32 too if I
> have time.

I'd love to hear the results from R5, as that seems to be the reiserfs
favourite, and I'm trying it out in 2.4.2 because it was so easy to plug
in..

		Linus

