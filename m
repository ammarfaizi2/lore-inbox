Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282597AbRLICpM>; Sat, 8 Dec 2001 21:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282598AbRLICox>; Sat, 8 Dec 2001 21:44:53 -0500
Received: from dsl-213-023-038-245.arcor-ip.net ([213.23.38.245]:63239 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S282597AbRLICot>;
	Sat, 8 Dec 2001 21:44:49 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Hans Reiser <reiser@namesys.com>,
        Ragnar =?iso-8859-1?q?Kj=F8rstad?= <reiserfs@ragnark.vestdata.no>
Subject: Re: [reiserfs-dev] Re: Ext2 directory index: ALS paper and benchmarks
Date: Sun, 9 Dec 2001 03:47:31 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com,
        Nikita Danilov <god@namesys.com>, green@thebsh.namesys.com
In-Reply-To: <E16BjYc-0000hS-00@starship.berlin> <20011208201639.B12687@vestdata.no> <3C12701A.10904@namesys.com>
In-Reply-To: <3C12701A.10904@namesys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Cu08-00014I-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 8, 2001 08:55 pm, Hans Reiser wrote:
> Daniel, you didn't mention though whether leaking collision bits is a 
> problem for Htrees.  Is it?  Do you need to rehash every so often to 
> solve it?  Or it is rare enough that the performance cost can be ignored?

It's a problem of course, and I put considerable effort into handling it.  I 
never have to rehash because the htree isn't a hash table, it's a tree of 
hash ranges.  I explicitly flag every instance where a collision could force 
a search to continue in a successor block.  Even though it's every rare, it 
does happen and it has to be handled.  This is described in some detail in my 
paper.

After all the effort that went into this, the result was just a few lines of 
code, which was nice.

--
Daniel
