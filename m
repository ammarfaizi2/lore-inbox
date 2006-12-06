Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760263AbWLFGgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760263AbWLFGgX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 01:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760262AbWLFGgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 01:36:23 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:44781 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760257AbWLFGgW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 01:36:22 -0500
Subject: Re: [PATCH] CPEI gets warning at
	kernel/irq/migration.c:27/move_masked_irq()
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, linux-ia64@vger.kernel.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20061205221913.1ef416f9.akpm@osdl.org>
References: <4575212A.3020902@jp.fujitsu.com>
	 <20061205221913.1ef416f9.akpm@osdl.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 06 Dec 2006 07:36:15 +0100
Message-Id: <1165386976.3233.428.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It'd be nice if we could just teach the userspace balancer to not try to
> move perpcu IRQs?
> 
> otoh, the patch is super-cheap.   Arjan?

I can fix irqbalance no problem, however I like the kernel approach as
well, since it's not just irqbalance that moves irqs, sysadmins tend to
do it as well....  so how about both?

One thing we probably should do, and that would help irqbalance
immensely, is to export a bitmask for which cpus an interrupt CAN go to,
next to where the current binding interface is. I'll check into that

Hidetoshi: would it be possible to send me a /proc/interrupts file of
that machine?


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

