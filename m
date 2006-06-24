Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933380AbWFXKVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933380AbWFXKVM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 06:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933381AbWFXKVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 06:21:12 -0400
Received: from liaag2aa.mx.compuserve.com ([149.174.40.154]:50650 "EHLO
	liaag2aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S933380AbWFXKVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 06:21:11 -0400
Date: Sat, 24 Jun 2006 06:18:33 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.6.11: spinlock problem
To: Darren Reed <darrenr@reed.wattle.id.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200606240620_MC3-1-C357-8BEB@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <200606240247.k5O2lU3C009083@firewall.reed.wattle.id.au>

On Sat, 24 Jun 2006 12:47:30 +1000, Darren Reed wrote:

> The call stack for the panic is:
> panic
> ipf_read_enter
> ..
> do_softirq
> =====
> do_IRQ
> common_interrupt
> ipf_rw_exit

If you are using spinlocks fron interrupt context you need to use
spin_lock_irq/spin_lock_irqsave / spin_unlock_irq/spin_unlock_irqrestore.

-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
