Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318989AbSICXMt>; Tue, 3 Sep 2002 19:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318990AbSICXMs>; Tue, 3 Sep 2002 19:12:48 -0400
Received: from dsl-213-023-043-116.arcor-ip.net ([213.23.43.116]:29080 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318989AbSICXMr>;
	Tue, 3 Sep 2002 19:12:47 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Anton Altaparmakov <aia21@cantab.net>, ptb@it.uc3m.es
Subject: Re: [RFC] mount flag "direct" (fwd)
Date: Wed, 4 Sep 2002 01:19:08 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Lars Marowsky-Bree <lmb@suse.de>, "Peter T. Breuer" <ptb@it.uc3m.es>,
       root@chaos.analogic.com, Rik van Riel <riel@conectiva.com.br>,
       linux kernel <linux-kernel@vger.kernel.org>
References: <20020903185344.GA7836@marowsky-bree.de> <5.1.0.14.2.20020903221201.00ac5770@pop.cus.cam.ac.uk>
In-Reply-To: <5.1.0.14.2.20020903221201.00ac5770@pop.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17mMwu-0005mj-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 September 2002 23:54, Anton Altaparmakov wrote:
> The difference between a DFS and your proposal is that a DFS maintains all 
> the caching benefits of a normal FS at the local node level, while your 
> proposal completely and entirely disables caching, which is debatably 
> impossible (due to need to load things into ram to read them and to modify 
> them and then write them back) and certainly no FS author will accept their 
> FS driver to be crippled in such a way. The performance loss incurred by 
> removing caching completely is going to make sure you will only be dreaming 
> of those 50GiB/sec. More likely you will be getting a few bytes/sec... (OK, 
> I exaggerate a bit.) The seek times on the disks together with the 
> read/write timings are going to completely annihilate performance. A DFS 
> maintains caching at local node level, so you can still keep open inodes in 
> memory for example (just don't allow any other node to open the same file 
> at the same time or you need to do some juggling via the "Master DFS node").

You're well wide of the mark here, in that you're relying on the assumption
that caching is important to the application he has in mind.  The raw transfer
bandwidth may well be sufficient, especially if it is unimpeded by being
funneled through a bottleneck like our vfs cache.

-- 
Daniel
