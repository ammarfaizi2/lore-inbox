Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263672AbUDMSbv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 14:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263662AbUDMSbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 14:31:51 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32963 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263673AbUDMSbe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 14:31:34 -0400
Message-ID: <407C31F4.9070800@pobox.com>
Date: Tue, 13 Apr 2004 14:31:16 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Egger <degger@fhm.edu>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Netdev <netdev@oss.sgi.com>
Subject: Re: [NET] net driver updates
References: <4072CD01.6070408@pobox.com> <FE87A41F-8809-11D8-8F2A-000A9597297C@fhm.edu>
In-Reply-To: <FE87A41F-8809-11D8-8F2A-000A9597297C@fhm.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Egger wrote:
> On 06.04.2004, at 17:30, Jeff Garzik wrote:
> 
>> * Francois work on r8169, epic100, sis190: PCI DMA, NAPI, other minor 
>> fixes and cleanups
> 
> 
> r8169 seems to work though it is not even a tad bit faster
> than plain 2.6.5.

Francois is still trying to fix all the vendor-created bugs, so 
performance is a secondary consideration.

RTL8169 is a nice chipset, though.  Robert Ollsson had some nice pktgen 
numbers for it, IIRC.


> Those cards are really driving me nuts. Between two r8169 cards, one
> on Athlon with kernel 2.4.24, one on Athlon with 2.6.5 or 2.4.24, I
> get 90Mbit/s in one direction and 39Mbit/s in the other using iperf and
> TCP. With iperf and UDP they deliver 100Mbit/s resp. 230Mbit/s depending
> on the direction. Crosschecking with my PowerBook (OS X) shows that I can
> get 844Mbit/s (UDP) or 572Mbit/s (TCP) to one host and 844Mbit/s (UDP) but
> only 88Mbit/s (TCP) to the other.
> 
> The environment is switched and changing cables and/or ports doesn't
> improve the results.
> 
> Ideas? (Yeah, I'll get Intel NICs RSN...)

Yeah -- I plan to kill r8169, and use 8139cp.c to drive it instead :)

	Jeff



