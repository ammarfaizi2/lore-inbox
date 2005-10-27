Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751537AbVJ0AlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537AbVJ0AlM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 20:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751542AbVJ0AlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 20:41:11 -0400
Received: from unused.mind.net ([69.9.134.98]:3557 "EHLO echo.lysdexia.org")
	by vger.kernel.org with ESMTP id S1751529AbVJ0AlK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 20:41:10 -0400
Date: Wed, 26 Oct 2005 17:34:06 -0700 (PDT)
From: William Weston <weston@lysdexia.org>
To: john stultz <johnstul@us.ibm.com>
cc: Rui Nuno Capela <rncbc@rncbc.org>, george@mvista.com,
       Ingo Molnar <mingo@elte.hu>,
       Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Mark Knecht <markknecht@gmail.com>,
       Steven Rostedt <rostedt@goodmis.org>,
       david singleton <dsingleton@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       cc@ccrma.Stanford.EDU
Subject: Re: 2.6.14-rc4-rt7
In-Reply-To: <1130369591.27168.358.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.58.0510261715510.20624@echo.lysdexia.org>
References: <1129852531.5227.4.camel@cmn3.stanford.edu>  <20051021080504.GA5088@elte.hu>
 <1129937138.5001.4.camel@cmn3.stanford.edu>  <20051022035851.GC12751@elte.hu>
  <1130182121.4983.7.camel@cmn3.stanford.edu>  <1130182717.4637.2.camel@cmn3.stanford.edu>
  <1130183199.27168.296.camel@cog.beaverton.ibm.com>  <20051025154440.GA12149@elte.hu>
  <1130264218.27168.320.camel@cog.beaverton.ibm.com>  <435E91AA.7080900@mvista.com>
 <20051026082800.GB28660@elte.hu>  <435FA8BD.4050105@mvista.com>
 <435FBA34.5040000@mvista.com>  <435FEAE7.8090104@rncbc.org> 
 <Pine.LNX.4.58.0510261449310.20155@echo.lysdexia.org>
 <1130369591.27168.358.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Oct 2005, john stultz wrote:

> I'm grabbing rt7 to try to reproduce this. Not yet sure what the cause
> could be. From Rui's dmesg the tsc clocksource was being used, I assume
> this is the case with you as well, William?

I found a relatively quick way to trigger the 'time warp' and 'BUG in
get_monotonic_clock_ts' warnings.

	while [ 1 ]; do /bin/date > /dev/null; done

I got 1 to 3 warnings a minute (for the first 5 minutes) with a debug -rt7 
on the xeon/smt box.  ymmv.


--ww
