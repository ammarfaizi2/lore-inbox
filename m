Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265649AbSJXVJa>; Thu, 24 Oct 2002 17:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265653AbSJXVJa>; Thu, 24 Oct 2002 17:09:30 -0400
Received: from air-2.osdl.org ([65.172.181.6]:45757 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265649AbSJXVJ3>;
	Thu, 24 Oct 2002 17:09:29 -0400
Message-Id: <200210242115.g9OLFgm01694@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: 2.4.18 - iostat problem with DAC960
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 24 Oct 2002 14:15:42 -0700
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We are running some benchmarks with raw disk connected to a DAC960 
controller. We are having issues with getting proper stats from iostat.

We've tried the latest version we could find ( sysstat version 4.0.6 ) 
In normal use, we get bizzare numbers, like this:
Device:    rrqm/s wrqm/s   r/s   w/s  rsec/s  wsec/s    rkB/s    wkB/s 
avgrq-sz avgqu-sz   await  svctm  %util
/dev/rd/c0d0
             0.00   0.00  0.00  0.00    0.00    0.00     0.00     0.00     
0.00 42933903.02    0.00   0.00 100.00

Looking at /proc/partitions, we are also confused, since we see 0 for wio and 
rio (and we just did a big dd ) :
[root@dev8-004 root]# cat /proc/partitions | grep c0d0
major minor  #blocks   name     rio rmerge   rsect     ruse wio wmerge   wsect 
    wuse running  use      aveq
48     0     107504640 rd/c0d0  0   11734288 105255266 0    0   12286553 
104803536 0     2232980 36066697 37688171

Any suggestions? 
cliffw


