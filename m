Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261335AbVCOPn1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbVCOPn1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 10:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbVCOPn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 10:43:27 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:12233 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261335AbVCOPnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 10:43:12 -0500
X-Comment: AT&T Maillennium special handling code - c
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v. A3)
From: Albert Cahalan <albert@users.sf.net>
To: Christoph Lameter <clameter@sgi.com>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       Matt Mackall <mpm@selenic.com>, john stultz <johnstul@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>, Max Asbock <masbock@us.ibm.com>,
       mahuja@us.ibm.com, Nishanth Aravamudan <nacc@us.ibm.com>,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com
In-Reply-To: <Pine.LNX.4.58.0503141920460.16054@schroedinger.engr.sgi.com>
References: <1110590655.30498.327.camel@cog.beaverton.ibm.com>
	 <20050313004902.GD3163@waste.org>
	 <1110825765.30498.370.camel@cog.beaverton.ibm.com>
	 <20050314192918.GC32638@waste.org>
	 <1110829401.30498.383.camel@cog.beaverton.ibm.com>
	 <20050314195110.GD32638@waste.org>
	 <1110830647.30498.388.camel@cog.beaverton.ibm.com>
	 <20050314202702.GF32638@waste.org> <1110852973.1967.180.camel@cube>
	 <Pine.LNX.4.58.0503141920460.16054@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Tue, 15 Mar 2005 10:23:54 -0500
Message-Id: <1110900235.7893.207.camel@cube>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-14 at 19:22 -0800, Christoph Lameter wrote:
> On Mon, 14 Mar 2005, Albert Cahalan wrote:
> 
> > When the vsyscall page is created, copy the one needed function
> > into it. The kernel is already self-modifying in many places; this
> > is nothing new.
> 
> AFAIK this will only works on ia32 and x86_64 and not definitely not
> on ia64. Who knows about the other platforms ....

I'll bet it does work fine on IA-64. If it didn't, you would
be unable to load the kernel or load an executable.

I know it works for PowerPC. You'll need an isync instruction
of course. You may also want a sync instruction and some code
to invalidate the cache.

Setting up the page content should be a 1-time operation done
at boot. Check your processor manuals as needed.


