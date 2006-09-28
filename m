Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161095AbWI1Ljr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161095AbWI1Ljr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 07:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161096AbWI1Ljr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 07:39:47 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:24219 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1161095AbWI1Ljq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 07:39:46 -0400
Message-ID: <451BB45C.2050609@t-online.de>
Date: Thu, 28 Sep 2006 13:39:08 +0200
From: Bernd Schmidt <bernds_cb1@t-online.de>
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: Robin Getz <rgetz@blackfin.uclinux.org>, luke Yang <luke.adi@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] Blackfin: arch patch for 2.6.18
References: <6.1.1.1.0.20060927121508.01ecea90@ptg1.spd.analog.com> <200609272257.02385.arnd@arndb.de> <451B9675.8070406@t-online.de> <200609281304.31872.arnd@arndb.de>
In-Reply-To: <200609281304.31872.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: r4+srOZZQe5ZqTBFW-PbpqcUCnH9Aq1JWJedAeXjRrVbhp+Rq3Zv6P
X-TOI-MSGID: e2e42527-bfc7-4332-b4f5-42ad4257691a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
>> We want to restore the proper  
>> mask of enabled interrupts with the STI.  That mask is in the global 
>> irq_flags variable (which probably ought to have a different name that 
>> doesn't invite clashes).
> 
> Shouldn't you just use a constant expression here? A global variable
> for it sounds rather strange, especially since the local_irq_disable()
> calls are sometimes nested, not to mention the problems you'd hit on
> SMP?

It's not a constant - there are some {un,}mask_irq functions that may 
change it.  We don't have SMP, obviously it would have to be per-CPU if 
we did.


Bernd
