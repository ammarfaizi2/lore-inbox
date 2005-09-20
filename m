Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964928AbVITIhz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964928AbVITIhz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 04:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964931AbVITIhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 04:37:55 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:25325 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964928AbVITIhy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 04:37:54 -0400
Date: Tue, 20 Sep 2005 09:14:01 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Christoph Lameter <clameter@engr.sgi.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, george@mvista.com, johnstul@us.ibm.com,
       paulmck@us.ibm.com
Subject: Re: [ANNOUNCE] ktimers subsystem
Message-ID: <20050920071401.GB14285@elte.hu>
References: <20050919184834.1.patchmail@tglx.tec.linutronix.de> <Pine.LNX.4.62.0509191500040.27238@schroedinger.engr.sgi.com> <1127168232.24044.265.camel@tglx.tec.linutronix.de> <Pine.LNX.4.62.0509191521400.27238@schroedinger.engr.sgi.com> <1127169849.24044.279.camel@tglx.tec.linutronix.de> <Pine.LNX.4.62.0509191601490.27528@schroedinger.engr.sgi.com> <1127171542.24044.301.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127171542.24044.301.camel@tglx.tec.linutronix.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> > Applications call gettimeofday for a variety of reasons. One is because it 
> > is widely available over different platformsn and application want to 
> > schedule things, need timestamps etc etc.
> 
> Accepted. But I still doubt that the number of calls to gettimeofday 
> is in anyway justified. The question I'm asking if it is really worth 
> a long and epic discussion about a single add instruction ?

it is absolutely and emphatically not worth it.

even in a hypothetical scenario [which this patchset is _not_ analogous 
to] where a new, clean subsystem introduces significant overhead, but 
the old subsystem is unclean, we frequently go with the new one - 
because it's so much easier to speed up something that is clean, robust 
and well-designed, than something that has been cobbled together!

	Ingo
