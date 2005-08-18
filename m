Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932275AbVHRQFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbVHRQFI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 12:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbVHRQFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 12:05:08 -0400
Received: from r3az252.chello.upc.cz ([213.220.243.252]:57791 "EHLO
	aquarius.doma") by vger.kernel.org with ESMTP id S932276AbVHRQFH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 12:05:07 -0400
Message-ID: <4304B1AB.90209@ribosome.natur.cuni.cz>
Date: Thu, 18 Aug 2005 18:04:59 +0200
From: =?UTF-8?B?TWFydGluIE1PS1JFSsWg?= <mmokrejs@ribosome.natur.cuni.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050815
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: openafs is really faster on linux-2.4. than 2.6
References: <43032109.6030709@ribosome.natur.cuni.cz> <200508182257.35544.kernel@kolivas.org> <43048D81.80402@ribosome.natur.cuni.cz> <200508182331.56217.kernel@kolivas.org>
In-Reply-To: <200508182331.56217.kernel@kolivas.org>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Con,
  thank you for anwers. It seems my main confusion was that values in 'id' and
'wa' columns in vmstat(1) output do not reflect the 2.4 kernel stats well.
The timing shows that the real time is more or less same and we could only argue
if the sys time is significantly higher on 2.6 kernel or not. So, there
ios no problem with the kernel. ;)


on 2.4.31 (read from local xfs disk to another disk with ext2 fs):

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 5  0      0 252932   4172 2637980    0    0 57856 47500 1548  1884  2 27 71  0
 1  1      0 136192   4172 2754716    0    0 58368 52804 1599  1885  2 24 74  0
 2  1      0  85588   4172 2805052    0    0 61696 51600 1636  1965  5 40 55  0
 1  1      0  85376   4172 2804764    0    0 59520 53828 1623  1848  3 45 52  0
 3  1      0  85772   4172 2805036    0    0 60288 50112 1609  1875  1 33 66  0
 1  1      0  85784   4172 2804364    0    0 58240 50300 1567  1835  2 43 55  0
 2  1      0  85468   4172 2805116    0    0 61824 47516 1666  2149  4 47 50  0
 1  1      0  85956   4172 2808144    0    0 58496 49708 1570  2087  3 33 64  0
 2  1      0  84792   4172 2809344    0    0 58112 51992 1585  2058  3 27 70  0
 2  1      0  86176   4172 2807836    0    0 58240 52836 1599  2029  1 29 70  0
 2  1      0  86164   4172 2803968    0    0 62080 53500 1664  2085  2 40 58  0
 2  1      0  85152   4172 2804940    0    0 57600 51320 1572  1837  3 37 60  0
 1  1      0  85840   4172 2804592    0    0 58752 52500 1603  1917  2 48 50  0
 1  1      0  85760   4128 2804836    0    0 58368 51100 1577  1853  3 35 62  0
 0  2      0  85456   4128 2804532    0    0  3712 45740  675   289  0  6 94  0
 1  1      0  84796   4128 2805896    0    0 30592 47528 1113  1047  0 27 73  0
 1  1      0  85708   4132 2808376    0    0 52356 43612 1422  1755  0 26 74  0
 1  1      0  85852   4132 2808212    0    0 58368 46252 1528  1880  2 35 63  0
 1  1      0  86120   4136 2807972    0    0 50052 46212 1411  1740  3 30 67  0
 1  1      0  82728   4136 2808276    0    0 57472 50500 1560  1866  4 29 67  0
 3  1      0  83316   4140 2807428    0    0 56324 44780 1490  1875  2 39 59  0
 2  1      0  82332   4140 2807960    0    0 59648 48724 1578  1905  0 34 66  0


time bash -c "dd if=~mmokrejs/video/kamcatka2004.dv of=/mnt/ext2/kamcatka2004.dv bs=1024 count=4096000; sync"
4096000+0 records in
4096000+0 records out

real    1m29.880s
user    0m1.600s
sys     0m12.220s

or in another attempt:

real    1m33.282s
user    0m1.430s
sys     0m12.180s


on 2.6.13-rc6-git9 (read from local xfs disk to another disk with ext2 fs):

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1 10      0  85452   7628 2754552    0    0 57984 52188  876  1647  2 36  0 62
 0 10      0  85452   7380 2756932    0    0 59520 46260  862  1620  1 41  0 58
 1  9      0  85080   7424 2756564    0    0 53636 46188  838  1515  1 34  0 65
 1  9      0  85328   7476 2755472    0    0 59400 51077  897  1737  1 39  0 60
 1 10      0  85204   7528 2754940    0    0 53508 51456  844  1513  2 33  0 65
 0 10      0  85452   7580 2753804    0    0 58368 50956  879  1682  2 33  0 65
 0 10      0  85204   7636 2753180    0    0 56196 51512  869  1597  2 33  0 65
 0 10      0  85204   7688 2752176    0    0 61696 45856  906  1728  1 36  0 63
 1  9    196  85080   7740 2753368    0    0 54276 51456  848  1572  1 40  0 59
 0 10    196  85328   7784 2752968    0    0 59008 30752  888  1658  1 40  0 59
 0 10    196  85328   7820 2753376    0    0 58368 23520  883  1659  1 33  0 66
 1 10    196  85452   7856 2753016    0    0 58756 48164  922  1646  1 37  0 62
 0 10    196  85328   7252 2754324    0    0 57600 49172  878  1609  1 37  0 62
 1  9    196  85204   7296 2754564    0    0 56708 43176  853  1598  2 36  0 62
 1 10    196  85204   7324 2754496    0    0 59392 47600  882  1674  0 41  0 59
 0 10    196  85328   7288 2754280    0    0 54660 46200  831  1531  1 34  0 65
 1  9    196  85452   7224 2753856    0    0 59008 45808  876  1657  2 37  0 61
 0 10    196  85080   7164 2753880    0    0 57476 46144  865  1619  2 34  0 64
 0 10    196  85204   7116 2753480    0    0 56968 46209  860  1658  1 32  0 67

# time bash -c "dd if=~mmokrejs/video/kamcatka2004.dv of=/mnt/ext2/kamcatka2004.dv bs=1024 count=4096000; sync"
4096000+0 records in
4096000+0 records out

real    1m31.067s
user    0m0.760s
sys     0m15.809s

and another trial:

real    1m31.266s
user    0m0.796s
sys     0m16.361s


>>The throughput is clearly lower on 2.6 kernel and definitely the
>>CPU is in my eyes unnecessarily blocked... Why is the CPU in the
>>wait state instead of idle (this is teh problem on 2.6 series
>>but CPU is free on 2.4 series)? That's the main problem I think at the
>>moment.
> 
> 
> There is no wait state accounted for in 2.4 so you won't see it.


