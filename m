Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932381AbVK2Ufs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbVK2Ufs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 15:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbVK2Ufs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 15:35:48 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:14751 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932381AbVK2Ufr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 15:35:47 -0500
Subject: Re: [RFC][PATCH] Runtime switching of the idle function [take 2]
From: Lee Revell <rlrevell@joe-job.com>
To: Andi Kleen <ak@suse.de>
Cc: "Brown, Len" <len.brown@intel.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
       Andrew Morton <akpm@osdl.org>, acpi-devel@lists.sourceforge.net,
       nando@ccrma.Stanford.EDU, linux-kernel@vger.kernel.org,
       paulmck@us.ibm.com, kr@cybsft.com, tglx@linutronix.de, pluto@agmk.net,
       john.cooper@timesys.com, bene@linutronix.de, dwalker@mvista.com,
       trini@kernel.crashing.org, george@mvista.com
In-Reply-To: <20051129195336.GP19515@wotan.suse.de>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005456F00@hdsmsx401.amr.corp.intel.com>
	 <20051129195336.GP19515@wotan.suse.de>
Content-Type: text/plain
Date: Tue, 29 Nov 2005 15:35:39 -0500
Message-Id: <1133296540.4627.7.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-29 at 20:53 +0100, Andi Kleen wrote:
> We're mostly addressing it - there are problems left, but
> overall it's looking good. The remaining problem is 
> an education issue of users to not use RDTSC directly, 
> but use gettimeofday/clock_gettime 

No the issue is to make gettimeofday fast enough that the people who
currently have to use the TSC can use it.  Right now it's 1500-3000 nsec
or so, Vojtech mentioned that he has a patch that could reduce that to
150-300 nsec.

Lee

