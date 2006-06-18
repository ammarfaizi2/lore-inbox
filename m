Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbWFRMSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWFRMSx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 08:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbWFRMSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 08:18:52 -0400
Received: from liaag2ae.mx.compuserve.com ([149.174.40.156]:16071 "EHLO
	liaag2ae.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932200AbWFRMSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 08:18:52 -0400
Date: Sun, 18 Jun 2006 08:13:01 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch 2.6.16-rc6-mm2] x86: add NUMA to oops messages
To: Andi Kleen <ak@suse.de>
Cc: Arjan van de Ven <arjan@linux.intel.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200606180815_MC3-1-C2CC-41A5@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <200606181059.44576.ak@suse.de>

On Sun, 18 Jun 2006 10:59:44 +0200, Andi Kleen wrote:

> On Sunday 18 June 2006 10:13, Chuck Ebbert wrote:
> > Add "NUMA" to x86 oops printouts to help with debugging.  Use vermagic.h
> > defines to clean up the code, suggested by Arjan van de Ven.
> 
> I don't see any particular value in printing NUMA here,

It helps a lot when trying to decode oopses posted to the list, as the
NUMA kernel is very different now that the slab allocator and scheduler
are NUMA-aware.

 $ fgrep 'def CONFIG_NUMA' mm/*.c kernel/*.c include/linux/* | wc -l
 58
 $ fgrep 'def CONFIG_SMP' mm/*.c kernel/*.c include/linux/* | wc -l
 81

> and putting half of .config into the oops doesn't seem
> like a good long term strategy.

It's just this one thing; I can't think of anything else to add...

-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
