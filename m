Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbTEHJLs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 05:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbTEHJLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 05:11:47 -0400
Received: from 015.atlasinternet.net ([212.9.93.15]:24515 "EHLO
	antoli.gallimedina.net") by vger.kernel.org with ESMTP
	id S261230AbTEHJLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 05:11:47 -0400
From: Ricardo Galli <gallir@uib.es>
Organization: UIB
To: Greg KH <greg@kroah.com>
Subject: Re: CPUFreq sysfs interface MIA? (since 2.5.69)
Date: Thu, 8 May 2003 11:24:15 +0200
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <200305071809.12961.gallir@uib.es> <20030507233406.GA4605@kroah.com>
In-Reply-To: <20030507233406.GA4605@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305081124.15242.gallir@uib.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 May 2003 01:34, Greg KH shaped the electrons to shout:
> > The same here, but it worked in 2.5.68. It's a P3 Speedstep.
> > /proc/cpufreq only shows the header.
>
> Can you let me know if the patch I just posted to lkml in this thread
> fixes this for you?

Yes, it does work.

gallir@minime:~$ ls -l /sys/class/cpu/cpu0/cpufreq/
total 0
-r--r--r--    1 root     root         4096 May  8 11:19 cpuinfo_max_freq
-r--r--r--    1 root     root         4096 May  8 11:19 cpuinfo_min_freq
-r--r--r--    1 root     root         4096 May  8 11:19 
scaling_available_governors
-r--r--r--    1 root     root         4096 May  8 11:19 scaling_driver
-rw-r--r--    1 root     root         4096 May  8 11:19 scaling_governor
-rw-r--r--    1 root     root         4096 May  8 11:19 scaling_max_freq
-rw-r--r--    1 root     root         4096 May  8 11:19 scaling_min_freq

gallir@minime:~$ cat /proc/cpufreq
       minimum CPU frequency  -  maximum CPU frequency  -  policy (1)
CPU  0       399000 kHz ( 42 %)  -     931000 kHz (100 %)  -  powersave

Thanks.

-- 
  ricardo galli       GPG id C8114D34
