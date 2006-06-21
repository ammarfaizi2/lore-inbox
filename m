Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932724AbWFUXjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932724AbWFUXjv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 19:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbWFUXjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 19:39:51 -0400
Received: from omta03sl.mx.bigpond.com ([144.140.92.155]:32766 "EHLO
	omta03sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932724AbWFUXju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 19:39:50 -0400
Message-ID: <4499D8C4.5040304@bigpond.net.au>
Date: Thu, 22 Jun 2006 09:39:48 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm1 : two PF flags with the same value
References: <20060621034857.35cfe36f.akpm@osdl.org>
In-Reply-To: <20060621034857.35cfe36f.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Wed, 21 Jun 2006 23:39:48 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm1/

Doing my quick review of changes to bits of code that overlap where I 
wish to work I've noticed that PF_SPREAD_SLAB and PF_MUTEX_TESTER have 
the same value.

define PF_SPREAD_SLAB	0x02000000	/* Spread some slab caches over cpuset */
#define PF_MEMPOLICY	0x10000000	/* Non-default NUMA mempolicy */
#define PF_MUTEX_TESTER	0x02000000	/* Thread belongs to the rt mutex 
tester */

This will have interesting consequences in some circumstances, I imagine.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
