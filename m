Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263171AbVGNWud@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263171AbVGNWud (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 18:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263164AbVGNWuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 18:50:08 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:62339 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S263170AbVGNWsx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 18:48:53 -0400
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: john stultz <johnstul@us.ibm.com>, Arjan van de Ven <arjan@infradead.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Lee Revell <rlrevell@joe-job.com>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       Len Brown <len.brown@intel.com>, dtor_core@ameritech.net,
       david.lang@digitalinsight.com, davidsen@tmr.com, kernel@kolivas.org,
       lkml <linux-kernel@vger.kernel.org>, mbligh@mbligh.org,
       diegocg@gmail.com, azarah@nosferatu.za.org, christoph@lameter.com
In-Reply-To: <Pine.LNX.4.58.0507141307060.19183@g5.osdl.org>
References: <d120d50005071312322b5d4bff@mail.gmail.com>
	 <1121286258.4435.98.camel@mindpipe> <20050713134857.354e697c.akpm@osdl.org>
	 <20050713211650.GA12127@taniwha.stupidest.org>
	 <Pine.LNX.4.63.0507131639130.13193@twinlark.arctic.org>
	 <20050714005106.GA16085@taniwha.stupidest.org>
	 <Pine.LNX.4.63.0507131810430.13193@twinlark.arctic.org>
	 <1121304825.4435.126.camel@mindpipe>
	 <Pine.LNX.4.58.0507131847000.17536@g5.osdl.org>
	 <1121326938.3967.12.camel@laptopd505.fenrus.org>
	 <20050714121340.GA1072@ucw.cz>
	 <Pine.LNX.4.58.0507140933150.19183@g5.osdl.org>
	 <1121360561.3967.55.camel@laptopd505.fenrus.org>
	 <1121370122.7673.161.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.58.0507141307060.19183@g5.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1121381026.3747.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 14 Jul 2005 23:43:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-07-14 at 21:13, Linus Torvalds wrote:
> There is no way to avoid having some kind of counter to specify time.  
> NONE. The only choice is what you base your notion of time on, and how you
> represent it. Do you represent it as two separate counters and try to make
> it look like "fractions of seconds", or do you represent it as a single
> counter, and make it look like "ticks".

I suspect the problem for some of this is that people think of jiffies
as incrementing by 1. If HZ is right then jiffies can be in nS, it just
won't increment by 1. Its also why jiffies() is better on some platforms
because many machines can answer "what time is it" far more accurately
than they can set interrupts.


