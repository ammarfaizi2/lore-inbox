Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965090AbVITTbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965090AbVITTbp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 15:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965093AbVITTbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 15:31:45 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:6276 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S965090AbVITTbp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 15:31:45 -0400
Subject: Re: [discuss] Re: [PATCH] x86-64: Fix bad assumption that dualcore
	cpus have synced TSCs
From: john stultz <johnstul@us.ibm.com>
To: Scott Lampert <scott@lampert.org>
Cc: "Langsdorf, Mark" <mark.langsdorf@amd.com>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       discuss@x86-64.org
In-Reply-To: <433061E4.20903@lampert.org>
References: <84EA05E2CA77634C82730353CBE3A843032187C4@SAUSEXMB1.amd.com>
	 <433061E4.20903@lampert.org>
Content-Type: text/plain
Date: Tue, 20 Sep 2005 12:30:56 -0700
Message-Id: <1127244656.11080.24.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-20 at 12:24 -0700, Scott Lampert wrote:
> Langsdorf, Mark wrote:
> >>Personally I suspect that the powernow driver is putting the 
> >>cores independently into low power sleep and the TSCs are 
> >>being independently halted, causing them to become unsynchronized.
> >
> >The powernow-k8 driver doesn't know what a low power sleep state
> >is, so I strongly doubt it is involved here.  It only handles
> >pstates.
> > 
> Just to add some end-user input here, I see the same issues regardless 
> of whether I'm running with the powernow-k8 or not.  The clock problems 
> seem to be unrelated to that, at least on my system.

Hmmm. Ok, I don't know the cpufreq/power management code well enough. 

I know some Intel cpus halt the TSC in C3. Could the ACPI code be
causing this? 

Could anyone with better knowledge speak to why it looks like the TSCs
are unsynced? Is my test flawed?

thanks
-john


