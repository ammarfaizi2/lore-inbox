Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263666AbTL3B0G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 20:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263800AbTL3B0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 20:26:05 -0500
Received: from mail5.bluewin.ch ([195.186.1.207]:18098 "EHLO mail5.bluewin.ch")
	by vger.kernel.org with ESMTP id S263666AbTL3B0C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 20:26:02 -0500
Date: Tue, 30 Dec 2003 02:25:52 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Thomas Molina <tmolina@cablespeed.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 performance problems
Message-ID: <20031230012551.GA6226@k3.hellgate.ch>
Mail-Followup-To: Thomas Molina <tmolina@cablespeed.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0312291647410.5288@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312291647410.5288@localhost.localdomain>
X-Operating-System: Linux 2.6.0-test11 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Dec 2003 17:07:46 -0500, Thomas Molina wrote:
> Execution time for the test was:
> real	13m33.482s
> user	0m33.540s
> sys	0m16.210s
> 
> 
> Under 2.6 top shows:
> user	nice	system	irq	softirq	iowait	idle
> 0.9	0	5.3	0.9	0.3	92.6	0
> 
> Execution time for the test was:
> real	22m42.397s
> user	0m37.753s
> sys	0m54.043s
> 
> I've done no performance tweaking in either case.  Both tests were done 
> immediately after boot up with only the top program running in each case.  
> I'm not sure what other data would be relevant here.  Any thoughts from 
> the group would be appreciated.

I bet this is just yet another instance of a problem we've been
discussing on lkml and linux-mm for several months now (although Linus
asking for DMA presumably means it's not as well known as I thought
it was).

Basically, when you need to resort to paging for getting work done on
2.6 you're screwed. Your bk export takes a lot more memory than you
have RAM in your machine, right?

Check the archives for this thread:
2.6.0-test9 - poor swap performance on low end machines

Roger
