Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261514AbTC3TPD>; Sun, 30 Mar 2003 14:15:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261515AbTC3TPD>; Sun, 30 Mar 2003 14:15:03 -0500
Received: from janus.zeusinc.com ([205.242.242.161]:14132 "EHLO
	zso-proxy.zeusinc.com") by vger.kernel.org with ESMTP
	id <S261514AbTC3TPC>; Sun, 30 Mar 2003 14:15:02 -0500
Subject: Re: Bad interactive behaviour in 2.5.65-66 (sched.c)
From: Tom Sightler <ttsig@tuxyturvy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: rml@tech9.net, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030329212330.225a96b6.akpm@digeo.com>
References: <3E8610EA.8080309@telia.com> <1048987260.679.7.camel@teapot>
	 <1048989922.13757.20.camel@localhost>
	 <200303301233.03803.kernel@kolivas.org>
	 <1048992365.13757.23.camel@localhost>
	 <1048996723.3058.41.camel@iso-8590-lx.zeusinc.com>
	 <20030329212330.225a96b6.akpm@digeo.com>
Content-Type: text/plain
Message-Id: <1049052171.4651.7.camel@iso-8590-lx.zeusinc.com>
Mime-Version: 1.0
Date: 30 Mar 2003 14:24:28 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-03-30 at 00:23, Andrew Morton wrote:
> Tom Sightler <ttsig@tuxyturvy.com> wrote:
> >
> > On my system I get a starvation issue with just about any CPU intensive
> > task.  For example if create a bzip'd tar file from the linux kernel
> > source with the command:
> > 
> > tar cvp linux | bzip2 -9 > linux.tar.bz2
> > 
> 
> Ingo has determined that Linus's backboost trick is causing at least some
> of these problems. Please test and report upon the below patch.

OK, this definitely makes a big difference for my test cases which
include that 'tar' above as well as a run of dvd::rip.  Without this
patch everything else on my system drops to a total crawl, especially
which dvd::rip is running, dvd::rip itself won't even switch tabs.  With
this patch everything seems quite normal and snappy.

I'll try a few more test cases but backing this out certainly seems to
restore the system to the same behavior as 2.5.64.  BTW, I'm running
this on 2.5.65-mm4.  I would have tested on 2.5.66-mm1 but for some
reason my system locks solid after only a few minutes with it.  I
haven't tried to track that down yet.

Later,
Tom
 

