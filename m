Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269731AbRHIIPS>; Thu, 9 Aug 2001 04:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269732AbRHIIPI>; Thu, 9 Aug 2001 04:15:08 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:47368 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S269731AbRHIIOz>; Thu, 9 Aug 2001 04:14:55 -0400
Date: Thu, 9 Aug 2001 03:45:47 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@zip.com.au>, Zach Brown <zab@osdlab.org>,
        linux-mm@kvack.org
Subject: vmstats patch against 2.4.8pre7 and new userlevel hack  
Message-ID: <Pine.LNX.4.21.0108090326470.14424-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

I've updated the vmstats patch to use Andrew Morton's statcount facilities
(which is in initial development state). I've also removed/added some
statistics due to VM changes.

On the userlevel side, I got zab's cpustat nice tool and transformed it
into an ugly hack which allows me to easily add/remove statistic
counters.

Adding a new statistic counter just needs (on the kernel side): 

VMSTAT(stat_name); (for global stats)

or 

VMSTAT_ZONE(zone, stat_name); (for perzone stats) 

On userlevel side, one line with corresponding stat_name, plus the field
name to be reported in the userlevel tool output for the given stat. 

Easy. 

The patch including the statcounts facilities
http://bazar.conectiva.com.br/~marcelo/patches/v2.4/2.4.8pre7/vmstats.patch

The userlevel tool
http://bazar.conectiva.com.br/~marcelo/nvmstat-0.1/nvmstat-0.1.tar.gz

