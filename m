Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264733AbTFAVYi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 17:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264734AbTFAVYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 17:24:37 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:60678 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP id S264733AbTFAVYh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 17:24:37 -0400
Date: Sun, 01 Jun 2003 15:37:47 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
cc: Willy Tarreau <willy@w.ods.org>,
       Daniel Podlejski <underley@underley.eu.org>,
       linux-kernel@vger.kernel.org
Subject: Re: AIC7xxx problem
Message-ID: <2878250000.1054503467@aslan.scsiguy.com>
In-Reply-To: <Pine.LNX.4.50.0306011647431.19313-100000@montezuma.mastecende.com>
References: <20030531165945.GA5561@witch.underley.eu.org> <20030601083656.GI21673@alpha.home.local>
 <2859720000.1054499680@aslan.scsiguy.com> <Pine.LNX.4.50.0306011647431.19313-100000@montezuma.mastecende.com>
X-Mailer: Mulberry/3.0.3 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> My driver can't fix interrupt routing issues which is what Daniel's
>> problem turned out to be.  I'm really tempted to add an interrupt
>> test to the driver attach so that these kinds of problems are clearly
>> flagged and my driver doesn't continue to get blamed for interrupt
>> routing it can't control.
> 
> Which aspect of interrupt routing is broken so that we at least can have a 
> go at fixing it? I might be missing something here but it looks fine, 
> could you elaborate?

Daniel is comparing 2.4.20-ac2 with 2.4.21-rc6.  In 2.4.20-ac2, APIC
routing is disabled by default and his kernel works.  In 2.4.21-rc6,
APIC routing is enabled by default and interrupts are not properly
routed to his SCSI controller.  If he boots with noapic, everything
works fine.  You'll have to ask Daniel for more details on his system
if you want to figure out why interrupts are not being delivered.
All I know is, from the output and his testing, it is pretty obvious
that interrupts are not being delivered.

--
Justin

