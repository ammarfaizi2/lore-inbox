Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbUCaIOV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 03:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbUCaIOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 03:14:21 -0500
Received: from astound-64-85-224-245.ca.astound.net ([64.85.224.245]:20235
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S261822AbUCaIOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 03:14:19 -0500
Date: Wed, 31 Mar 2004 00:09:35 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Timothy Miller <miller@techsource.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Storage Architect Part 1: Re: [PATCH] speed up SATA (resend 3)
In-Reply-To: <406993D1.8040705@techsource.com>
Message-ID: <Pine.LNX.4.10.10403310003400.11654-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Tim,

I do not know where you have been hiding, but you get it!

NanoSecond timers to determine command respond for storage statics goes
far beyond the latency issues (imho are bogus).  Bogus meaning there are
no known (to me) means to profile kernel performance based on usage.

Desktop, Workstation, Appliance are not equal in needs.

Back to the "NanoSecond timers" one can also generate drive predictive
failure rates.  Determinations based on slip or oob sector access from an
unrecorded sector reallocation event.

At least someone out there is thinking and appears to own one of the few
and rare "Andre to Human" translators.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Tue, 30 Mar 2004, Timothy Miller wrote:

> Somehow I missed this discussion on the list, but I caught it on kerneltrap.
> 
> Anyhow, what I don't understand is why it would be so hard to have the 
> block layer measure latency and dynamically adjust for each device. 
> Start somewhat small, and when the block layer sees that a given device 
> can handle larger requests without blowing latency requirements, 
> increase the request size.  Keep a running average.
> 

