Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267066AbRGOV3j>; Sun, 15 Jul 2001 17:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267067AbRGOV3U>; Sun, 15 Jul 2001 17:29:20 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:43275 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S267066AbRGOV3K>; Sun, 15 Jul 2001 17:29:10 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Hans Reiser <reiser@namesys.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Stability of ReiserFS onj Kernel 2.4.x (sp. 2.4.[56]{-ac*}
Date: Sun, 15 Jul 2001 23:30:44 +0200
X-Mailer: KMail [version 1.2]
Cc: volodya@mindspring.com, Adam Schrotenboer <ajschrotenboer@lycosmail.com>,
        lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <E15LopT-0004Cm-00@the-village.bc.nu> <3B51C864.C98B61DE@namesys.com>
In-Reply-To: <3B51C864.C98B61DE@namesys.com>
MIME-Version: 1.0
Message-Id: <01071523304400.06482@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 15 July 2001 18:44, Hans Reiser wrote:
> The limits for reiserfs and ext2 for kernels 2.4.x are the same (and
> they are 2Tb not 1Tb).  The limits are not in the individual
> filesystems.  We need to have Linux go to 64 bit blocknumbers in
> 2.5.x, I am seeing a lot of customer demand for it.  (Or we could use
> scalable integers, which would be better.)

Or we could introduce the notion of logical blocksize for each block
minor so that we can measure blocks in the same units the filesystem
uses.  This would give us 16 TB while being able to stay with 32 bits
everywhere outside the block drivers themselves.

We are not that far away from being able to handle 8K blocks, so that
would bump it up to 32 TB.

--
Daniel
