Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750909AbWIOQ6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbWIOQ6W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 12:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbWIOQ6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 12:58:22 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:32231 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750910AbWIOQ6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 12:58:21 -0400
Date: Fri, 15 Sep 2006 11:58:10 -0500
From: Dimitri Sivanich <sivanich@sgi.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Migration of standard timers
Message-ID: <20060915165810.GA3832@sgi.com>
References: <20060914132917.GA9898@sgi.com> <1158338360.5724.442.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158338360.5724.442.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2006 at 06:39:19PM +0200, Thomas Gleixner wrote:
> Are you trying to work around the latencies caused by long running timer
> callbacks ? I'm not convinced that this is not curing the symptoms
> instead of the root cause.

Yes, both latency from long running timer callbacks as well as
potential latency from a temporal grouping of timer callbacks
(those occuring on the same tick).

While I agree that root causes of the former should be addressed,
more latencies of this type can always easily creep in.  Timer
migration works as a long term preventative aid, not just a fix
for the problem of the moment.  And adding this needn't restrict
anyone from looking at the aforementioned root causes.
