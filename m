Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751064AbWH1QTg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbWH1QTg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 12:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbWH1QTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 12:19:35 -0400
Received: from mga06.intel.com ([134.134.136.21]:44709 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751064AbWH1QTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 12:19:35 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,176,1154934000"; 
   d="scan'208"; a="116218585:sNHT31248035"
Message-ID: <44F3178F.8010508@linux.intel.com>
Date: Mon, 28 Aug 2006 18:19:27 +0200
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu,
       jesse.barnes@intel.com, dwalker@mvista.com
Subject: Re: [PATCH] maximum latency tracking infrastructure (version 3)
References: <1156780080.3034.207.camel@laptopd505.fenrus.org> <20060828161145.GA25161@rhlx01.fht-esslingen.de>
In-Reply-To: <20060828161145.GA25161@rhlx01.fht-esslingen.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Mohr wrote:
> Hi,
> 
> On Mon, Aug 28, 2006 at 05:48:00PM +0200, Arjan van de Ven wrote:
>> The proposed solution is to have an interface where drivers can
>> * announce the maximum latency (in microseconds) that they can deal with
>> * modify this latency
>> * give up their constraint
>> and a function where the code that decides on power saving strategy can query
>> the current global desired maximum.
> 
> Nifty (aka "dumb") idea: would it make sense to enable drivers to register a
> callback "we're going to go idle now" to e.g. let a driver refill or
> service its hardware buffers the very moment before idling? 

I could have sworn there was an idle call notifier already\

ah there is on x86-64 but it is architecture specific...
