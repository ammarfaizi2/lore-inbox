Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbUKNC11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbUKNC11 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 21:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbUKNC11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 21:27:27 -0500
Received: from gate.crashing.org ([63.228.1.57]:25535 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261203AbUKNC1S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 21:27:18 -0500
Subject: Re: ppc: fix up pmac IDE driver for driver core changes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
In-Reply-To: <200411132203.iADM3Lwb004846@hera.kernel.org>
References: <200411132203.iADM3Lwb004846@hera.kernel.org>
Content-Type: text/plain
Date: Sun, 14 Nov 2004 13:26:27 +1100
Message-Id: <1100399187.20511.137.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-11-13 at 20:53 +0000, Linux Kernel Mailing List wrote:
> ChangeSet 1.2115, 2004/11/13 12:53:51-08:00, torvalds@ppc970.osdl.org
> 
> 	ppc: fix up pmac IDE driver for driver core changes
> 	
> 	device power state is in "dev.power.power_state" now, rather than
> 	in "dev.power_state".
> 

Hrm... Missed that core change, where does it come from ? doesn't quite
go in the direction we have been discussing on linux-pm lately, which
is rather to remove this power_state field entirely since it's mostly
meaningless at this point (or rather, it's semantics are confuse and the
userland interface to it is means pretty much nothing).

While having a power_state field here for internal use of the driver may
be "useful" (avoiding the need for drivers to maintain something
equivalent locally), it's pretty much impossible to have a generic
abstract power_state that has globally defined semantics, at least not
with our current scheme.

Ben.


