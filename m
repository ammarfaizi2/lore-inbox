Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965155AbVLODQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965155AbVLODQy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 22:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965156AbVLODQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 22:16:54 -0500
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:24728 "EHLO
	adelphi.physics.adelaide.edu.au") by vger.kernel.org with ESMTP
	id S965152AbVLODQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 22:16:54 -0500
From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Message-Id: <200512150318.jBF3Ia9B010880@auster.physics.adelaide.edu.au>
Subject: Re: 2.6.14-rt21: slow-running clock
To: johnstul@us.ibm.com (john stultz)
Date: Thu, 15 Dec 2005 13:48:36 +1030 (CST)
Cc: jwoithe@physics.adelaide.edu.au (Jonathan Woithe),
       linux-kernel@vger.kernel.org
In-Reply-To: <1134610897.27117.4.camel@cog.beaverton.ibm.com> from "john stultz" at Dec 14, 2005 05:41:36 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John

> > > On Fri, 2005-12-09 at 12:49 +1030, Jonathan Woithe wrote:
> > > > > I'm now working on why we mis-compensate the c3tsc clocksource in the
> > > > > -RT tree. 
> > > > 
> > > > No problem.  Let me know when you have something to test or need further
> > > > info.
> > > 
> > > 	Attached is a test patch to see if it doesn't resolve the issue for
> > > you. I get a maximum change in drift of 30ppm when idling between C3
> > > states by being more careful with the C3 TSC compensation and I also
> > > force timekeeping updates when cpufreq events occur. 
> > 
> > Unfortunately there's still an issue.
> 
> Ah, drat. 
> 
> I'm just going to dump the c3tsc clocksource for now. If C3 mode is
> available, the ACPI PM timer is available (since it is used for C3
> timing), so we'll just fall back to ACPI PM if we see the cpu entering
> C3 mode.
>
> I'm working to respin a new release tonight, hopefully that will make it
> upstream to -rt soon and that should take care of it. Later I can look
> at reworking the c3tsc clocksource, but for now things need to just
> work.

Not a problem - I'll test this next release soon (perhaps via -rt) and
confirm that things "just work" for me.  I'm happy to keep testing things -
if you do need further tests done for c3tsc in future drop me a line.

Regards
  jonathan
