Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266115AbUFUGRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266115AbUFUGRI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 02:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266117AbUFUGRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 02:17:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:59778 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266115AbUFUGRF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 02:17:05 -0400
Date: Sun, 20 Jun 2004 23:16:58 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.6.7-bk way too fast
In-Reply-To: <200406210239.28918.norberto+linux-kernel@bensa.ath.cx>
Message-ID: <Pine.LNX.4.58.0406202313510.11274@ppc970.osdl.org>
References: <40D64DF7.5040601@pobox.com> <20040620210233.1e126ddc.akpm@osdl.org>
 <200406210200.42594.norberto+linux-kernel@bensa.ath.cx>
 <200406210239.28918.norberto+linux-kernel@bensa.ath.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 21 Jun 2004, Norberto Bensa wrote:
> 
> Attaaached,    ..cooonfiig  and   dmmesssg.  Note:   iit''s   
> waaaaaaaaaaaaaaay    too     fffasssst  on X.  Text moode    termiinall   
> it''ss  oook.

Does it fix it to just remove that one line completely?

Like this..

		Linus

---
--- 1.76/arch/i386/kernel/mpparse.c	Fri Jun 18 09:29:48 2004
+++ edited/arch/i386/kernel/mpparse.c	Sun Jun 20 23:14:12 2004
@@ -1017,7 +1017,6 @@
 
 		for (idx = 0; idx < mp_irq_entries; idx++)
 			if (mp_irqs[idx].mpc_srcbus == MP_ISA_BUS &&
-				(mp_irqs[idx].mpc_dstapic == ioapic) &&
 				(mp_irqs[idx].mpc_srcbusirq == i ||
 				mp_irqs[idx].mpc_dstirq == i))
 					break;
