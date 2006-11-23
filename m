Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933585AbWKWLBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933585AbWKWLBW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 06:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933590AbWKWLBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 06:01:22 -0500
Received: from gate.crashing.org ([63.228.1.57]:16824 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S933585AbWKWLBV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 06:01:21 -0500
Subject: Re: NTP time sync
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andi Kleen <ak@muc.de>
Cc: Alessandro Zummo <alessandro.zummo@towertech.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org,
       Kumar Gala <galak@kernel.crashing.org>,
       Kim Phillips <kim.phillips@freescale.com>, akpm@osdl.org,
       davem@davemloft.net, kkojima@rr.iij4u.or.jp, lethal@linux-sh.org,
       paulus@samba.org, ralf@linux-mips.org, rmk@arm.linux.org.uk
In-Reply-To: <20061123105400.GA75714@muc.de>
References: <20061122203633.611acaa8@inspiron>
	 <20061123105400.GA75714@muc.de>
Content-Type: text/plain
Date: Thu, 23 Nov 2006 22:00:05 +1100
Message-Id: <1164279605.5653.51.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-23 at 11:54 +0100, Andi Kleen wrote:
> > [1] http://lkml.org/lkml/2006/3/28/358
> 
> What was the answer to Matt's last question in there?
> If the existing user land does it already then 
> probably.  If not then a good migration strategy would 
> be needed.

Couldn't we have a transition period by making the kernel not rely on
interrupts ? if the NTP irq code just triggers a work queue, then all of
a sudden, all of the RTC drivers can be used and the latency is small.
That might well be a good enough solution and is very simple.

Ben


