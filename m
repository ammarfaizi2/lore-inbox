Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275117AbSITX63>; Fri, 20 Sep 2002 19:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275175AbSITX63>; Fri, 20 Sep 2002 19:58:29 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:17311 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S275117AbSITX61> convert rfc822-to-8bit; Fri, 20 Sep 2002 19:58:27 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.20-pre7-ac3{-rmap14b|-preempt}
Date: Sat, 21 Sep 2002 02:02:54 +0200
X-Mailer: KMail [version 1.4]
Organization: WOLK - Working Overloaded Linux Kernel
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209210125.01953.m.c.p@wolk-project.de>
Cc: Rik van Riel <riel@conectiva.com.br>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Robert Love <rml@tech9.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

just for the interesting people ... ;)
... (and for me to take of some work from Rik, Alan and Robert) ...

I've merged newest rmap14b to latest ac tree and also latest preempt for ac on 
top of rmap.

2.4.20-pre7-ac3 has latest rmap version 13c, therefor a summary of rmap 
changes:


rmap 14b:
  - don't unmap pages not in pagecache (ext3 & reiser)    (Andrew Morton, me)
  - clean up mark_page_accessed a bit                     (me)
  - Alpha NUMA fix for Ingo's per-cpu pages               (Flávio Leitner, me)
  - remove explicit low latency schedule zap_page_range   (Robert Love)
  - fix OOM stuff for good, hopefully                     (me)
rmap 14a:
  - Ingo Molnar's per-cpu pages (SMP speedup)             (Christoph Hellwig)
  - fix SMP bug in page_launder_zone (rmap14 only)        (Arjan van de Ven)
  - semicolon day, fix typo in rmap.c w/ DEBUG_RMAP       (Craig Kulesa)
  - remove unneeded pte_chain_unlock/lock pair vmscan.c   (Craig Kulesa)
  - low latency zap_page_range also without preempt       (Arjan van de Ven)
  - do some throughput tuning for kswapd/page_launder     (me)
  - don't allocate swap space for pages we're not writing (me)
rmap 14:
  - get rid of stalls during swapping, hopefully          (me)
  - low latency zap_page_range                            (Robert Love)


No code change to latest preempt, 2.4.20-pre5-ac4-1. Changelog is available, 
fore sure, at Robert's site: http://www.tech9.net/rml/linux/


-----------------------------------------------------------
NOTE: Apply the rmap14b patch first and then preempt ontop!
-----------------------------------------------------------


This 2 patches are available at: http://sf.net/projects/wolk

Direkt download links:
----------------------
2.4.20-pre7-ac3-rmap14b:
- http://prdownloads.sf.net/wolk/2.4.20-pre7-ac3-rmap14b.patch.gz

2.4.20-pre7-ac3-rmap14b-preempt:
- http://prdownloads.sf.net/wolk/2.4.20-pre7-ac3-rmap14b-preempt.patch.gz


md5sums:
--------
8b3b84f7e44a997e775cbade2ea6b2bb *2.4.20-pre7-ac3-rmap14b-preempt.patch.gz
ea6c2e832f8cab39fc92372536fdf806 *2.4.20-pre7-ac3-rmap14b.patch.gz



Compiled, works, booted, works. Did some workload like 2 full kernel compiles 
at the same time with -j3, dbench 32,64, find /, updatedb. Passed 
successfully (without IDE data loss/corruption/damage to my disks :-)))


Rik, offer it at your homepage, Alan, please apply to future ac, Robert, offer 
it at your homepage too. For sure, just if it looks ok for you :-)


Randy, Con, time to benchmark =)


Have fun! Nice weekend!

-- 
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/569DE2E3DB441A16
Fingerprint: 3469 0CF8 CA7E 0042 7824 080A 569D E2E3 DB44 1A16
Key available at www.keyserver.net. Encrypted e-mail preferred.


