Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270610AbUJUBAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270610AbUJUBAI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 21:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270452AbUJUA5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 20:57:36 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:5440 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S270509AbUJTXnT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 19:43:19 -0400
Subject: Re: Fwd: [Bug 3592] New: pppd "IPCP: timeout sending
	Config-Requests"
From: Paul Fulghum <paulkf@microgate.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Linus Torvalds <torvalds@osdl.org>, Alan Cox <alan@redhat.com>
In-Reply-To: <1098309449.12411.57.camel@localhost.localdomain>
References: <20041019131240.A20243@flint.arm.linux.org.uk>
	 <1098195468.8467.7.camel@deimos.microgate.com>
	 <1098199942.2857.7.camel@deimos.microgate.com>
	 <1098309449.12411.57.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1098315760.6006.13.camel@at2.pipehead.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 20 Oct 2004 18:42:40 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-20 at 16:57, Alan Cox wrote:
> On Maw, 2004-10-19 at 16:32, Paul Fulghum wrote:
> > PPP line disciplines rely on the previous behavior
> > of calling ldisc->close on hangup as a method for
> > indicating hangup to the line discipline.
> > This is explicitly called out in the PPP ldisc comments.
> 
> I had no choice about that really with the current locking. It's on the
> list to do further work although I'd not realised some odder pppd
> configurations relied upon it until the bug report.

OK

I'm not sure I would characterize using DCD
for a serial connection indicator as odd.

> Once I've put out -ac1 to fix the other bugs I consider urgent (not tty)
> I'll see what I can do. Really it would nice if the ppp maintainer would
> look at this and also fix all the horrible things the code does wrongly
> if for example the first byte of a received buffer is an error marker -
> in general serial error processing is not robust in the ppp code it
> appears.

I'll look at what is needed to implement the
new ldisc->hangup() method for the PPP line disciplines.

-- 
Paul Fulghum
paulkf@microgate.com


