Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261372AbVENXlB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261372AbVENXlB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 19:41:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbVENXlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 19:41:00 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:25060 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261372AbVENXkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 19:40:53 -0400
Subject: Re: Hyper-Threading Vulnerability
From: Lee Revell <rlrevell@joe-job.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@redhat.com>,
       Matt Mackall <mpm@selenic.com>, Andy Isaacson <adi@hexapodia.org>,
       Andi Kleen <ak@muc.de>, "Richard F. Rebel" <rrebel@whenu.com>,
       Gabor MICSKO <gmicsko@szintezis.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tytso@mit.edu
In-Reply-To: <1116100126.6007.17.camel@laptopd505.fenrus.org>
References: <1115963481.1723.3.camel@alderaan.trey.hu>
	 <m164xnatpt.fsf@muc.de> <1116009483.4689.803.camel@rebel.corp.whenu.com>
	 <20050513190549.GB47131@muc.de> <20050513212620.GA12522@hexapodia.org>
	 <20050513215905.GY5914@waste.org>
	 <1116024419.20646.41.camel@localhost.localdomain>
	 <1116025212.6380.50.camel@mindpipe>  <20050513232708.GC13846@redhat.com>
	 <1116027488.6380.55.camel@mindpipe>
	 <1116084186.20545.47.camel@localhost.localdomain>
	 <1116088229.8880.7.camel@mindpipe>
	 <1116089068.6007.13.camel@laptopd505.fenrus.org>
	 <1116093396.9141.11.camel@mindpipe>
	 <1116093694.6007.15.camel@laptopd505.fenrus.org>
	 <1116098504.9141.31.camel@mindpipe>
	 <1116100126.6007.17.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Sat, 14 May 2005 19:40:52 -0400
Message-Id: <1116114052.9141.38.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-05-14 at 21:48 +0200, Arjan van de Ven wrote:
> On Sat, 2005-05-14 at 15:21 -0400, Lee Revell wrote:
> > On Sat, 2005-05-14 at 20:01 +0200, Arjan van de Ven wrote:
> > > On Sat, 2005-05-14 at 13:56 -0400, Lee Revell wrote:
> > > > On Sat, 2005-05-14 at 18:44 +0200, Arjan van de Ven wrote:
> > > > > then JACK is terminally broken if it doesn't have a fallback for non-
> > > > > rdtsc cpus. 
> > > > 
> > > > It does have a fallback, but the selection is done at compile time.  It
> > > > uses rdtsc for all x86 CPUs except pre-i586 SMP systems.
> > > > 
> > > > Maybe we should check at runtime,
> > > 
> > > it's probably a sign that JACK isn't used on SMP systems much, at least
> > > not on the bigger systems (like IBM's x440's) where the tsc *will*
> > > differ wildly between cpus...
> > 
> > Correct.  The only bug reports we have seen related to the use of the
> > TSC is due to CPU frequency scaling.  The fix is to not use it - people
> > who want to use their PC as a DSP for audio probably don't want their
> > processor slowing down anyway. 
> 
> it's a matter of time (my estimate is a year or two) before processors
> get variable frequencies based on temperature targets etc...
> and then rdtsc is really useless for this kind of thing..

I was under the impression that P4 and later processors do not vary the
TSC rate when doing frequency scaling.  This is mentioned in the
documentation for the high res timers patch.

Lee

