Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751293AbVLPDQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbVLPDQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 22:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbVLPDQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 22:16:27 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:25533 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751293AbVLPDQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 22:16:26 -0500
Subject: Re: [PATCH] ia64: disable preemption in udelay()
From: Lee Revell <rlrevell@joe-job.com>
To: John Hawkes <hawkes@sgi.com>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Luck, Tony" <tony.luck@intel.com>, Tony Luck <tony.luck@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, Jack Steiner <steiner@sgi.com>,
       Keith Owens <kaos@sgi.com>, Dimitri Sivanich <sivanich@sgi.com>
In-Reply-To: <00b201c601e6$30c87ff0$d6069aa3@johnhaonw7lw1r>
References: <20051214232526.9039.15753.sendpatchset@tomahawk.engr.sgi.com>
	 <20051215225040.GA9086@agluck-lia64.sc.intel.com>
	 <Pine.LNX.4.64.0512151750500.1678@montezuma.fsmlabs.com>
	 <1134698636.12086.222.camel@mindpipe>
	 <00b201c601e6$30c87ff0$d6069aa3@johnhaonw7lw1r>
Content-Type: text/plain
Date: Thu, 15 Dec 2005 22:19:11 -0500
Message-Id: <1134703152.12086.231.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-15 at 18:12 -0800, John Hawkes wrote:
> From: "Lee Revell" <rlrevell@joe-job.com>
> > There are 10 drivers that udelay(10000) or more and a TON that
> > udelay(1000).  Turning those all into 1ms+ non preemptible sections will
> > be very bad.
> 
> What about 100usec non-preemptible sections?

That will disappear into the noise, in normal usage these happen all the
time.  500usec non preemptible regions are rare (~1 hour to show up) and
1ms very rare (24 hours).  My tests show that 300 usec or so is a good
place to draw the line if you don't want it to show up in latency tests.

Lee

