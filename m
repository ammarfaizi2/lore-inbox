Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282664AbRLGPtM>; Fri, 7 Dec 2001 10:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282693AbRLGPtC>; Fri, 7 Dec 2001 10:49:02 -0500
Received: from dsl-213-023-043-071.arcor-ip.net ([213.23.43.71]:43273 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S282664AbRLGPsu>;
	Fri, 7 Dec 2001 10:48:50 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Daniel Phillips <phillips@bonn-fries.net>
To: Ragnar =?iso-8859-1?q?Kj=F8rstad?= <reiserfs@ragnark.vestdata.no>,
        Hans Reiser <reiser@namesys.com>
Subject: Re: [reiserfs-dev] Re: Ext2 directory index: ALS paper and benchmarks
Date: Fri, 7 Dec 2001 16:51:33 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
In-Reply-To: <E16BjYc-0000hS-00@starship.berlin> <3C0EE8DD.3080108@namesys.com> <20011206122753.A9253@vestdata.no>
In-Reply-To: <20011206122753.A9253@vestdata.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <E16CNHk-0000u4-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 6, 2001 12:27 pm, Ragnar Kjørstad wrote:
> There is obviously something missing in this picture, or reiserfs would
> be as fast as ext2 for random access and much faster for access in
> sequential order by filename spelling.
> 
> (a "random" hash should not be significantly better than a hash that
> preserves order, because the randomness in the hash is of course not the
> same random order in wich the files are accessed. The only exception is
> that hashes that preserve order may have a harder time using the full
> hash-space evenly)
> 
> So, did anyone investigate why ext2 is faster than reiserfs in theese
> cases, or try benchmarking ext2 with one of the reiserfs-hashes (eg r5)?
> We know from earlier benchmarks on reiserfs (tea vs r5 tests, and r5 vs
> maildir-hash) that a hash that preserves order can give a magnitude of
> order performance improvement in certain cases.

I did try R5 in htree, and at least a dozen other hashes.  R5 was the worst 
of the bunch, in terms of uniformity of distribution, and caused a measurable 
slowdown in Htree performance.  (Not an order of magnitude, mind you, 
something closer to 15%.)

An alternative way of looking at this is, rather than R5 causing an order of 
magnitude improvement for certain cases, something else is causing an order 
of magnitude slowdown for common cases.  I'd suggest attempting to root that 
out.

--
Daniel
