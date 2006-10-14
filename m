Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161107AbWJNJ6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161107AbWJNJ6U (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 05:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161103AbWJNJ6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 05:58:19 -0400
Received: from poczta.o2.pl ([193.17.41.142]:42136 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S1161107AbWJNJ6S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 05:58:18 -0400
From: =?iso-8859-2?q?=A3ukasz_Fibinger?= <lucke@o2.pl>
Reply-To: lucke@o2.pl
To: linux-kernel@vger.kernel.org
Date: Sat, 14 Oct 2006 11:58:14 +0200
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Disposition: inline
Subject: cpufreq not working after putting core down and up
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200610141158.15006.lucke@o2.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear kernel hackers,

I'm having this peculiar issue on my Athlon 64 X2 3800+ (Asus A8N-E 
motherboard, latest BIOS) box. 
Namely, after I put one core offline and then online, its cpufreq driver 
doesn't work anymore.

	# cd /sys/devices/system/cpu/cpu1

        # ls                                                                  
 	cache  cpufreq  crash_notes  online  topology

	# echo 0 >> online
	# echo 1 >> online

	# ls
	cache  crash_notes  online  topology

Note the lack of "cpufreq" symlink to cpu0/cpufreq in cpu1 dir. 

This behaviour prohibits me from using cpufreq after resuming a suspended 
system.

I have been trying to track down the issue for ca. two months. Yet, I failed 
to pinpoint the culprit. Mark Langsdorf (AMD) provided me with his kind 
assistance on cpufreq mailinglist, but we failed to come to any 
conclusions/solutions (for one, Mark couldn't reproduce it himself). I only 
managed to find a report of a similar problem by a Turion X2 user, yet it 
allegedly disappeared after him moving from ArchLinux to Ubuntu. However, no 
other X2 user of ArchLinux (my distro of choice) seems to suffer from the 
same problem (except that Turion guy), not even on a A8N-E MB. My tests 
weren't full-blown (due to the lack of resources), but it seems that the 
problem persists on different distros on my box as well. I tried quite a 
bunch of different kernel/kernel config combinations too, without effect. I 
fail to find any relationship (reminds me of a criptid hunt) -  thus, I'm 
totally clueless whether it's a hardware/kernel/userspace problem.

Any suggestions would be greatly appreciated. Of course, I'm able to provide 
dmesg with cpufreq debugging or what else is needed upon request.

As I'm not suscribed to lkml, please kindly CC all replies to my address.

Regards,

Luke
