Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261636AbULIWTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261636AbULIWTk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 17:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261646AbULIWTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 17:19:40 -0500
Received: from bgm-24-94-57-164.stny.rr.com ([24.94.57.164]:28291 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261636AbULIWTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 17:19:35 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-12
From: Steven Rostedt <rostedt@goodmis.org>
To: john cooper <john.cooper@timesys.com>
Cc: Ingo Molnar <mingo@elte.hu>, Rui Nuno Capela <rncbc@rncbc.org>,
       LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>,
       Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>,
       "K.R. Foley" <kr@cybsft.com>, Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>, emann@mrv.com,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
In-Reply-To: <41B8B6A0.5030101@timesys.com>
References: <20041124101626.GA31788@elte.hu>
	 <20041203205807.GA25578@elte.hu> <20041207132927.GA4846@elte.hu>
	 <20041207141123.GA12025@elte.hu>
	 <1102526018.25841.308.camel@localhost.localdomain>
	 <32950.192.168.1.5.1102529664.squirrel@192.168.1.5>
	 <1102532625.25841.327.camel@localhost.localdomain>
	 <32788.192.168.1.5.1102541960.squirrel@192.168.1.5>
	 <1102543904.25841.356.camel@localhost.localdomain>
	 <20041209093211.GC14516@elte.hu>  <20041209131317.GA31573@elte.hu>
	 <1102602829.25841.393.camel@localhost.localdomain>
	 <1102619992.3882.9.camel@localhost.localdomain>
	 <41B8B6A0.5030101@timesys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Kihon Technologies
Date: Thu, 09 Dec 2004 17:19:09 -0500
Message-Id: <1102630749.3236.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-12-09 at 15:33 -0500, john cooper wrote:
> Steven Rostedt wrote:
> 
> > ...Also, am I the only one that
> > has highmem support enabled, because this looks like this bug would have
> > been triggered by anyone.
> 
> I have not encountered this in -12 with CONFIG_HIGHMEM4G
> running on an SMP Opteron with 1GB memory.  Details attached.

Hi John,

Could you do me a big favor? Put a print in mm/highmem.c bounce_copy_vec
to see if you get into it.  If you don't then it seems that my system is
triggering this and it just so happens that yours does not. Looking at
my dump, it shows that there may have been some contention in the ide
interrupt. 

I let it run for a little longer and the system does eventually get to a
login prompt, but I'm looking into this further.

-- Steve
