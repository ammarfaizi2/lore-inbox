Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263775AbTCVQvg>; Sat, 22 Mar 2003 11:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263776AbTCVQvg>; Sat, 22 Mar 2003 11:51:36 -0500
Received: from harrier.mail.pas.earthlink.net ([207.217.120.12]:11437 "EHLO
	harrier.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S263775AbTCVQve>; Sat, 22 Mar 2003 11:51:34 -0500
Date: Sat, 22 Mar 2003 12:08:56 -0500
To: linux-kernel@vger.kernel.org
Subject: benchmark anobjrmap with 2.5.65-mm2
Message-ID: <20030322170855.GA25553@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anonymous objrmap patches appear to several workloads
a little for uniprocessor K6/2 475 mhz with 2 ide disks 
and 384 MB ram.

Build times for autoconf (a fork test), kernel, and perl.

                           autoconf    kernel         perl
2.5.65                     3845          1641         1348 seconds
2.5.65-mm1                 3898          1646         1326
2.5.65-mm2                 3895          1582         1312
2.5.65-mm2-anobjrmap       3824          1614         1284

autoconf and perl builds were faster with anon obj rmap.
kernel build was not.  kernel build uses pipe more than
autoconf/perl build.  Could be the fact there was only
one sample too.

Lmbench pipe latency and bandwidth don't provide an obvious
explanation why kernel build was slower with anobjrmap.

*Local* Communication latencies in microseconds - smaller is better

kernel                           Pipe   
2.5.65                           15.36 ms 
2.5.65-mm1                       15.80  
2.5.65-mm2                       15.21  
2.5.65-mm2-anobjrmap             14.11  

*Local* Communication bandwidths in MB/s - bigger is better

kernel                           Pipe  
2.5.65                            64.5 MB/second
2.5.65-mm1                        63.3 
2.5.65-mm2                        65.9 
2.5.65-mm2-anobjrmap              65.1 

I'm running 2.5.65-mm3 now and will watch how kernel build
goes there.

AIM7 workloads were generally a hair faster with anobjrmap.

More benchmarks on recent kernels at:
http://home.earthlink.net/~rwhron/kernel/latest.html

Irman process load starvation still appears in 2.5.65 and 
2.5.65-mm[12].

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

