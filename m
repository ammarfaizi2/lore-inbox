Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264063AbTEWMsa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 08:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264067AbTEWMsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 08:48:30 -0400
Received: from mout0.freenet.de ([194.97.50.131]:7105 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S264063AbTEWMs1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 08:48:27 -0400
From: Christian Klose <christian.klose@freenet.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: I/O problems in 2.4.19/2.4.20/2.4.21-rc3
Date: Fri, 23 May 2003 15:00:57 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200305231405.54599.christian.klose@freenet.de>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all :-)

I have a problem since Linux Kernel 2.4.19. Copying huge amount of data gives 
me pauses where pauses are disk io pauses, keyboard does not accept input and 
mouse won't move. This depends, sometimes those pauses are 1 to 2 seconds, 
sometimes even more up to 15 seconds where I can not do anything with my 
linux but waiting :-(

For the past weeks I've searched google alot and found almost the same reports 
there but with imho no real fixes. I've tried many different kernel patches 
I've found while searching google (2.4-aa, 2.4-ck, 2.4-wolk, 2.4-rmap) but 
none of them fixes the problem I've experienced. The kernel patches 2.4-ck 
and 2.4-wolk are very good, those pauses are almost gone, but also the 
throughput is horribly decreased. Yesterday, mcp from #kernelnewbies told me, 
that this is the decrease of nr_requests to 32 (or maybe 4? I don't remember 
exactly). I've also tried 2.4-aa patch because I've read about his lowlatency 
elevator which should fix these pauses. Unfortunately the pauses are still 
there and also a decrease in throughput :-(

I've switched my desktop machine back from 2.4.20 to 2.4.18 because these 
pauses are really annoying me. I wonder what changes were made to 2.4.19 
causing these pauses. Please don't get me wrong but it seems so that the Linux 
Kernel is not ready for desktop yet, and I even wonder about guaranteed io 
throughput for serverusage (please read down below)

This is also not a problem of my hardware. I've tried the same scenario on 
almost 20 different machines in my company, starting with a small 500mhz cpu 
and udma 100 intel controller up to a Pentium 4 with 2,4 GHz with an Adaptec 
U160 scsi controller and u160 scsi disks with software raid-0 and raid-1.

Carl-Daniel Hailfinger has been very helpfull yesterday on #kernelnewbies 
trying to track this behaviour down. He advised me to use SysRq-T and to 
press this key combination while there are io pauses. Maybe he will find out 
what's going on there :-)



Beside that, I've also noticed that there is no guaranteed io throughput while 
copying data in 2.4.18 up to 2.4.21-rc3. My machine has 512MB of memory and 
512MB swap. Right after bootup of linux, there is guaranteed io throughput 
until the memory is almost completely used (with buffers or cache? ... 
/proc/meminfo tells me so) and linux starts to swap. After this, copying data 
starts up with 30mb per second and goes down real fast to 1mb per second and 
even more worse down to ~250kb per second, goes up to 10mb per second and so 
on, so this varies alot.


Anyway, I've also read about kernel 2.5 and that this kernel should fix all of 
the above I've mentioned. So by reading all these great oppinions about 
kernel 2.5 I've tried it out last week and I just have to say that I cannot 
see any advantages, at least not for these 2 cases I've mentioned :-(((

Is it just me or are there many others noticing this too?


Please excuse my bad english but I hope everyone understands me :-)


PS: Should I CC this to Marcello Tosatti and Linus Torvalds too? I haven't 
done this yet but maybe it may help because both are the maintainers of 2.4/ 
2.5 (at least that's what I've found in google). Sorry, I am using Linux 
since ~ 1 1/2 years now and my knowledge about the Linux Kernel is not that 
big.


Thank you so much and have a nice weekend :-)

bye, Chris


