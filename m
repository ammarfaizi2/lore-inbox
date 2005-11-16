Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965218AbVKPDtg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965218AbVKPDtg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 22:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965222AbVKPDtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 22:49:36 -0500
Received: from mxsf35.cluster1.charter.net ([209.225.28.160]:60392 "EHLO
	mxsf35.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S965218AbVKPDtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 22:49:35 -0500
X-IronPort-AV: i="3.97,336,1125892800"; 
   d="scan'208"; a="437478922:sNHT15749352"
Message-ID: <437AABFF.2010405@cybsft.com>
Date: Tue, 15 Nov 2005 21:48:15 -0600
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@us.ibm.com>,
       Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>, pluto@agmk.net,
       john cooper <john.cooper@timesys.com>,
       Benedikt Spranger <bene@linutronix.de>,
       Daniel Walker <dwalker@mvista.com>,
       Tom Rini <trini@kernel.crashing.org>,
       George Anzinger <george@mvista.com>
Subject: Re: 2.6.14-rt13
References: <20051115090827.GA20411@elte.hu>
In-Reply-To: <20051115090827.GA20411@elte.hu>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> i have released the 2.6.14-rt13 tree, which can be downloaded from the 
> usual place:
> 
>    http://redhat.com/~mingo/realtime-preempt/
> 
> lots of fixes in this release affecting all supported architectures, all 
> across the board. Big MIPS update from John Cooper.
> 
> Changes since 2.6.14-rt1:
> 
>  - lots of RCU fixes and updates in signal handling and related areas
>    (Paul E. McKenney)
> 
>  - big RCU torture-test update (Paul E. McKenney)
>

In case anyone else makes the same mistake I did. If you are using the
same config from a previous build, you may have RCU_TORTURE_TEST=Y (not
module) and not even know it when running RT patches. You will however
definitely notice it if you use the config to build a non RT kernel like
2.6.15-rc1. The previous RT patch defaulted RCU_TORTURE_TEST=y. By the
way, the fact that I didn't even notice that the torture test was
running with the RT kernel is a true measure of how well things have
progressed. :-)

-- 
   kr
