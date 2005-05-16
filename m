Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261880AbVEPVBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbVEPVBN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 17:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbVEPVAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 17:00:16 -0400
Received: from palrel10.hp.com ([156.153.255.245]:44213 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S261882AbVEPU7A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 16:59:00 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17033.2445.545597.210557@napali.hpl.hp.com>
Date: Mon, 16 May 2005 13:58:53 -0700
To: john stultz <johnstul@us.ibm.com>
Cc: Christoph Lameter <clameter@engr.sgi.com>,
       David Mosberger <davidm@hpl.hp.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Dominik Brodowski <linux@dominikbrodowski.de>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max Asbock <masbock@us.ibm.com>, mahuja@us.ibm.com,
       Nishanth Aravamudan <nacc@us.ibm.com>, Darren Hart <darren@dvhart.com>,
       "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org, linux-ia64@vger.kernel.org
Subject: Re: IA64 implementation of timesource for new time of day subsystem
In-Reply-To: <1116276824.13867.15.camel@cog.beaverton.ibm.com>
References: <1116029796.26454.2.camel@cog.beaverton.ibm.com>
	<1116029872.26454.4.camel@cog.beaverton.ibm.com>
	<1116029971.26454.7.camel@cog.beaverton.ibm.com>
	<1116030058.26454.10.camel@cog.beaverton.ibm.com>
	<1116030139.26454.13.camel@cog.beaverton.ibm.com>
	<Pine.LNX.4.62.0505141251490.18681@schroedinger.engr.sgi.com>
	<1116264858.26990.39.camel@cog.beaverton.ibm.com>
	<Pine.LNX.4.62.0505161100240.1653@schroedinger.engr.sgi.com>
	<1116269136.26990.67.camel@cog.beaverton.ibm.com>
	<Pine.LNX.4.62.0505161219570.2158@schroedinger.engr.sgi.com>
	<17032.62615.750699.18847@napali.hpl.hp.com>
	<1116273055.13867.5.camel@cog.beaverton.ibm.com>
	<Pine.LNX.4.62.0505161325330.2509@schroedinger.engr.sgi.com>
	<1116276824.13867.15.camel@cog.beaverton.ibm.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 16 May 2005 13:53:44 -0700, john stultz <johnstul@us.ibm.com> said:


  John> You've only pointed out two timesources that could want this
  John> (ITC and TSC), so I think its reasonable to do your jitter
  John> handling in the timesource driver. If there are other arches
  John> that have non hardware synced per-cpu counters, then it would
  John> be something to consider.

I think Christopher's point is that _all_ time-sources which require
software syncing will need this since it is not possible to sync
perfectly, even if there is no drift.

	--david
