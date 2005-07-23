Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262317AbVGWDVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262317AbVGWDVG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 23:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbVGWDVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 23:21:05 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:43932 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262317AbVGWDVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 23:21:04 -0400
Subject: Re: Giving developers clue how many testers verified
	certain	kernel version
From: Lee Revell <rlrevell@joe-job.com>
To: Alejandro Bonilla <abonilla@linuxwireless.org>
Cc: Blaisorblade <blaisorblade@yahoo.it>, LKML <linux-kernel@vger.kernel.org>,
       Andrian Bunk <bunk@stusta.de>, "H. Peter Anvin" <hpa@zytor.com>,
       torvalds@osdl.org
In-Reply-To: <42E1A832.7010604@linuxwireless.org>
References: <200507230244.11338.blaisorblade@yahoo.it>
	 <42E1986B.8070202@linuxwireless.org> <1122088160.6510.7.camel@mindpipe>
	 <42E1A832.7010604@linuxwireless.org>
Content-Type: text/plain
Date: Fri, 22 Jul 2005 23:21:02 -0400
Message-Id: <1122088863.6510.19.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-07-22 at 21:15 -0500, Alejandro Bonilla wrote:
> OK, I will, but I first of all need to learn how to tell if benchmarks 
> are better or worse.

Con's interactivity benchmark looks quite promising for finding
scheduler related interactivity regressions.  It certainly has confirmed
what we already knew re: SCHED_FIFO performance, if we extend that to
SCHED_OTHER which is a more interesting problem then there's serious
potential for improvement.  AFAIK no one has posted any 2.4 vs 2.6
interbench results yet...

I suspect a lot of the boot time issue is due to userspace.  But, it
should be trivial to benchmark this one, just use the TSC or whatever to
measure the time from first kernel entry to execing init().

Lee 

