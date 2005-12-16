Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbVLPCb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbVLPCb5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 21:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbVLPCb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 21:31:56 -0500
Received: from fsmlabs.com ([168.103.115.128]:46771 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S932086AbVLPCbz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 21:31:55 -0500
X-ASG-Debug-ID: 1134700308-8293-46-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Thu, 15 Dec 2005 18:37:15 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
cc: "Luck, Tony" <tony.luck@intel.com>, hawkes@sgi.com,
       Tony Luck <tony.luck@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Jack Steiner <steiner@sgi.com>, Keith Owens <kaos@sgi.com>,
       Dimitri Sivanich <sivanich@sgi.com>
X-ASG-Orig-Subj: Re: [PATCH] ia64: disable preemption in udelay()
Subject: Re: [PATCH] ia64: disable preemption in udelay()
In-Reply-To: <1134698636.12086.222.camel@mindpipe>
Message-ID: <Pine.LNX.4.64.0512151835540.20020@montezuma.fsmlabs.com>
References: <20051214232526.9039.15753.sendpatchset@tomahawk.engr.sgi.com> 
 <20051215225040.GA9086@agluck-lia64.sc.intel.com> 
 <Pine.LNX.4.64.0512151750500.1678@montezuma.fsmlabs.com>
 <1134698636.12086.222.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.6341
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Dec 2005, Lee Revell wrote:

> On Thu, 2005-12-15 at 17:52 -0800, Zwane Mwaikambo wrote:
> > 
> > If it's a preemptible sleep period it should just use msleep.
> 
> There are 10 drivers that udelay(10000) or more and a TON that
> udelay(1000).  Turning those all into 1ms+ non preemptible sections will
> be very bad.

What i said was _msleep_, if the driver is sleeping for 10ms and it can 
handle being preempted, you can switch it over to _msleep_. The original 
post was regarding making udelay non-preemptible.
