Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbVKJMIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbVKJMIq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 07:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbVKJMIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 07:08:46 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:48267 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750801AbVKJMIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 07:08:45 -0500
Subject: Re: [PATCH] b44: s/spin_lock_irqsave/spin_lock/ in b44_interrupt
From: Arjan van de Ven <arjan@infradead.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200511091802.jA9I2aTE003303@hera.kernel.org>
References: <200511091802.jA9I2aTE003303@hera.kernel.org>
Content-Type: text/plain
Date: Thu, 10 Nov 2005 13:08:37 +0100
Message-Id: <1131624518.2799.16.camel@laptopd505.fenrus.org>
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

On Wed, 2005-11-09 at 10:02 -0800, Linux Kernel Mailing List wrote:
> tree ece6ca6ed3844220c92e4b1207542864f70bad39
> parent 3353930d9d026ca94747d0766f864b2a0a8c714b
> author Francois Romieu <romieu@fr.zoreil.com> Mon, 07 Nov 2005 01:52:06 +0100
> committer Jeff Garzik <jgarzik@pobox.com> Mon, 07 Nov 2005 13:37:05 -0500
> 
> [PATCH] b44: s/spin_lock_irqsave/spin_lock/ in b44_interrupt
> 
> There is no need to save/restore the irq state as the irq are always
> locally disabled when b44_interrupt is issued.


I don't actually buy this reasoning... what makes you so sure that this
is the case?



