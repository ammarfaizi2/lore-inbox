Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbTKBLET (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 06:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbTKBLET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 06:04:19 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1997 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261644AbTKBLER
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 06:04:17 -0500
Date: Sun, 2 Nov 2003 11:04:16 +0000
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: Florian Reitmeir <squat@riot.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: many ide drives, raid0/raid5
Message-ID: <20031102110416.GD762@gallifrey>
References: <20031102031713.GA3464@squat.noreply.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031102031713.GA3464@squat.noreply.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.6.0-test9 (i686)
X-Uptime: 11:00:30 up 1 day, 14:22,  1 user,  load average: 0.06, 0.34, 0.38
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Florian Reitmeir (squat@riot.org) wrote:
> Hi,
> 
> i'm using on the machine kernel 2.6.0-test6-mm1 and 15 IDE
> Drives. Everything worked fine (uptime about 30 days) > I used, some
> raid5's, below some raid0's and on top evms.

> 
> heres "cat /proc/mdstat" so its more clear
> 
> ============ cut 
> Personalities : [raid0] [raid5]
> md4 : active raid5 hdp[2] hdo[1] hdn[0]
>       120627072 blocks level 5, 32k chunk, algorithm 2 [4/3] [UUU_]

This isn't too unusual; if as you say the drives are fine then I'd agree
it is probably a controller issue.  I've got a RAID that does this
regularly and you normally find in the log somewhere an IDE error of
some type (typically it dropping out of DMA due to a busy or it not
responding).

I've given up using multiple IDE PCI cards for this - they only just
work, and occasionally you'll get a glitch like this.  I've tried
a mixture of Promise and HPT cards.  In the end I gave up and got
a 3ware IDE RAID card which is working fine (you could just use it
as a large multichannel IDE card and run soft raid if you want I think).

Dave
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
