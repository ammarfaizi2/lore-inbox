Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261506AbVGWDeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbVGWDeX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 23:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262315AbVGWDeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 23:34:23 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:46493 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261506AbVGWDeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 23:34:22 -0400
Subject: Re: Giving developers clue how many testers verified certain
	kernel version
From: Lee Revell <rlrevell@joe-job.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alejandro Bonilla <abonilla@linuxwireless.org>,
       Blaisorblade <blaisorblade@yahoo.it>,
       LKML <linux-kernel@vger.kernel.org>, Andrian Bunk <bunk@stusta.de>,
       "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <Pine.LNX.4.58.0507222029200.6074@g5.osdl.org>
References: <200507230244.11338.blaisorblade@yahoo.it>
	 <42E1986B.8070202@linuxwireless.org> <1122088160.6510.7.camel@mindpipe>
	 <42E1A832.7010604@linuxwireless.org> <1122088863.6510.19.camel@mindpipe>
	 <Pine.LNX.4.58.0507222029200.6074@g5.osdl.org>
Content-Type: text/plain
Date: Fri, 22 Jul 2005 23:34:18 -0400
Message-Id: <1122089660.6510.29.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-07-22 at 20:31 -0700, Linus Torvalds wrote:
> 
> On Fri, 22 Jul 2005, Lee Revell wrote:
> > 
> > Con's interactivity benchmark looks quite promising for finding
> > scheduler related interactivity regressions.
> 
> I doubt that _any_ of the regressions that are user-visible are
> scheduler-related. They all tend to be disk IO issues (bad scheduling or
> just plain bad drivers), and then sometimes just VM misbehaviour.
> 
> People are looking at all these RT patches, when the thing is that most
> nobody will ever be able to tell the difference between 10us and 1ms
> latencies unless it causes a skip in audio.

I agree re: the RT patches, but what makes Con's benchmark useful is
that it also tests interactivity (measuring in msecs vs. usecs) with
everything running SCHED_NORMAL, which is a much better approximation of
a desktop load.  And the numbers do go well up into the range where
people would notice, tens and hundreds of ms.

Lee



