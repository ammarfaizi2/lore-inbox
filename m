Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263523AbTJWKfF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 06:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263524AbTJWKfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 06:35:05 -0400
Received: from [203.199.93.15] ([203.199.93.15]:1033 "EHLO
	WS0005.indiatimes.com") by vger.kernel.org with ESMTP
	id S263523AbTJWKe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 06:34:59 -0400
From: "vwake" <vwake@indiatimes.com>
Message-Id: <200310231005.PAA20811@WS0005.indiatimes.com>
To: <linux-kernel@vger.kernel.org>
Reply-To: "vwake" <vwake@indiatimes.com>
Subject: High Utilization kswapd and kupdated in Large memory system 
Date: Thu, 23 Oct 2003 15:58:49 +0530
X-URL: http://indiatimes.com
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On large memory machine ( 32 GB RAM) any continuous disk activity puts kswapd and kupdated to 99% utilization and eventually ( in about 10 mins) brings down the whole machine.

The machine works well when the memory was set at 4GB using the 'mem=" entry on grub.conf. The same disk operations succeed when kept in this config.


The kernel is version 2.4.22 stable downloaded from kernel.org, and compiled with 64GB option enabled. The machine is installed with Redhat Linux 9.0.

No errors gets logged anywhere and also there are no console error messages. The machine eventually gets locked up, and only a hard reset will bring it back into shape. I do not suspect the hardware because it is reproduceable in a different machine with similar hardware config.

The hardware config as below:

Dell PE 6650 / 4* Xeon 2GHz / 32 GB RAM / 500 GB Raid 5 on PERC 3DC ( AMI megaraid driver) 6 DISCS / 2* Broadcom 100/1000 NIC ( bcm5700 driver) 

The system has / and /boot in ext3 and rest in ReiserFS. The 500 GB data partition is in ReiserFS.

The problem is reproducible by just copying some large data ( 3-5 GB ) to any of the filesystems.
One observation ( may not be useful) is that the symptoms starts after the cached memory in /proc/meminfo goes beyond 16GB !


I had tried changing the "elvtune" parameters to " -r 4096 -w 8192" as adviced in some of the archived maillist mails. But this didnt help !

Please let me know if any further information is needed from the machine.

Thanks... 

Vivek



Get Your Private, Free E-mail from Indiatimes at http://email.indiatimes.com

 Buy The Best In BOOKS at http://www.bestsellers.indiatimes.com

Bid for for Air Tickets @ Re.1 on Air Sahara Flights. Just log on to http://airsahara.indiatimes.com and Bid Now !

