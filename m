Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129071AbRBVMy5>; Thu, 22 Feb 2001 07:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129134AbRBVMyr>; Thu, 22 Feb 2001 07:54:47 -0500
Received: from gate.in-addr.de ([212.8.193.158]:24587 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S129071AbRBVMym>;
	Thu, 22 Feb 2001 07:54:42 -0500
Date: Thu, 22 Feb 2001 13:54:40 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4 vs 2.2 performance under load comparison
Message-ID: <20010222135440.M1320@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.3i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning,

I did a comparison between 2.4 and 2.2.18 (+ Andrea's patches), using the
respective latest SuSE kernels, but the results should apply to the versions
in general.

Situation: SAP R/3 + SAP DB + benchmark driver running on a single node 4 CPU
SMP machine, tuned down to 1GB of RAM.

Running the SAP benchmark with 75 users on 2.2 yields for the first benchmark
run:

- 7018ms average response time
- 2967s CPU time in 1136s elapsed time
- ~500MB swap allocated
- ~1500 pages paged in/s, 268 pages/out/s on average

Running the same benchmark on 2.4:

- ~700ms average response time
- 1884s CPU time in 669s elapsed time
- ~500MB swap allocated
- ~50 pages paged in, ~212 pages paged out per second on average

Running the same benchmark the second time on both machines to get them warmed
up, 2.2 stays in approximately the same range, while 2.4 gets even _better_,
dropping down to ~350ms response time and ~20 pages in/out.

This is a rather amazing improvement in swapping performance.

Rik, it's time for you to break it again *g*

Sincerely,
    Lars Marowsky-Brée <lars.marowsky-bree@sap.com>
    SuSE Linux AG at the SAP LinuxLab - lmb@suse.de

-- 
Perfection is our goal, excellence will be tolerated. -- J. Yahl

