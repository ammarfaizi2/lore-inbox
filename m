Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265174AbSJWThC>; Wed, 23 Oct 2002 15:37:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265175AbSJWThC>; Wed, 23 Oct 2002 15:37:02 -0400
Received: from mailrelay2.lanl.gov ([128.165.4.103]:60596 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP
	id <S265174AbSJWTg6>; Wed, 23 Oct 2002 15:36:58 -0400
Subject: 2.5.44-[mm3, ac2] time to tar zxf kernel tarball compared for
	various fs.
From: Steven Cole <elenstev@mesatop.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 23 Oct 2002 13:42:13 -0600
Message-Id: <1035402133.13140.251.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings all,

I performed some timing tests for 2.5.44 mm3 and ac2, using 
tar zxf of the 2.5.44 tarball and rm -rf of the resulting tree as the load.

I performed each of these 4 times.  There was some variation between runs, 
but not as much as between kernel versions.  This data comes from the
first of the 4 runs in each case.

The hardware was a single PIII, kernels were UP, PREEMPT.
All partitions are on the same disk, a ST340016A ATA.
For mm3, SHAREPTE was not enabled.

This is not intended as a comparison between filesystems, since each 
is on a different part of the disk.  But the reputation for reiserfs
to be able to delete files quickly seems deserved. The side-by-side numbers 
are intended to show the amount of regression for each fs.

Yes, I know it would be nice to compare plain 2.5.44 too, but there is
only so much time in the day.

Steven

ext3		
tar zxf linux-2.5.44.tar.gz	2.5.44-mm3	2.5.44-ac2
user				4.42		4.39
system				4.09		4.05
elapsed				00:53.17	00:34.05
% CPU				16		24
		
rm -rf linux-2.5.44		2.5.44-mm3	2.5.44-ac2
user				0.02		0.02
system				0.58		0.58
elapsed				00:19.73	00:14.13
% CPU				3		4
		

reiserfs		
tar zxf linux-2.5.44.tar.gz	2.5.44-mm3	2.5.44-ac2
user				4.57		4.51
system				5.4		5.22
elapsed				00:15.58	00:14.09
% CPU				64		69
		
rm -rf linux-2.5.44		2.5.44-mm3	2.5.44-ac2
user				0.02		0.02
system				1.65		1.66
elapsed				00:04.38	00:01.92
% CPU				38		88
		

xfs		
tar zxf linux-2.5.44.tar.gz	2.5.44-mm3	2.5.44-ac2
user				4.61		4.6
system				6.13		6.08
elapsed				00:58.93	00:40.26
% CPU				18		26
		
rm -rf linux-2.5.44		2.5.44-mm3	2.5.44-ac2
user				0.07		0.05
system				2.23		2.14
elapsed				00:19.15	00:08.68
% CPU				12		25
		

jfs		
tar zxf linux-2.5.44.tar.gz	2.5.44-mm3	2.5.44-ac2
user				4.53		4.4
system				4.01		3.94
elapsed				00:34.71	00:31.67
% CPU				24		26
		
rm -rf linux-2.5.44		2.5.44-mm3	2.5.44-ac2
user				0.03		0.03
system				0.62		0.55
elapsed				00:14.78	00:08.60
% CPU				4		6




