Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbWF3KqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbWF3KqX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 06:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbWF3KqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 06:46:23 -0400
Received: from mailhost.tue.nl ([131.155.3.8]:50888 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S932435AbWF3KqW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 06:46:22 -0400
Message-ID: <44A500FD.9020905@etpmod.phys.tue.nl>
Date: Fri, 30 Jun 2006 12:46:21 +0200
From: Bart Hartgers <bart@etpmod.phys.tue.nl>
User-Agent: Thunderbird 1.5.0.4 (X11/20060527)
MIME-Version: 1.0
To: =?ISO-8859-2?Q?Rafa=B3_Bilski?= <rafalbilski@interia.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (Longhaul 1/5) PCI: Protect bus master DMA from	Longhaul
 by rw semaphores
References: <44A2C9A7.6060703@interia.pl> <1151581077.23785.9.camel@localhost.localdomain> <44A3C17F.3060204@etpmod.phys.tue.nl> <44A3DFDB.7050202@interia.pl> <44A3EB45.1000507@etpmod.phys.tue.nl> <44A3F476.5010400@interia.pl>
In-Reply-To: <44A3F476.5010400@interia.pl>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafa³ Bilski wrote:
> I'm using this for L2 cache:
> 	preempt_disable();
> 	local_irq_save(flags);
> 	rdmsr(MSR_VIA_FCR, lo, hi);
> 	flush_cache_all();
> 	wrmsr(MSR_VIA_FCR, lo | 1 << 8, hi);
> and this doesn't stop the processor, but when I'm adding
> 1 << 13 or 1 << 14 CPU stops. I have tried
> 	flush_cache_all();
> 	wrmsr(MSR_VIA_FCR, lo | 1 << 8, hi);
> 	flush_cache_all();
> 	wrmsr(MSR_VIA_FCR, lo | 1 << 8 | 1 << 13, hi);
> and
> 	flush_cache_all();
> 	wrmsr(MSR_VIA_FCR, lo | 1 << 8 | 1 << 13, hi);
> and more, but result was always the same.
> 
> I will be very gratefull if You tell me what I'm doing wrong.
> 
> Rafa³

Sorry, I have no idea. The code looks fine.


-- 
Bart Hartgers - TUE Eindhoven - http://plasimo.phys.tue.nl/bart/contact/
