Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbWDENnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbWDENnY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 09:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWDENnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 09:43:24 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:36762 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751148AbWDENnX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 09:43:23 -0400
Date: Wed, 5 Apr 2006 15:40:57 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Roman Zippel <zippel@linux-m68k.org>, johnstul@us.ibm.com,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 0/5] clocksource patches
Message-ID: <20060405134057.GA30299@elte.hu>
References: <Pine.LNX.4.64.0604031431220.25825@scrub.home> <1144126422.5344.418.camel@localhost.localdomain> <Pine.LNX.4.64.0604041218250.32445@scrub.home> <1144236167.5344.581.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1144236167.5344.581.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> > For example above you bascially only state that your clock event source 
> > is superior and the correct way of doing this without any explanation why 
> > (and the "No, thanks." doesn't exactly imply that you're even interested 
> > in alternatives). 
> 
> The question arises, who is not interested in alternatives. You are 
> well aware about the efforts others made, but you don't even think 
> about working together with them. Do you really expect people to jump 
> on your train, when you entirely ignore their work and efforts and 
> just propose your own view of the world?
> 
> I did nowhere say that I'm not interested in alternative solutions.  
> You interpret it into my words for whatever reason.

just to explain it to everyone: the code Thomas refers to and which we 
are working on is John's GTOD patchset with Thomas' high-resolution 
timers patches ontop of it. [all of that (and more) is glued together in 
the -rt tree as well].

Thomas' hrtimers queue (ontop of 2.6.16) is a practical, working 
implementation of the clock-event design Thomas is talking about, 
resulting in a working high-resolution timers solution that spans all 
the relevant Linux APIs: nanosleep() and POSIX timers. So Thomas' 
arguments derive straight from that experience.

for more details, the latest hrtimers code can be found at:

  http://tglx.de/projects/hrtimers

the merge of the hrtimers subsystem into 2.6.16 was just the first step, 
and the next steps are expressed in the patches above.

	Ingo
