Return-Path: <linux-kernel-owner+w=401wt.eu-S1030437AbXAHBqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030437AbXAHBqQ (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 20:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030431AbXAHBqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 20:46:16 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:51497 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030430AbXAHBqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 20:46:15 -0500
Message-ID: <45A1A265.20504@garzik.org>
Date: Sun, 07 Jan 2007 20:46:13 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@it.uu.se>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH libata #promise-sata-pata] sata_promise: unbreak 20619
References: <200701062031.l06KV64q022234@harpo.it.uu.se>
In-Reply-To: <200701062031.l06KV64q022234@harpo.it.uu.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> The PATA support patch for sata_promise appears, from
> code inspection, to break the PATA-only 20619 chip.
> 
> The patch removes the SATA flag from the TX2plus SATA+PATA
> boards' common flags, with the intention of adding it back
> via the _port_flags[] entries for those boards' SATA ports.
> 
> However, it unconditionally marks ports 0 and 1 as SATA
> for all boards. This causes the 20619 (TX4000) to announce
> its first two PATA ports as SATA | ATA_FLAG_SLAVE_POSS.
> 
> I don't have a TX4000 so I don't know what the actual
> consequences of this bug are, but surely this isn't Ok.
> 
> Fixed by moving the port 0 and 1 settings as SATA into
> the TX4 and TX2plus specific initialisation code.
> 
> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

Given that I agree with your RFC, this means I can drop all these 
#promise-sata-pata patches, and kill the #promise-sata-pata branch soon, 
right?

	Jeff



