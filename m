Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261565AbVASFaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261565AbVASFaA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 00:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbVASFaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 00:30:00 -0500
Received: from gate.crashing.org ([63.228.1.57]:25570 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261565AbVASF35 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 00:29:57 -0500
Subject: Re: [PATCH] dynamic tick patch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tony Lindgren <tony@atomide.com>
Cc: Pavel Machek <pavel@ucw.cz>, George Anzinger <george@mvista.com>,
       john stultz <johnstul@us.ibm.com>, Andrea Arcangeli <andrea@suse.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050119050701.GA19542@atomide.com>
References: <20050119000556.GB14749@atomide.com>
	 <1106108467.4500.169.camel@gaston>  <20050119050701.GA19542@atomide.com>
Content-Type: text/plain
Date: Wed, 19 Jan 2005 16:28:45 +1100
Message-Id: <1106112525.4534.175.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hrm... reading more of the patch & Martin's previous work, I'm not sure
I like the idea too much in the end... The main problem is that you are
just "replaying" the ticks afterward, which I see as a problem for
things like sched_clock() which returns the real current time, no ?

I'll toy a bit with my own implementation directly using Martin's work
and see what kind of improvement I really get on ppc laptops.

Ben.


