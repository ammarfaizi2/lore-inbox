Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbVCQU3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVCQU3f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 15:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbVCQU3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 15:29:34 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:35080 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261151AbVCQU3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 15:29:23 -0500
Date: Thu, 17 Mar 2005 20:28:49 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Albert Cahalan <albert@users.sf.net>
Cc: Christoph Lameter <clameter@sgi.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
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
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v. A3)
Message-ID: <20050317202848.A15653@flint.arm.linux.org.uk>
Mail-Followup-To: Albert Cahalan <albert@users.sf.net>,
	Christoph Lameter <clameter@sgi.com>,
	Albert Cahalan <albert@users.sourceforge.net>,
	Matt Mackall <mpm@selenic.com>, john stultz <johnstul@us.ibm.com>,
	lkml <linux-kernel@vger.kernel.org>,
	Tim Schmielau <tim@physik3.uni-rostock.de>,
	George Anzinger <george@mvista.com>,
	Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
	Dominik Brodowski <linux@dominikbrodowski.de>,
	David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
	paulus@samba.org, schwidefsky@de.ibm.com,
	keith maanthey <kmannth@us.ibm.com>,
	Patricia Gaughen <gone@us.ibm.com>,
	Chris McDermott <lcm@us.ibm.com>, Max Asbock <masbock@us.ibm.com>,
	mahuja@us.ibm.com, Nishanth Aravamudan <nacc@us.ibm.com>,
	Darren Hart <darren@dvhart.com>,
	"Darrick J. Wong" <djwong@us.ibm.com>,
	Anton Blanchard <anton@samba.org>, donf@us.ibm.com
References: <20050314192918.GC32638@waste.org> <1110829401.30498.383.camel@cog.beaverton.ibm.com> <20050314195110.GD32638@waste.org> <1110830647.30498.388.camel@cog.beaverton.ibm.com> <20050314202702.GF32638@waste.org> <1110852973.1967.180.camel@cube> <Pine.LNX.4.58.0503141920460.16054@schroedinger.engr.sgi.com> <1110900235.7893.207.camel@cube> <20050317165534.B12344@flint.arm.linux.org.uk> <1111088697.1930.6.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1111088697.1930.6.camel@cube>; from albert@users.sf.net on Thu, Mar 17, 2005 at 02:44:57PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2005 at 02:44:57PM -0500, Albert Cahalan wrote:
> Does the ARM kernel provide a special page of code for
> apps to execute? If not, then ARM is irrelevant.

No.  However, I was responding to your suggestion that supporting
self modifying code in the kernel is trivial.

> Doesn't ARM always have an MMU? If you have an MMU, then
> it is no problem to have one single page of non-XIP code
> for this purpose.

No.  You also have a big misconception about how we map system memory.
We have 1MB mappings, and replacing 1MB of code/data (which would
equate to half a kernel) would completely negate the whole point of
XIP.

> Supposing that you do support the vsyscall hack and you don't
> have an MMU, you can just place the tiny code fragment on the
> stack (or anywhere else) when an exec is performed.
> 
> So, as far as I can see, ARM is fully capable of supporting this.

<cough>

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
