Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964876AbWCHBLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876AbWCHBLr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 20:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964872AbWCHBLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 20:11:47 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:24420 "EHLO
	pd2mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S964873AbWCHBLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 20:11:46 -0500
Date: Tue, 07 Mar 2006 19:10:00 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH] Document Linux's memory barriers
In-reply-to: <5NUSF-30Z-5@gated-at.bofh.it>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <440E2EE8.10708@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <5NONi-2hp-3@gated-at.bofh.it> <5NQ2U-462-29@gated-at.bofh.it>
 <5NRLg-6LJ-31@gated-at.bofh.it> <5NRUR-6Yo-11@gated-at.bofh.it>
 <5NUSF-30Z-5@gated-at.bofh.it>
User-Agent: Thunderbird 1.5 (Windows/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Maw, 2006-03-07 at 22:24 +0100, Andi Kleen wrote:
>>> But on most arches those accesses do indeed seem to happen in-order.  On
>>> i386 and x86_64, it's a natural consequence of program store ordering.
>> Not true for reads on x86.
> 
> You must have a strange kernel Andi. Mine marks them as volatile
> unsigned char * references.

Well, that and the fact that IO memory should be mapped as uncacheable 
in the MTRRs should ensure that readl and writel won't be reordered on 
i386 and x86_64.. except in the case where CONFIG_UNORDERED_IO is 
enabled on x86_64 which can reorder writes since it uses nontemporal 
stores..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

