Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316684AbSFZXsF>; Wed, 26 Jun 2002 19:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316686AbSFZXsE>; Wed, 26 Jun 2002 19:48:04 -0400
Received: from ep09.kernel.pl ([212.87.11.162]:46655 "EHLO ep09.kernel.pl")
	by vger.kernel.org with ESMTP id <S316684AbSFZXsD>;
	Wed, 26 Jun 2002 19:48:03 -0400
Date: Thu, 27 Jun 2002 01:47:58 +0200 (CEST)
From: Witek Krecicki <adasi@kernel.pl>
To: linux-kernel@vger.kernel.org
Subject: Software suspend bug
Message-ID: <Pine.LNX.4.44L.0206270141320.8612-100000@ep09.kernel.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel version 2.5.24-dj2. While trying to do software suspend I got 
following messages:
-----
[root@pldmachine root]# /tmp/shutdown -z now
Suspend Machine: Stopping processes
Suspend Machine: Waiting for tasks to stop... 
:::::::::::::::::::::::::::::::::: stopping tasks failed (2 tasks 
remaining)
Suspend Machine: Not all processes stopped!
Resume Machine: Restarting tasks...<6> Strange, mdrecoveryd not stopped
 Strange, eth0 not stopped
 done
-----
Those tasks from ps
-----
[root@pldmachine root]# ps uax |egrep  'mdrecovery|eth0'
root       604  0.3  0.0     0    0 ?        SW   01:29   0:03 [mdrecoveryd]
root      1093  0.4  0.0     0    0 ?        SW   01:29   0:04 [eth0]
-----
It just seems like softsuspend cannot suspend kernel threads.

Witek Krecicki

