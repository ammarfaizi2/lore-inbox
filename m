Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264496AbTIIV07 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 17:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264492AbTIIV0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 17:26:54 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:51079 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264496AbTIIVYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 17:24:16 -0400
Subject: Re: Buggy PCI drivers - do not mark pci_device_id as discardable
	data
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030909220452.S4216@flint.arm.linux.org.uk>
References: <20030909204803.N4216@flint.arm.linux.org.uk>
	 <Pine.LNX.4.53.0309091559110.14426@montezuma.fsmlabs.com>
	 <20030909220452.S4216@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063142578.30981.22.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Tue, 09 Sep 2003 22:22:59 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-09-09 at 22:04, Russell King wrote:
> I want this to be foolproof, because its me people bug when their cardbus
> cards oops when they insert the damned things.  If people are happy to
> ignore this issue, I'm happy to ignore the bug reports.
> 
> It basically isn't something I want to deal with, and we need to find a
> way to stop these stupidities appearing in the first place.
> 
> Any ideas?

You've already got symbols for initdata start and end, just check the 
pointers in the pci_register code. I guess you want a per platform

BUG_IF_INIT(x)


