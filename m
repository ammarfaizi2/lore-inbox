Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287831AbSABOC6>; Wed, 2 Jan 2002 09:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287829AbSABOCp>; Wed, 2 Jan 2002 09:02:45 -0500
Received: from scaup.mail.pas.earthlink.net ([207.217.120.49]:10401 "EHLO
	scaup.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S287707AbSABOCZ>; Wed, 2 Jan 2002 09:02:25 -0500
Date: Wed, 2 Jan 2002 09:05:47 -0500
To: linux-kernel@vger.kernel.org
Cc: andrea@suse.de
Subject: changelogs for 2.4.17rc2aa2 and 2.2.20aa1
Message-ID: <20020102090547.A233@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I put together these pages to help others understand 
what is in Andrea's kernels a little better.

http://home.earthlink.net/~rwhron/kernel/2.4.17rc2aa2.html
http://home.earthlink.net/~rwhron/kernel/2.2.20aa1.html

The pages are created from his patch diff logs.

I've stress tested and benchmarked 2.4.17rc2aa2 a lot and 
it's been very solid.  For a workload that creates a lot
of processes 2.4.17rc2aa2 has a definite edge.  This is
easiest to see in a couple unixbench tests:


                              2.4.17-mjc1  2.4.17rc2aa2   2.5.1-dj10
System Call Overhead             352361.7     362120.5    255809.4 lps
Process Creation                    817.5       2037.7      1212.0 lps
Execl Throughput                    265.8        458.4       316.5 lps

And lmbench; the highest and lowest results of 3 runs were dropped.

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
OS           fork exec sh
             proc proc proc
------------ ---- ---- ----
2.4.17rc2aa2  745 2769 9583
  2.5.1-dj10  810 3504 11.K
 2.4.17-mjc1 1128 4244 12.K

Good stuff comes from a lot of sources, and I'm hoping some of
the tree maintainers will start cherry picking from Andrea's 
tree too.  :)

Note: mjc1 above was configured without preempt, rtsched
or lockbreak.

2.4.17rc2aa2 consistently does better at dbench too.
More results are at:
http://home.earthlink.net/~rwhron/kernel/repo.html

-- 
Randy Hron

