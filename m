Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbTDCRnA 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 12:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S261513AbTDCRnA 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 12:43:00 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:21646 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP
	id S261493AbTDCRmU 
	(for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 12:42:20 -0500
Date: Thu, 3 Apr 2003 19:53:45 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.66-mm2
In-Reply-To: <20030401000127.5acba4bc.akpm@digeo.com>
Message-ID: <Pine.LNX.4.51.0304031947321.16306@dns.toxicfilms.tv>
References: <20030401000127.5acba4bc.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

remember my post about the machine locking up for a few seconds?
This time i've a vmstat report with 2.5.66-mm2, it's just to let you know
the stats during the lockup, i think they differ, there is no significant
swapping, so i think it's not a swapping issue.
I will try running the machine with mm3, with my next reboot.

Here are the printouts, 3 minutes of the machine stalling and when it was
becoming more responsive it was very sluggish, abnormally, some apps where
responding, some not.
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0  49220   4432   1840  45420    2    2    81    70  547    17 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0  49220   4312   1840  45548    2    2    81    70  547    17 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0  49220   4192   1840  45676    2    2    81    70  547    17 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0  49220   4048   1856  45804    2    2    81    70  547    17 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0  49220   3928   1856  45932    2    2    81    70  547    17 59  2 38  1
-----
czw kwi  3 17:11:06 CEST 2003
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0  49220   3928   1856  45936    2    2    81    70  547    17 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0  49220   4816   1832  45064    2    2    81    70  547    17 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0  49220   4576   1832  45320    2    2    81    70  547    17 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0  49220   4408   1848  45448    2    2    81    70  548    17 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  2  49216   4688   1900  44840    2    2    81    70  548    17 59  2 38  1
-----
czw kwi  3 17:11:11 CEST 2003
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0  49216   4816   1996  43852    2    2    81    70  548    17 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0  49216   4328   2032  44184    2    2    81    70  548    17 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  2  49216   4208   2100  44196    2    2    81    70  548    17 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  1  49216   4728   2128  43252    2    2    81    70  548    17 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  0  49216   4608   2128  43380    2    2    81    70  548    17 59  2 38  1
-----
czw kwi  3 17:11:16 CEST 2003
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  2  50168   1992    664  37472    2    2    81    70  548    17 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  1  52760   3532    476  35304    2    2    81    70  548    17 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  1  53476   1936    304  27436    2    2    81    70  548    17 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0  53796   3216    296  27264    2    2    81    70  548    17 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0  53796   3032    296  27392    2    2    81    70  548    17 59  2 38  1
-----
czw kwi  3 17:11:23 CEST 2003
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  1  53796   3824    296  27068    2    2    81    70  548    17 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0  53820   3848    312  27152    2    2    81    70  548    17 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0  53820   3632    316  27288    2    2    81    70  548    17 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0  53820   3448    316  27496    2    2    81    70  548    17 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0  53820   3284    316  27624    2    2    81    70  548    17 59  2 38  1
-----
czw kwi  3 17:11:28 CEST 2003
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0  53820   3192    316  27764    2    2    81    70  548    17 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  0  54088   3984    320  27068    2    2    81    70  548    17 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  0  54088   3904    320  27156    2    2    81    70  548    17 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0  54088   3784    320  27284    2    2    81    70  548    17 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0  54088   3592    320  27412    2    2    81    70  548    17 59  2 38  1
-----
czw kwi  3 17:11:33 CEST 2003
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0  54088   3232    320  27680    2    2    81    70  548    17 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  1  54088   3880    324  26632    2    2    81    70  548    17 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0  54088   3880    324  26664    2    2    81    70  548    17 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0  54088   3688    324  26852    2    2    81    70  548    17 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0  54088   3376    324  27108    2    2    81    70  548    17 59  2 38  1
-----
czw kwi  3 17:11:38 CEST 2003
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0  54088   3088    332  27388    2    2    81    70  548    17 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  3  54656   2712    360  28632    2    2    81    70  548    17 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  0  55528   3480    360  28876    2    2    81    70  548    17 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0  55528   3192    360  29136    2    2    81    70  548    17 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  2  55528   3248    484  27980    2    2    81    70  548    17 59  2 38  1
-----
czw kwi  3 17:11:44 CEST 2003
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  3  56284   3540    484  28532    2    2    82    70  548    17 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  1  56844   3208    488  28516    2    2    82    70  548    18 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  0  56972   3472    664  28564    2    2    82    70  548    18 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0  56972   3232    664  28820    2    2    82    70  548    18 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  0  56972   3592    604  28532    2    2    82    70  548    18 59  2 38  1
-----
czw kwi  3 17:11:49 CEST 2003
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0  56972   3304    624  28784    2    2    82    70  548    18 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0  56972   3432    600  28716    2    2    82    70  548    18 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0  56972   3144    600  29008    2    2    82    70  548    18 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0  56972   3552    600  28592    2    2    82    70  548    18 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0  56972   3384    600  28768    2    2    82    70  548    18 59  2 38  1
-----
czw kwi  3 17:11:54 CEST 2003
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 2  0  56972   3488    616  28536    2    2    82    70  548    18 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0  56972   3344    616  28664    2    2    82    70  548    18 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0  56972   3272    616  28748    2    2    82    70  548    18 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  0  56972   3560    608  28472    2    2    82    70  548    18 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0  56972   3356    608  28680    2    2    82    70  548    18 59  2 38  1
-----
czw kwi  3 17:11:59 CEST 2003
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0  56972   3236    624  28784    2    2    82    70  548    18 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  0  56972   3404    608  28644    2    2    82    70  548    18 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0  56972   3236    608  28768    2    2    82    70  548    18 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  0  56972   3336    608  28656    2    2    82    70  548    18 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0  56972   3600    612  28580    2    2    82    70  548    18 59  2 38  1
-----
czw kwi  3 17:12:04 CEST 2003
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0  56972   3336    616  28820    2    2    82    70  548    18 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0  56972   3216    616  28948    2    2    82    70  548    18 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0  56972   3384    584  28708    2    2    82    70  548    18 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0  56972   3264    584  28816    2    2    82    70  548    18 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  0  56972   3520    596  28580    2    2    82    70  548    18 59  2 38  1
-----
czw kwi  3 17:12:09 CEST 2003
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0  56972   3304    596  28792    2    2    82    70  548    18 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  0  56972   3472    572  28656    2    2    82    70  548    18 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0  56972   3328    572  28812    2    2    82    70  548    18 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  0  56972   3576    560  28564    2    2    82    70  548    18 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  0  56972   3340    576  28788    2    2    82    70  548    18 59  2 38  1
-----
czw kwi  3 17:12:15 CEST 2003
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0  56972   3464    572  28668    2    2    82    70  548    18 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0  56972   3320    572  28820    2    2    82    70  548    18 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  0  56972   3568    572  28568    2    2    82    70  548    18 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0  56972   3376    572  28756    2    2    82    70  548    18 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  2  56972   3164    592  28680    2    2    82    70  548    18 59  2 38  1
-----
czw kwi  3 17:12:20 CEST 2003
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0  57216   3404    616  28720    2    2    82    70  548    18 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  4  58184   4412    628  28896    2    2    82    70  548    18 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  4  58988   3356    696  29104    2    2    82    70  548    18 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  2  59736   3836    780  29044    2    2    82    70  548    18 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  2  59736   3636    860  29600    2    2    82    70  548    18 59  2 38  1
-----
czw kwi  3 17:12:46 CEST 2003
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  3  62760   3836    888  30400    2    2    82    70  548    18 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  3  64092   3808    792  31200    2    2    82    70  548    18 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  3  64824   2652    496  31884    2    2    82    70  548    18 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  4  67032   3808    496  31156    2    2    82    70  549    19 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  4  68156   3332    488  31000    2    2    82    70  549    19 59  2 38  1
-----
czw kwi  3 17:12:55 CEST 2003
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  2  69872   3124    568  31200    2    2    82    70  549    19 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  2  70688   3128    644  30792    2    2    82    70  549    19 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  4  70688   2160    884  30676    2    2    82    70  549    19 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  4  72976   3272    960  28928    2    2    82    70  549    19 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  3  73384   3328   1036  28020    2    2    82    70  549    19 59  2 38  1
-----
czw kwi  3 17:13:03 CEST 2003
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  5  75020   1948   1132  26556    2    2    83    70  549    19 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  6  75092   2076    916  26848    2    2    83    70  549    19 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  2  75284   3416    980  24744    2    2    83    70  549    19 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  2  75284   3536   1024  23324    2    2    83    70  549    19 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  2  75896   3776    976  22896    2    2    83    70  549    19 59  2 38  1
-----
czw kwi  3 17:13:11 CEST 2003
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  2  75896   2880   1012  22136    2    2    83    70  549    19 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  4  76840   2628   1004  22100    2    2    83    70  549    19 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  1  77528   3372    964  21948    2    2    83    70  549    19 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  2  78160   3552    976  21572    2    2    83    70  549    19 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  2  78160   3312   1000  21368    2    2    83    70  549    19 59  2 38  1
-----
czw kwi  3 17:13:16 CEST 2003
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  1  78940   2572   1164  21460    2    2    83    70  549    19 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  1  78940   2476   1524  21552    2    2    83    70  549    19 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  3  80016   2716   1676  20952    2    2    83    71  549    19 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  1  80640   3156   1516  22236    2    2    83    71  549    19 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 2  0  78448  19228   1556  27388    2    2    83    71  549    19 59  2 38  1
-----
czw kwi  3 17:13:23 CEST 2003
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  1  78448   5072   1564  32820    2    2    83    71  549    19 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  2  79300   4104   1668  33264    2    2    83    71  549    19 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  3  79336   3120   1792  34352    2    2    83    71  549    19 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  3  80256  19800   1692  35328    2    2    83    71  549    19 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 3  0  79604  17372   1816  36912    2    2    84    71  549    19 59  2 38  1
-----
czw kwi  3 17:13:29 CEST 2003
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 2  1  79604   4748   1848  42228    2    2    84    71  549    19 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  5  79688   4404   1640  40964    2    2    84    71  549    19 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 2  8  79688   3300   1532  42208    2    2    84    71  549    19 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  2  79688  19016   1440  36264    2    2    84    71  549    20 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  1  79688  17352   1548  37636    2    2    84    71  549    20 59  2 38  1
-----
czw kwi  3 17:13:55 CEST 2003
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 2  1  79688  15888   1932  38468    2    2    84    71  549    20 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  2  79688  15572   2072  39068    2    2    84    71  549    20 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0  79688  15140   2076  39252    2    2    84    71  549    20 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0  79688  14988   2092  39380    2    2    84    71  549    20 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  0  79680  20928   2112  38160    2    2    84    71  549    20 59  2 38  1
-----
czw kwi  3 17:14:00 CEST 2003
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0  79680  20640   2116  38456    2    2    84    71  549    20 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  3  79660  12328   2156  42468    2    2    84    71  549    20 59  2 38  1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  4  79660   3672   1900  50732    2    2    84    71  549    20 59  2 38  1
