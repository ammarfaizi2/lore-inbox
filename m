Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261459AbVBHELn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbVBHELn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 23:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbVBHELn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 23:11:43 -0500
Received: from gate.crashing.org ([63.228.1.57]:33691 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261459AbVBHELl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 23:11:41 -0500
Subject: PCI Error reporting & recovery
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: seto.hidetoshi@jp.fujitsu.com
Cc: linux-pci@atrey.karlin.mff.cuni.cz,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 08 Feb 2005 15:11:05 +1100
Message-Id: <1107835865.7687.78.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Seto !

I was reading the list archives for the discussion back in September
about PCI error reporting. Has there been any further progress on this
since then ?

I'm looking into adapting something for the need of ppc64 as well
(which, btw, has 1 slot = 1 bridge on most cases, but not all of them :)
which uses quite different low level mecanisms. (Basically, we have to
go through the firmware to get to the errors).

Also, our bridges are automatically isolating slots that had any error
on them (including DMA) and we have the ability to recover, by
triggering a reset on a given segment and that sort of thing, for which
I would like to provide dirvers with an API to control as well.

Finally, I was thinking about some richer semantics for the error
themselves. For example, on DMA error, we can sometimes get good details
about the faulting address etc... which may be intersting for the driver
to log, for diagnostic purpose at least.

So I'd like to start from what you did back then and discuss possible
APIs for the above ideas / changes. What is the status of that stuff ?
did it evolve since then ?

Regards,
Ben.


