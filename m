Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265195AbUJHVWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265195AbUJHVWs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 17:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265234AbUJHVWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 17:22:48 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:43737 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S265195AbUJHVWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 17:22:44 -0400
Subject: Re: [PATCH] Realtime LSM
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Morton <akpm@osdl.org>
Cc: chrisw@osdl.org, realtime-lsm@modernduck.com,
       linux-kernel <linux-kernel@vger.kernel.org>, torbenh@gmx.de,
       "Jack O'Quin" <joq@io.com>
In-Reply-To: <20041008142121.328b8d3a.akpm@osdl.org>
References: <1094967978.1306.401.camel@krustophenia.net>
	 <20040920202349.GI4273@conscoop.ottawa.on.ca>
	 <20040930211408.GE4273@conscoop.ottawa.on.ca>
	 <1096581213.24868.19.camel@krustophenia.net>
	 <87pt43clzh.fsf@sulphur.joq.us> <20040930182053.B1973@build.pdx.osdl.net>
	 <87k6ubcccl.fsf@sulphur.joq.us>
	 <1096663225.27818.12.camel@krustophenia.net>
	 <20041001142259.I1924@build.pdx.osdl.net>
	 <1096669179.27818.29.camel@krustophenia.net>
	 <20041001152746.L1924@build.pdx.osdl.net> <877jq5vhcw.fsf@sulphur.joq.us>
	 <1097193102.9372.25.camel@krustophenia.net>
	 <1097269108.1442.53.camel@krustophenia.net>
	 <20041008142121.328b8d3a.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1097270554.1442.67.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 08 Oct 2004 17:22:35 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-08 at 17:21, Andrew Morton wrote:
> Lee Revell <rlrevell@joe-job.com> wrote:
> >
> > Here's an updated patch, only
> > difference is line numbers.
> 
> Nice patch.  Wanna tell me something about what it's for?
> 
> I haven't been following the "Realtime LSM" thread and I'd rather not have to
> prepare a description of your work for you.
> 

Oh, sorry.  Here's the description from my original post:

The realtime-lsm Linux Security Module, written by Torben Hohn and Jack
O'Quin, selectively grants realtime capabilities to specific user groups
or applications.  The typical use for this is low latency audio, and the
patch has been extensively field tested by Linux audio users.  The
realtime LSM is a major improvement in security over the 2.4 capablities
patch and other workarounds like jackstart, which rely on CAP_SETPCAP.

This has been extensively field tested, and undeniably satisfies a
demand (unlike some other LSMs posted lately).  Here is the the author's
more detailed explanation:

"We would never have developed this LSM had there not been a serious
need.  Audio developers have been struggling for years with the need
to apply specialized kernel patches to get acceptable realtime
operation.  Audio is very intolerant of realtime glitches.  They cause
nasty pops in the output.  And, large audio applications should not
run as `root'.  The 2.4 "capabilities patch" was never a satisfactory
solution.

Thanks to the good work being done on 2.6, we are now close to being
able to do serious realtime work with standard kernels available
everwhere.  The LSM framework is an important element of that
solution, with the realtime LSM a small but essential component,
because it makes these features available without excessive
administrative burden.  Many musicians have a Mac or Windows
background.  They are not willing to perform complex system
administration tasks to get good audio performance.  PAM is great for
sophisticated sysadmins on shared systems.  But, I seriously doubt
many musicians will be able to configure it correctly.  For a
single-user Digital Audio Workstation it is overkill.

So, even if you do provide a more general solution, I will probably
have to continue supporting the realtime-lsm interface throughout the
2.6 kernel life-cycle, as there will be enough users for it to be a
defacto standard.  If it is no longer needed in the 2.8 timeframe, I
can drop support then.

It's hard to say how many people use realtime-lsm right now.
SourceForge lists about 1500 source downloads over the last six
months.  Binary copies are included in the most popular audio-oriented
distributions, including Planet CCRMA and DeMuDi.  I guess there are
probably no more than a few thousand active users."

Lee

