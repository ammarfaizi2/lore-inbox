Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136600AbREAJWO>; Tue, 1 May 2001 05:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136602AbREAJWD>; Tue, 1 May 2001 05:22:03 -0400
Received: from cs.columbia.edu ([128.59.16.20]:29681 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S136600AbREAJVz>;
	Tue, 1 May 2001 05:21:55 -0400
Date: Tue, 1 May 2001 02:21:52 -0700 (PDT)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andrea Arcangeli <andrea@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.19 locks up on SMP
In-Reply-To: <Pine.LNX.4.33.0105010051490.12259-100000@age.cs.columbia.edu>
Message-ID: <Pine.LNX.4.33.0105010140270.12259-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 May 2001, Ion Badulescu wrote:

> I'll do another test, 2.2.18 + the NFS/SunRPC changes, and see how it 
> goes. Hopefully they'll apply easily...

As I suspected, 2.2.18 + all the NFS/NFSd/SunRPC changes present in 
2.2.19pre10 locks up with wait_on_bh as soon as I run ls -lR on a large 
NFS directory tree, while at the same time pummeling the network and the 
local disks.

NFS is not enough to trigger the bug, the extra disk/network stress *is*
necessary. The network stress actually seems to be enough, I just 
triggered the bug again...

2.2.18 vanilla is fine.

So I guess the next round is in Trond's court. :-)

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.



