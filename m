Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263080AbUCSQVG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 11:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263105AbUCSQVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 11:21:05 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:43669 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S263080AbUCSQUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 11:20:54 -0500
Date: Fri, 19 Mar 2004 08:20:52 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Jesse Barnes <jbarnes@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Introduce nodemask_t ADT [0/7]
Message-ID: <2648260000.1079713251@[10.10.2.4]>
In-Reply-To: <200403181559.42332.jbarnes@sgi.com>
References: <1079651064.8149.158.camel@arrakis> <200403181537.10060.jbarnes@sgi.com> <9860000.1079653397@flay> <200403181559.42332.jbarnes@sgi.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Jesse Barnes <jbarnes@sgi.com> wrote (on Thursday, March 18, 2004 15:59:42 -0800):

> On Thursday 18 March 2004 3:43 pm, Martin J. Bligh wrote:
>> > It's probably not too late to change this to
>> > pcibus_to_nodemask(pci_bus *), or pci_to_nodemask(pci_dev *), there
>> > aren't that many callers, are there (my grep is still running)?
>> 
>> It probably shouldn't have anything to do with PCI directly either,
>> so .... ;-) My former thought was that you might just want the most
>> local memory for DMAing into.
> 
> Right, we want local memory (or potentially remote memory) for DMA,
> but what about interrupt redirection?  Some chipsets don't support
> interrupt round robin, and just target interrupts at one CPU.  In that
> case (and probably the round robin case too), you want to know which
> CPU(s) to send the interrupt at.  Can't immediately think of other
> in-kernel uses though (administrators will of course want to be able
> to locate a given PCI device in a multirack system, but that's another
> subject--one that Martin Hicks posted on yesterday).

I think we need both ... maybe a cpumask and a zonelist as the destination
types.

M.

