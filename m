Return-Path: <linux-kernel-owner+w=401wt.eu-S1751264AbXAIKMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbXAIKMu (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 05:12:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbXAIKMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 05:12:50 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:33306 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751253AbXAIKMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 05:12:49 -0500
Message-ID: <45A36A9E.8030408@garzik.org>
Date: Tue, 09 Jan 2007 05:12:46 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@it.uu.se>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc4 1/2] sata_promise: TX2plus PATA support
References: <200701090950.l099oRPU011573@harpo.it.uu.se>
In-Reply-To: <200701090950.l099oRPU011573@harpo.it.uu.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> This patch implements a simple way of setting up per-port
> flags on the SATA+PATA Promise TX2plus chips, which is a
> prerequisite for supporting the PATA port on those chips.
> 
> It is based on the observation that ap->flags isn't really
> used until after ->port_start() has been invoked. So it
> places the "exceptional" per-port flags array in the driver's
> private host structure, and uses it in ->port_start() to
> finalise the port's flags.
> 
> This patch obsoletes the #promise-sata-pata branch included
> in the #all branch.
> 
> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

applied patches 1-2 to #upstream.  minor follow-up comments follow in 
separate emails.

Thanks a bunch for working on this, sata_promise has needed some "love" 
for quite a while.

Any chance you could be talked to becoming "official" sata_promise 
maintainer, by sending in a patch to MAINTAINERS?

One open issue that remains is port enumeration order.  Bug reports 
consistently indicate that the ports are numbered on the board (visible 
to the naked eye) in a different manner than how the chip enumerates 
each port.  According to the bug reports, Promise's driver enumerates 
the ports in the correct order.

	Jeff



