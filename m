Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbVLHOtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbVLHOtP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 09:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbVLHOtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 09:49:15 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:19093 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932088AbVLHOtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 09:49:14 -0500
Subject: Re: How to enable/disable security features on mmap() ?
From: Arjan van de Ven <arjan@infradead.org>
To: Emmanuel Fleury <emmanuel.fleury@labri.fr>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <43984595.1090406@labri.fr>
References: <43983EBE.2080604@labri.fr>
	 <1134051272.2867.63.camel@laptopd505.fenrus.org>
	 <43984154.5050502@labri.fr>  <43984595.1090406@labri.fr>
Content-Type: text/plain
Date: Thu, 08 Dec 2005 15:49:09 +0100
Message-Id: <1134053349.2867.65.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-08 at 15:39 +0100, Emmanuel Fleury wrote:
> I guess that setting the variable randomize_va_space to 0 just remove
> the stack pointer (sp) randomization.
> 
> Seen in arch/i386/kernel/process.c:
> 
> unsigned long arch_align_stack(unsigned long sp)
> {
>         if (randomize_va_space)
>                 sp -= get_random_int() % 8192;
>         return sp & ~0xf;
> }
> 
> Why not having defined this as a CONFIG_STACK_RANDOMIZATION variables

well it's a /proc/ variable already! So you can just turn it off
entirely at runtime. (what is better is that you use the setarch program
to turn it off for selected programs though...)


