Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136589AbREAHzc>; Tue, 1 May 2001 03:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136590AbREAHzV>; Tue, 1 May 2001 03:55:21 -0400
Received: from cs.columbia.edu ([128.59.16.20]:47826 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S136589AbREAHzR>;
	Tue, 1 May 2001 03:55:17 -0400
Date: Tue, 1 May 2001 00:55:10 -0700 (PDT)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andrea Arcangeli <andrea@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.19 locks up on SMP
In-Reply-To: <Pine.LNX.4.33.0105010026530.12259-100000@age.cs.columbia.edu>
Message-ID: <Pine.LNX.4.33.0105010051490.12259-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 May 2001, Ion Badulescu wrote:

> Right now I'm pretty sure it's the NFS/SunRPC changes, but I'll know for 
> sure in about 30 minutes.

As I suspected, 2.2.19pre9 + the NFS/SunRPC changes locked up under load 
with the now familiar:

wait_on_bh, CPU 2:
irq:  1 [0 0]
bh:   1 [0 1]
<[8010af71]> 

This time it happened precisely when I ran a ls -lR on a large tree over 
NFS, so I'm pretty sure this is it.

I'll do another test, 2.2.18 + the NFS/SunRPC changes, and see how it 
goes. Hopefully they'll apply easily...

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

