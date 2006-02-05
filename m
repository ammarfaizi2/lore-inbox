Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932284AbWBEBAt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbWBEBAt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 20:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbWBEBAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 20:00:48 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:37520 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751488AbWBEBAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 20:00:48 -0500
Subject: Re: athlon 64 dual core tsc out of sync
From: Lee Revell <rlrevell@joe-job.com>
To: Albert Cahalan <acahalan@gmail.com>
Cc: linux-kernel@vger.kernel.org, s0348365@sms.ed.ac.uk, safemode@comcast.net
In-Reply-To: <787b0d920602041224p660911b5mc4d639581736e96f@mail.gmail.com>
References: <787b0d920602041224p660911b5mc4d639581736e96f@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 04 Feb 2006 20:00:42 -0500
Message-Id: <1139101243.2791.78.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-02-04 at 15:24 -0500, Albert Cahalan wrote:
> There have been far too many other problems with i386 timekeeping as
> well.  Really, it's crazy to not use the pmtmr if the pmtmr is
> available. The next best choice would be HPET. After that, pre-SMM
> systems should count clock ticks and post-SMM systems should read the
> RTC or PIT registers. Until we accept this, we'll always be suffering
> clock problems. 

Well, I wouldn't say it's crazy - the TSC is several orders of magnitude
cheaper than the PM timer, and the only common hardware where it's
completely useless are Athlon X2 systems.

Fortunately there's a solution in the works - John Stultz's gettimeofday
rework.  Try the -rt tree for a preview.

Lee

