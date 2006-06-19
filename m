Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964941AbWFSWGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964941AbWFSWGb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 18:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964942AbWFSWGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 18:06:31 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:62182 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964941AbWFSWG3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 18:06:29 -0400
Subject: Re: Linux 2.6.17: IRQ handler mismatch in serial code?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mark Lord <lkml@rtr.ca>
Cc: Chris Rankin <rankincj@yahoo.com>, linux-kernel@vger.kernel.org,
       linux-serial@vger.kernel.org
In-Reply-To: <44971C95.7050700@rtr.ca>
References: <20060619180658.58945.qmail@web52908.mail.yahoo.com>
	 <20060619184706.GH3479@flint.arm.linux.org.uk>  <4496FEC2.8050903@rtr.ca>
	 <1150751212.2871.44.camel@localhost.localdomain>  <44971C95.7050700@rtr.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 19 Jun 2006 23:21:41 +0100
Message-Id: <1150755701.2871.49.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-06-19 am 17:52 -0400, ysgrifennodd Mark Lord:
> > This is not the case for ISA bus. Most ISA hardware is physically unable
> > to share and the drivers for such hardware intentionally grab the IRQ at
> > load time to avoid it being mis-reused.
> 
> Eh?  The vast majority of ISA bus devices have open-collector IRQ lines,

Not in my experience. In the network work at least very few are, they
all drive the chip lines all the time. Thats why Don Becker made sure
such drivers grab the lines at startup. Those which can share IRQ or
move IRQ grab at open

Alan

