Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263058AbREaKCa>; Thu, 31 May 2001 06:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263060AbREaKCV>; Thu, 31 May 2001 06:02:21 -0400
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:27402 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S263058AbREaKCO>; Thu, 31 May 2001 06:02:14 -0400
From: mdaljeet@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: mingo@elte.hu
cc: linux-kernel@vger.kernel.org, Pete Wyckoff <pw@osc.edu>
Message-ID: <CA256A5D.0036C6B6.00@d73mta01.au.ibm.com>
Date: Thu, 31 May 2001 15:27:38 +0530
Subject: Re: pte_page
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am doing a DMA from a card to system memory. The system memory "physical
address" is '0x104000'. I am doing this on x86 with kernel version 2.4.2.
Can this address be the address of a user space buffer?

Regards,
Daljeet.


|--------+----------------------->
|        |          Ingo Molnar  |
|        |          <mingo@elte.h|
|        |          u>           |
|        |                       |
|        |          05/30/01     |
|        |          11:09 PM     |
|        |          Please       |
|        |          respond to   |
|        |          mingo        |
|        |                       |
|--------+----------------------->
  >--------------------------------------------------------|
  |                                                        |
  |       To:     Pete Wyckoff <pw@osc.edu>                |
  |       cc:     Daljeet Maini/India/IBM@IBMIN,           |
  |       linux-kernel@vger.kernel.org                     |
  |       Subject:     Re: pte_page                        |
  >--------------------------------------------------------|






On Wed, 30 May 2001, Pete Wyckoff wrote:

> > __pa(page_address(pte_page(pte))) is the address you want. [or
> > pte_val(*pte) & (PAGE_SIZE-1) on x86 but this is platform-dependent.]
>
> Does this work on x86 non-kmapped highmem user pages too?  (i.e. is
> page->virtual valid for every potential user page.)

you are right, the highmem-compatible solution is to use page-mem_map as
the physical page index.

     Ingo




