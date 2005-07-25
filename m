Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261562AbVGYAr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbVGYAr5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 20:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbVGYAr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 20:47:56 -0400
Received: from imap.gmx.net ([213.165.64.20]:29402 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261562AbVGYAr4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 20:47:56 -0400
X-Authenticated: #28678167
Message-ID: <42E4373D.1070607@gmx.net>
Date: Mon, 25 Jul 2005 02:50:05 +0200
From: Andreas Baer <lnx1@gmx.net>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050725)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problem with Asus P4C800-DX and P4 -Northwood-
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

First I want to say sorry for this BIG post, but it seems that I have no 
other chance. :)

I have a Asus P4C800-DX with a P4 2,4 GHz 512 KB L2 Cache "Northwood" 
Processor (lowest Processor that supports HyperThreading) and 1GB DDR400 
RAM. I'm also running S-ATA disks with about 50 MB/s (just to show that 
it shouldn't be due to hard disk speed). Everything was bought back in 
2003 and I recently upgraded to the lastest BIOS Version. I've installed 
Gentoo Linux and WinXP with dual-boot on this system.

Now to my problem:

I'm currently developing a little database in C++ (runs currently under 
Windows and Linux) that internally builds up an R-Tree and does a lot of 
equality tests and other time consuming checks. For perfomance issue I 
ran a test with 200000 entries and it took me about 3 minutes to 
complete under Gentoo Linux.

So I ran the same test in Windows on the same platform and it took about 
30(!) seconds. I was a little bit surprised about this result so I 
started to run several tests on different machines like an Athlon XP 
2000+ platform and on my P4 3GHz "Prescott" Notebook and they all showed 
something about 30 seconds or below. Then I began to search for errors 
or any misconfiguration in Gentoo, in my code and also for people that 
have made equal experiences with that hardware configuration on the 
internet. I thought I have a problem with a broken gcc or libraries like 
glibc or libstdc++ and so I recompiled my whole system with the stable 
gcc 3.3.5 release, but that didn't make any changes. I also tried an 
Ubuntu and a Suse LiveCD to verify that it has nothing to do with Gentoo 
and my kernel version and they had the same problem and ran the test in 
about 3 min.

Currently I'm at a loss what to do. I'm beginning to think that this is 
maybe a kernel problem because I have no problems under Windows and it 
doesn't matter whether I change any software or any configuration in 
Gentoo. I'm currently running kernel-2.6.12, but the Livecd's had other 
kernels.

HyperThreading(HT) is also not the reason for the loss of power, because 
I tried to disable it and to create a uniprocessor kernel, but that 
didn't solve the problem.

If you need some output of my configuration/log files or anything like 
that, just mail me.

Is it possible that the kernel has a lack of support for P4 with 
"Northwood" core? Maybe only this one? Could I solve the problem if I 
change the processor to a "Prescott" core? Perhaps someone could provide 
any information if this would make any sense or not.

Thanks in advance for anything that could help.

...sorry for bad english :)
