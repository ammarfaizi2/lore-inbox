Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263328AbUCSAWH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 19:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263297AbUCRXyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 18:54:41 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:21905 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263308AbUCRXnY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 18:43:24 -0500
Date: Thu, 18 Mar 2004 15:43:17 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Jesse Barnes <jbarnes@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Introduce nodemask_t ADT [0/7]
Message-ID: <9860000.1079653397@flay>
In-Reply-To: <200403181537.10060.jbarnes@sgi.com>
References: <1079651064.8149.158.camel@arrakis> <200403181523.10670.jbarnes@sgi.com> <8090000.1079652747@flay> <200403181537.10060.jbarnes@sgi.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Thursday, March 18, 2004 15:37:10 -0800 Jesse Barnes <jbarnes@sgi.com> wrote:

> On Thursday 18 March 2004 3:32 pm, Martin J. Bligh wrote:
>> I think the closest answer we have is that it's a grouping of cpus and
>> memory, where either may be NULL. 
> 
> Yep, that seems to make the most sense, but then part of me wants to
> drop the term node and never use it again :)

Hey, *I* wasn't the one who started splitting their h/w into wierdo pieces ;-)
Anyway, it's a damned sight shorter than "cpumemset".
 
>> I/O isn't directly associated with a node, though it should fit into the 
>> topo infrastructure, to give distances from io buses to nodes (for which 
>> I think we currently use cpumasks, which is probably wrong in retrospect, 
>> but then life is tough and flawed ;-))
> 
> It's probably not too late to change this to
> pcibus_to_nodemask(pci_bus *), or pci_to_nodemask(pci_dev *), there
> aren't that many callers, are there (my grep is still running)?

It probably shouldn't have anything to do with PCI directly either,
so .... ;-) My former thought was that you might just want the most
local memory for DMAing into.

M.

