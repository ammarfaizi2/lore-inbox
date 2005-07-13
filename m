Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262625AbVGMVVB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262625AbVGMVVB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 17:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbVGMVTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 17:19:01 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:25829 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S262311AbVGMVRN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 17:17:13 -0400
X-ORBL: [63.202.173.158]
Date: Wed, 13 Jul 2005 14:16:50 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Lee Revell <rlrevell@joe-job.com>, "Brown, Len" <len.brown@intel.com>,
       dtor_core@ameritech.net, torvalds@osdl.org, vojtech@suse.cz,
       david.lang@digitalinsight.com, davidsen@tmr.com, kernel@kolivas.org,
       linux-kernel@vger.kernel.org, mbligh@mbligh.org, diegocg@gmail.com,
       azarah@nosferatu.za.org, christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Message-ID: <20050713211650.GA12127@taniwha.stupidest.org>
References: <42D3E852.5060704@mvista.com> <20050712162740.GA8938@ucw.cz> <42D540C2.9060201@tmr.com> <Pine.LNX.4.62.0507131022230.11024@qynat.qvtvafvgr.pbz> <20050713184227.GB2072@ucw.cz> <Pine.LNX.4.58.0507131203300.17536@g5.osdl.org> <1121282025.4435.70.camel@mindpipe> <d120d50005071312322b5d4bff@mail.gmail.com> <1121286258.4435.98.camel@mindpipe> <20050713134857.354e697c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050713134857.354e697c.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2005 at 01:48:57PM -0700, Andrew Morton wrote:

> Len Brown, a year ago: "The bottom line number to laptop users is
> battery lifetime.  Just today somebody complained to me that Windows
> gets twice the battery life that Linux does."

It seems the motivation for lower HZ is really:

   (1) ACPI/SMM suckage in laptops

   (2) NUMA systems with *horrible* remote memory latencies

Both can be detected from you .config and we could see HZ as needed
there and everyone else could avoid this surely?

The above one year old comment where it says "someone complained"
makes me wonder if we ever had an original report with hard facts or
just some internal/private comment/bug about how things seem.

Surely we can test this accurately?

> "My expectation is if we want to beat the competition, we'll want
> the ability to go *under* 100Hz."

What does Windows do here?

> Len, any updates on the relationship between HZ and power
> consumption?

I can measure this[1] for some *old* hardware but as it has unusable
behavior for ACPI I'm not sure how useful that is.


[1] I was just going to remove batteries and run it from a bench
    supply in the lab and measure how much current was being drawn.
    Can anyone suggest something more sensible than that?

