Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261757AbVAYAN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbVAYAN7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 19:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261742AbVAYAL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 19:11:28 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:50382 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261748AbVAYAKV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 19:10:21 -0500
Date: Mon, 24 Jan 2005 16:08:02 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>, Max Asbock <amax@us.ibm.com>,
       mahuja@us.ibm.com, Nishanth Aravamudan <nacc@us.ibm.com>,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v. A2)
In-Reply-To: <1106611416.30884.22.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.58.0501241606240.17986@schroedinger.engr.sgi.com>
References: <1106607089.30884.10.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.58.0501241513470.17986@schroedinger.engr.sgi.com>
 <1106611416.30884.22.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2005, john stultz wrote:

> Yep, performance is a big concern. Re-working ntp_scale() is still on my
> TODO list. I just didn't get to it in this release.

This is a hopeless endeavor if you look at the function.
Throw ntp_scale out and calculate a scaling factor during the ticks. At
tick time then you may forward the clock a few ns in order to correct it
otherwise monkey around with the scaling factor.

