Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261209AbVGVPJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbVGVPJz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 11:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbVGVPJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 11:09:55 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:51429 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261209AbVGVPJy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 11:09:54 -0400
Subject: Re: New timeofday subsystem: Lockups
From: john stultz <johnstul@us.ibm.com>
To: Frank Sorenson <frank@tuxrocks.com>
Cc: lkml <linux-kernel@vger.kernel.org>, George Anzinger <george@mvista.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>, benh@kernel.crashing.org,
       Nishanth Aravamudan <nacc@us.ibm.com>
In-Reply-To: <42E0A968.8060105@tuxrocks.com>
References: <1121484326.28999.3.camel@cog.beaverton.ibm.com>
	 <42E0A968.8060105@tuxrocks.com>
Content-Type: text/plain
Date: Fri, 22 Jul 2005 08:09:28 -0700
Message-Id: <1122044969.2954.7.camel@leatherman>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-07-22 at 02:08 -0600, Frank Sorenson wrote:
> I'm not sure whether this is an issue with John's TOD patches, John's
> NTP rework, or Nish's softtimer patches, but something in this
> combination seems to be locking up my system frequently.  Often, it will
> completely hang during boot, and it periodically hangs while starting X
> or even just under normal (unstressed) use.
> 
> During several of the boot-ups, the NMI Watchdog has caught lockups.
> Here is the output of one of those lockups (hand-copied, so hopefully no
> mistakes):

Thanks for the detailed bug report! Hmmm. It looks like the TSC
interpolator is deadlocking. I'll try to dig in and hunt that one down
(although forgive me if I don't get back to you until sometime next
week).

Thanks again for the great testing and reporting!
-john

