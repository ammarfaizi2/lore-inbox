Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264224AbTIIRLT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 13:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264259AbTIIRLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 13:11:19 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:16774 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264224AbTIIRLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 13:11:16 -0400
Subject: Re: Determining pci bus from irq
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adam Litke <agl@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1063123832.2037.40.camel@dyn318261bld.beaverton.ibm.com>
References: <1063123832.2037.40.camel@dyn318261bld.beaverton.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063127380.30397.69.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Tue, 09 Sep 2003 18:09:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-09-09 at 17:10, Adam Litke wrote:
> Is there a nice way to determine, given an irq number, the pci bus
> number that raised the interrupt?

In general the answer is you can't find out. PCI IRQ lines are shared.
You can certainly lock and walk the pci device list looking for matches
but you may get a lot of devices on different busses

