Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266776AbSIROEy>; Wed, 18 Sep 2002 10:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266778AbSIROEy>; Wed, 18 Sep 2002 10:04:54 -0400
Received: from snipe.mail.pas.earthlink.net ([207.217.120.62]:56569 "EHLO
	snipe.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S266776AbSIROEy>; Wed, 18 Sep 2002 10:04:54 -0400
Date: Wed, 18 Sep 2002 10:13:24 -0400
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com
Subject: Hint benchmark reaches memory size limit on 4gb box
Message-ID: <20020918141324.GA25534@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

3.75 gb ram
4 gb swap on 2 disks
quad xeon

Running the FLOAT benchmark from
ftp://ftp.scl.ameslab.gov/pub/HINT/hint.src.tar.gz
2.5.34-mm1 gave:

This run was memory limited at 31438643 subintervals -> -1894198156 bytes

The last I noticed, the process was around 2.6 GB.
The process grows over time as it needs memory.
It may have hit 3GB.

The version of hint is from the tarball's
source/serial/unix directory.

The goal is to combine several benchmarks for
a more rounded workload.  

I could run 2 copies of Hint if this is a 3gb
userspace limit issue.

parts of the combined/concurrent benchmark:
1) hint (possibly FLOAT & LONGLONG together)
2) netperf -t TCP_RR	# request/response
3) chat	# 2 rooms with semi-long lived clients
4) postmark	# 2 directories + lots of files
5) configure && make && make check GNU ed

Any suggestions?

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

