Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268594AbUIGVAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268594AbUIGVAI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 17:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268270AbUIGVAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 17:00:08 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:46498 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268609AbUIGU7y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 16:59:54 -0400
Date: Tue, 7 Sep 2004 13:55:53 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: George Anzinger <george@mvista.com>
cc: Andi Kleen <ak@suse.de>, john stultz <johnstul@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       albert@users.sourceforge.net, Ulrich.Windl@rz.uni-regensburg.de,
       Len Brown <len.brown@intel.com>, linux@dominikbrodowski.de,
       David Mosberger <davidm@hpl.hp.com>, paulus@samba.org,
       schwidefsky@de.ibm.com, jimix@us.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, greg kh <greg@kroah.com>,
       Patricia Gaughen <gone@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>
Subject: Re: [RFC] New Time of day proposal (updated 9/2/04)
In-Reply-To: <413DFCC2.7080405@mvista.com>
Message-ID: <Pine.LNX.4.58.0409071354150.9990@schroedinger.engr.sgi.com>
References: <1094159238.14662.318.camel@cog.beaverton.ibm.com>
 <20040903151710.GB12956@wotan.suse.de> <1094242317.14662.556.camel@cog.beaverton.ibm.com>
 <20040904130022.GB21912@wotan.suse.de> <Pine.LNX.4.58.0409070908290.8484@schroedinger.engr.sgi.com>
 <413DFCC2.7080405@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Sep 2004, George Anzinger wrote:

> Also, we don't "know" what rate the TSC is actully clocking so we must
> "discover" it at boot time.  This process either is inaccurate or slow (I think
> we use ~ 50 ms these days which gives an error of ~10 TSC cycles on a 800MHZ
> box).  FWIW the problem here is the sync up with the I/O backplane to find the
> start and ending of the measured time.
>
> I suspect that the IA64 "tells" you what its clock rate is.  Right?

Not the CPU itself. There is a special hardware I/O interface called the
PAL/SAL that allows one to retrive that information. Doesnt the BIOS on
i386 allow you to get to that information?

