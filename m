Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269749AbSISCNX>; Wed, 18 Sep 2002 22:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269750AbSISCNX>; Wed, 18 Sep 2002 22:13:23 -0400
Received: from h106-129-61.datawire.net ([207.61.129.106]:30105 "EHLO
	newmail.datawire.net") by vger.kernel.org with ESMTP
	id <S269749AbSISCNV> convert rfc822-to-8bit; Wed, 18 Sep 2002 22:13:21 -0400
From: Shawn Starr <spstarr@sh0n.net>
Organization: sh0n.net
To: sct@redhat.com, akpm@digeo.com
Subject: EXT3 Testing w/ rmap14a with contest results
Date: Wed, 18 Sep 2002 21:18:12 -0400
User-Agent: KMail/1.4.6
Cc: Con Kolivas <conman@kolivas.net>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200209182118.12701.spstarr@sh0n.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.19-rmap14a - on Athlon MP 2000+ w/ 512MB RAM EXT3 Filesystem used 

with hdparm tweaks

noload		4:57.93		99%
cpuload		6:06.85		79%
memload		6:47.27		76%
ioloadhalf		10:36.93		47%
ioloadfull		8:06.46		62%

without hdparm tweaks

noload		4:57.53		99%
cpuload		6:06.68		79%
memload		6:44.22		77%
ioloadhalf		10:02.30		50%
ioloadfull		8:14.96		61%

-------------------------------------------------

on Athlon MP 2000+ w/ 512MB RAM EXT3 Filesystem used 
2.4.20-pre7-rmap14a-xfs-uml-shawn12d - with hdparm tweaks

noload		4:56.86         99%
cpuload		6:06.35         79%
memload		6:27.43         79%
ioloadhalf		9:00.57         55%
ioloadfull		8:11.82         61%

on Athlon MP 2000+ w/ 512MB RAM EXT3 Filesystem used 
2.4.20-pre7-rmap14a-xfs-uml-shawn12d - without hdparm tweaks

noload		5:02.87         97%
cpuload		6:07.29         79%
memload		6:24.29         80%
ioloadhalf		8:05.11         61%
ioloadfull		7:55.27         63%


For comparsion from my older machine
--------------------------------------------------------------

2.4.20-pre7-rmap14a-xfs-uml-shawn12d - Pentium 200Mhz 64MB Ram  EXT3 
Filesystem

noload		52:46.43		99%
cpuload		1:05:14		79%
memload		1:11:12		79%
ioloadhalf		1:10:14		78%
ioloadfull		1:10:31		78%

--------------------------------------------------------------

on Athlon MP 2000+ w/ 512MB RAM
2.4.20-pre7-rmap14a-xfs-uml-shawn12d - without hdparm tweaks ___WITH EXT3___

noload Time: 265.82  CPU: 96%  Major Faults: 755922  Minor Faults: 1150416
process_load Time: 314.80  CPU: 80%  Major Faults: 727159  Minor Faults: 
1146210
io_halfmem Time: 444.25  CPU: 58%  Major Faults: 726724  Minor Faults: 1146174
Was writing number 33 of a 257Mb sized io_load file after 449 seconds
Was writing number 9 of a 514Mb sized io_load file after 262 seconds

----------------------------------------------------------------------------------------------------

on Athlon MP 2000+ w/ 512MB RAM
2.4.20-pre7-rmap14a-xfs-uml-shawn12d - without hdparm tweaks  __WITHOUT 
EXT3___

noload Time: 259.41  CPU: 99%  Major Faults: 770937  Minor Faults: 1173712
process_load Time: 318.63  CPU: 80%  Major Faults: 742261  Minor Faults: 
1169518
io_halfmem Time: 305.75  CPU: 87%  Major Faults: 742000  Minor Faults: 1169497
Was writing number 32 of a 257Mb sized io_load file after 306 seconds
io_fullmem Time: 321.77  CPU: 83%  Major Faults: 742000  Minor Faults: 1169497
Was writing number 16 of a 514Mb sized io_load file after 324 seconds
mem_load Time: 345.10  CPU: 78%  Major Faults: 743807  Minor Faults: 1170248

As you can see, there's something DEFINATELY wrong here =)


* NOTES:

The old test at the top with the old format are from contest 0.22, the new 
results seen below are 0.34.

 <conman_work> yes, but results from different versions of contest are 
incompatible

<ShawnCONSOLE> riel uses EXT3
<riel> my cpu is slower
<ShawnCONSOLE> but you have fast disks?
<riel> so it doesn't fall idle as quickly as yours, when waiting on the disk
<riel> not very fast ;)
<riel> old 8 GB IDE disk
<ShawnCONSOLE> so having a fast disk and a fast CPU causes the cpu to wait 
longer cause the disk finishes its tasks much faster then the cpu expects?
<ShawnCONSOLE> mem_load final test = 78%
<ShawnCONSOLE> so final numbers:
<ShawnCONSOLE> 99, 80%, 87%, 83%, 75%
<riel> yes, a very fast CPU falls idle more quickly
<riel> but it's very curious that ext3 is _that_ much worse than ext2
<ShawnCONSOLE> thats much better.
<riel> definately worth pointing out to the ext3 maintainers

