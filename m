Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318976AbSHFEav>; Tue, 6 Aug 2002 00:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318983AbSHFEau>; Tue, 6 Aug 2002 00:30:50 -0400
Received: from flamingo.mail.pas.earthlink.net ([207.217.120.232]:12440 "EHLO
	flamingo.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S318976AbSHFEau>; Tue, 6 Aug 2002 00:30:50 -0400
Date: Tue, 6 Aug 2002 00:36:48 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.4.19-rc5
Message-ID: <20020806043648.GA23256@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I sort of hoped it would be better in performance, not
> increasingly worse.

There were a lot of improvements during the 2.4.19-pre series on 
several I/O benchmarks.  Comparing 2.4.18 to 2.4.19 on a quad xeon. 
Here are a few of the big changes (average of 5 runs):

200% improvement on reiserfs for dbench 192
125% improvement on ext3     for dbench 192
248% improvement on ext2     for dbench 192
 40% improvement on reiserfs for dbench  64
 30% improvement on ext3     for dbench  64
 67% improvement on ext2     for dbench  64
 30% improvement on ext2 for tiobench seq reads with threads >= 32
100% improvement on ext2 and reiserfs for tiobench seq writes with threads >= 32
300% drop in cpu usage on ext3 for tiobench seq reads
     (latency and throughput also improved)

In most cases, average and max tiobench latency went down with 2.4.19.
Max sequential write latency with one thread on ext2 went up 1000% though.

imho, it's worthwhile to track and investigate regressions
and improvements.

More benchmarks and several pre's and rc's in between at:
http://home.earthlink.net/~rwhron/kernel/bigbox.html

Small boxes are important too:
http://home.earthlink.net/~rwhron/kernel/k6-2-475.html
-- 
Randy Hron

