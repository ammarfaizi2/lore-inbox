Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318286AbSHEBgs>; Sun, 4 Aug 2002 21:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318287AbSHEBgr>; Sun, 4 Aug 2002 21:36:47 -0400
Received: from hall.mail.mindspring.net ([207.69.200.60]:6454 "EHLO
	hall.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S318286AbSHEBgr>; Sun, 4 Aug 2002 21:36:47 -0400
Message-ID: <3D4DD766.1090807@mindspring.com>
Date: Sun, 04 Aug 2002 18:39:50 -0700
From: Walt H <waltabbyh@mindspring.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Raid0 slowdown from 2.4.19-rc1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I've recently upgraded kernels from 2.4.19-rc1 to rc2 and on to final 
and have experienced a dramatic slowdown in raid0 performance since. 
Final 2.4.19 was patched with XFS and preempt and compiled using 
gcc-3.1.1 - I've tried switching compilers to 2.96 (mandrake 8.2), and 
cutting out preempt patches. First md1 array consists of two partitions 
from hda & hdc. hdparm for both drives looks fine by themselves:

[root@waltsathlon walt]# hdparm -t /dev/hda

/dev/hda:
  Timing buffered disk reads:  64 MB in  1.66 seconds = 38.55 MB/sec
/dev/hdc:
  Timing buffered disk reads:  64 MB in  1.65 seconds = 38.79 MB/sec

However, using them combined as raid0, md1:

/dev/md1:
  Timing buffered disk reads:  64 MB in  1.44 seconds = 44.44 MB/sec

In 2.4.18 and up through 2.4.19-rc1 I saw 66-70MB/sec from this array. 
Starting in rc2 it dropped to the mid 40's. I've also ran bonnie++ and 
confirmed several significant drops, however, not as bad as you would 
think considering the results of hdparm.

Hardware:
Soyo Dragon+ MB w/ Athlon 1800+, 512MB Ram
Drives connected via onboard Promise PDC20265 in ultra mode
2x40GB IBM Deskstar 60GXP (I know....)


Anything else you need, just ask. Please CC me in replies as I'm not a 
member of the list. Thanks,

-Walt

