Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269164AbUJTXKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269164AbUJTXKE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 19:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269152AbUJTXFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 19:05:51 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:44251 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S270527AbUJTXAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 19:00:42 -0400
Subject: Re: Fwd: [Bug 3592] New: pppd "IPCP: timeout sending
	Config-Requests"
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Linus Torvalds <torvalds@osdl.org>, Alan Cox <alan@redhat.com>
In-Reply-To: <1098199942.2857.7.camel@deimos.microgate.com>
References: <20041019131240.A20243@flint.arm.linux.org.uk>
	 <1098195468.8467.7.camel@deimos.microgate.com>
	 <1098199942.2857.7.camel@deimos.microgate.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1098309449.12411.57.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 20 Oct 2004 22:57:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-10-19 at 16:32, Paul Fulghum wrote:
> PPP line disciplines rely on the previous behavior
> of calling ldisc->close on hangup as a method for
> indicating hangup to the line discipline.
> This is explicitly called out in the PPP ldisc comments.

I had no choice about that really with the current locking. It's on the
list to do further work although I'd not realised some odder pppd
configurations relied upon it until the bug report.

Once I've put out -ac1 to fix the other bugs I consider urgent (not tty)
I'll see what I can do. Really it would nice if the ppp maintainer would
look at this and also fix all the horrible things the code does wrongly
if for example the first byte of a received buffer is an error marker -
in general serial error processing is not robust in the ppp code it
appears.

Alan

