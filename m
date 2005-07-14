Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262794AbVGNXH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbVGNXH2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 19:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbVGNXFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 19:05:19 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:4553 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S262692AbVGNXEE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 19:04:04 -0400
X-ORBL: [63.202.173.158]
Date: Thu, 14 Jul 2005 16:03:45 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Christoph Lameter <christoph@lameter.com>
Cc: Linus Torvalds <torvalds@osdl.org>, john stultz <johnstul@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Lee Revell <rlrevell@joe-job.com>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       Andrew Morton <akpm@osdl.org>, Len Brown <len.brown@intel.com>,
       dtor_core@ameritech.net, david.lang@digitalinsight.com,
       davidsen@tmr.com, kernel@kolivas.org,
       lkml <linux-kernel@vger.kernel.org>, mbligh@mbligh.org,
       diegocg@gmail.com, azarah@nosferatu.za.org
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Message-ID: <20050714230345.GA26213@taniwha.stupidest.org>
References: <Pine.LNX.4.63.0507131810430.13193@twinlark.arctic.org> <1121304825.4435.126.camel@mindpipe> <Pine.LNX.4.58.0507131847000.17536@g5.osdl.org> <1121326938.3967.12.camel@laptopd505.fenrus.org> <20050714121340.GA1072@ucw.cz> <Pine.LNX.4.58.0507140933150.19183@g5.osdl.org> <1121360561.3967.55.camel@laptopd505.fenrus.org> <1121370122.7673.161.camel@cog.beaverton.ibm.com> <Pine.LNX.4.58.0507141307060.19183@g5.osdl.org> <Pine.LNX.4.62.0507141340001.17567@graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0507141340001.17567@graphe.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2005 at 01:41:44PM -0700, Christoph Lameter wrote:

> AFAIK John simply wants to change jiffies to count in nanoseconds
> since bootup and then call it "clock_monotonic".

Clocks and counter drift so calling it <prefix>seconds would be
misleading.  It would really only be good for approximate timing.

I think call it something arbitrary and work towards have a separate
mechanism for time of day (which could end up being much more
expensive to use but less frrequently needed).

> One 64 bit value no splitting into seconds and nanoseconds anymore.

Using a 64-bit value is a pain on some (many?) 32-bit CPUs.
