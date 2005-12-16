Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbVLPCfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbVLPCfF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 21:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbVLPCfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 21:35:05 -0500
Received: from fsmlabs.com ([168.103.115.128]:52147 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S1751143AbVLPCfD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 21:35:03 -0500
X-ASG-Debug-ID: 1134700499-8050-87-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Thu, 15 Dec 2005 18:40:27 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: John Hawkes <hawkes@sgi.com>
cc: Lee Revell <rlrevell@joe-job.com>, "Luck, Tony" <tony.luck@intel.com>,
       Tony Luck <tony.luck@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Jack Steiner <steiner@sgi.com>, Keith Owens <kaos@sgi.com>,
       Dimitri Sivanich <sivanich@sgi.com>
X-ASG-Orig-Subj: Re: [PATCH] ia64: disable preemption in udelay()
Subject: Re: [PATCH] ia64: disable preemption in udelay()
In-Reply-To: <00b201c601e6$30c87ff0$d6069aa3@johnhaonw7lw1r>
Message-ID: <Pine.LNX.4.64.0512151837480.20020@montezuma.fsmlabs.com>
References: <20051214232526.9039.15753.sendpatchset@tomahawk.engr.sgi.com>
 <20051215225040.GA9086@agluck-lia64.sc.intel.com>
 <Pine.LNX.4.64.0512151750500.1678@montezuma.fsmlabs.com>
 <1134698636.12086.222.camel@mindpipe> <00b201c601e6$30c87ff0$d6069aa3@johnhaonw7lw1r>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.6341
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Dec 2005, John Hawkes wrote:

> From: "Lee Revell" <rlrevell@joe-job.com>
> > There are 10 drivers that udelay(10000) or more and a TON that
> > udelay(1000).  Turning those all into 1ms+ non preemptible sections will
> > be very bad.
> 
> What about 100usec non-preemptible sections?
> John Hawkes

100usec should be ok as a non-preemptible udelay is this 1 specific 
driver?

