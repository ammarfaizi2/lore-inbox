Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274802AbTGaPqT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 11:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272545AbTGaPof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 11:44:35 -0400
Received: from pop.univ-lyon1.fr ([134.214.100.7]:25276 "EHLO
	pop.univ-lyon1.fr") by vger.kernel.org with ESMTP id S272550AbTGaPn7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 11:43:59 -0400
Message-ID: <3F2934DA.2050708@creatis.insa-lyon.fr>
Date: Thu, 31 Jul 2003 17:25:14 +0200
From: Mathieu Malaterre <Mathieu.Malaterre@creatis.insa-lyon.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: fr, en, en-us
MIME-Version: 1.0
To: "Scott L. Burson" <gyro@zeta-soft.com>
Cc: linux-kernel@vger.kernel.org, hw.support@amd.com
Subject: Re: Spinlock performance on Athlon MP (2.4)
References: <16168.12542.850631.294911@kali.zeta-soft.com>
In-Reply-To: <16168.12542.850631.294911@kali.zeta-soft.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scott L. Burson wrote:
> Hi,
> 
> First, and probably the reason you haven't heard more complaints about the
> problem, its severity is evidently dependent on the size of main memory.  At
> 512MB it doesn't seem to be much of a problem (right, Mathieu?). 

Right. I have 1.5 GB and can reproduce the problem.
And 'append mem=512M' in lilo made things works nicely too.

> At 2.5GB,
> which is what I have, it can be quite serious.  For instance, if I start two
> `find' processes at the roots of different filesystems, the system can spend
> (according to `top') 95% - 98% of its time in the kernel.  It even gets
> worse than that, but `top' stops updating -- in fact, the system can seem
> completely frozen, but it does recover eventually.  Stopping or killing one
> of the `find' processes brings it back fairly quickly, though it can take a
> while to accomplish that.

In fact, last week I had such bad warm reboots that I opened the box and 
all of a sudden everythings was working fine again.

So I would say I have a problem of low power supply or fan. And I think 
I have read some post about it in the past:

[System Starvation under heavy io load with HIGHMEM4G]
http://www.ussg.iu.edu/hypermail/linux/kernel/0303.2/1435.html

[Tyan 2460/Dual Athlon MP hangs]
http://www.ussg.iu.edu/hypermail/linux/kernel/0207.0/0040.html

Eventhought I have a Tyan S2460, I read that:
[The Thunder K7 is an Extended ATX board, measuring 12 × 13 inches. It 
only supports Registered DDR PC1600/2100 memory, so your old DIMMs won't 
work. Your old power supply won't work either. The Thunder K7 needs an 
extra 8-pin power connector. It's not the same extra power connector 
that Intel Pentium 4 Xeon-based motherboards need either, so you must 
get a special power supply that currently only will work with this one 
board.]
http://www.linuxjournal.com/bg/advice/ulb_02.php

What do you think of it ?

Here is my uptime:

$ uptime
   5:15pm  up 3 days,  3:18, 13 users,  load average: 0.08, 0.25, 0.21
And I have been running rather heavy jobs ('make -j') with a lot of IO...

One final thing, I am pretty novice at those things, so please 
appologize if I said something completely dumb.

my 2 cents,
mathieu

