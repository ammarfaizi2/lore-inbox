Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266185AbUFUKrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266185AbUFUKrg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 06:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266189AbUFUKrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 06:47:36 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:29444 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S266185AbUFUKrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 06:47:17 -0400
Subject: Re: 2.6.7-bk way too fast
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040621014837.6b52fa2e.akpm@osdl.org>
References: <40D64DF7.5040601@pobox.com>
	 <20040621014837.6b52fa2e.akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-frWLMeWBysRiM/kBUnV8"
Date: Mon, 21 Jun 2004 12:47:10 +0200
Message-Id: <1087814830.1691.9.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 (1.5.9.1-2) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-frWLMeWBysRiM/kBUnV8
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2004-06-21 at 01:48 -0700, Andrew Morton wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> >
> > Something is definitely screwy with the latest -bk.
> 
> Would you believe that there is a totally separate bug in the latest -mm
> which has exactly the same symptoms?

Applying Andrew's two following patches solved my problems with time
skewing.

Thanks!

--=-frWLMeWBysRiM/kBUnV8
Content-Disposition: attachment; filename=abs
Content-Type: text/plain; name=abs; charset=utf-8
Content-Transfer-Encoding: 7bit

>From linux-kernel-owner@vger.kernel.org Mon Jun 21 11:01:42 2004
Return-Path:
	<linux-kernel-owner+felipe_alfaro=40linuxmail.org-s266164abufuitj@vger.kernel.org>
Received: from kerberos.felipe-alfaro.com ([unix socket]) by
	kerberos.felipe-alfaro.com (Cyrus v2.2.3) with LMTP; Mon, 21 Jun 2004
	11:01:42 +0200
X-Sieve: CMU Sieve 2.2
Received: from localhost (localhost.localdomain [127.0.0.1]) by
	kerberos.felipe-alfaro.com (Postfix) with ESMTP id E1F3642E32 for
	<yo@felipe-alfaro.com>; Mon, 21 Jun 2004 11:01:39 +0200 (CEST)
Delivered-To: felipe_alfaro:linuxmail.org@linuxmail.org
Received: from pop24.pr.outblaze.com [205.158.62.125] by localhost with
	POP3 (fetchmail-6.1.0) for yo@felipe-alfaro.com (single-drop); Mon, 21 Jun
	2004 11:01:39 +0200 (CEST)
Received: (qmail 5531 invoked by uid 0); 21 Jun 2004 08:51:24 -0000
X-OB-Received: from unknown (205.158.62.147) by mta45-1.us4.outblaze.com;
	21 Jun 2004 08:51:24 -0000
Received: from vger.kernel.org (vger.kernel.org [12.107.209.244]) by
	spf5-2.us4.outblaze.com (Postfix) with ESMTP id 11D0419A94A for
	<felipe_alfaro@linuxmail.org>; Mon, 21 Jun 2004 08:51:24 +0000 (GMT)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
	S266164AbUFUItj (ORCPT <rfc822;felipe_alfaro@linuxmail.org>); Mon, 21 Jun
	2004 04:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266165AbUFUItj
	(ORCPT <rfc822;linux-kernel-outgoing>); Mon, 21 Jun 2004 04:49:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:32748 "EHLO mail.osdl.org") by
	vger.kernel.org with ESMTP id S266164AbUFUIth (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>); Mon, 21 Jun 2004 04:49:37 -0400
Received: from bix (build.pdx.osdl.net [172.20.1.2]) by mail.osdl.org
	(8.11.6/8.11.6) with SMTP id i5L8nVr24333; Mon, 21 Jun 2004 01:49:31 -0700
Date:	Mon, 21 Jun 2004 01:48:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-bk way too fast
Message-Id: <20040621014837.6b52fa2e.akpm@osdl.org>
In-Reply-To: <40D64DF7.5040601@pobox.com>
References: <40D64DF7.5040601@pobox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List:	linux-kernel@vger.kernel.org
X-Evolution-Source: imap://falfaro;auth=GSSAPI@192.168.0.1/
Content-Transfer-Encoding: 8bit

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> Something is definitely screwy with the latest -bk.

Would you believe that there is a totally separate bug in the latest -mm
which has exactly the same symptoms?

mark_offset_tsc() does

	if (lost && abs(delay - delay_at_last_interrupt) > (900000/HZ))
		jiffies_64++;

which is doing abs(unsigned long).

Which works OK if abs() in a function, but I made it a macro.

This fixes it up.


diff -puN include/linux/kernel.h~abs-fix-fix include/linux/kernel.h
--- 25/include/linux/kernel.h~abs-fix-fix	2004-06-21 01:42:24.283873616 -0700
+++ 25-akpm/include/linux/kernel.h	2004-06-21 01:43:08.150204920 -0700
@@ -55,7 +55,12 @@ void __might_sleep(char *file, int line)
 #endif
 
 #define abs(x) ({				\
-		typeof(x) __x = (x);		\
+		int __x = (x);			\
+		(__x < 0) ? -__x : __x;		\
+	})
+
+#define labs(x) ({				\
+		long __x = (x);			\
 		(__x < 0) ? -__x : __x;		\
 	})
 
_

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

--=-frWLMeWBysRiM/kBUnV8
Content-Disposition: attachment; filename=mpparse
Content-Type: text/plain; name=mpparse; charset=utf-8
Content-Transfer-Encoding: 7bit

>From linux-kernel-owner@vger.kernel.org Mon Jun 21 10:00:43 2004
Return-Path:
	<linux-kernel-owner+felipe_alfaro=40linuxmail.org-s266143abufuhs6@vger.kernel.org>
Received: from kerberos.felipe-alfaro.com ([unix socket]) by
	kerberos.felipe-alfaro.com (Cyrus v2.2.3) with LMTP; Mon, 21 Jun 2004
	10:00:43 +0200
X-Sieve: CMU Sieve 2.2
Received: from localhost (localhost.localdomain [127.0.0.1]) by
	kerberos.felipe-alfaro.com (Postfix) with ESMTP id 9F99242E42 for
	<yo@felipe-alfaro.com>; Mon, 21 Jun 2004 10:00:43 +0200 (CEST)
Delivered-To: felipe_alfaro:linuxmail.org@linuxmail.org
Received: from pop24.pr.outblaze.com [205.158.62.125] by localhost with
	POP3 (fetchmail-6.1.0) for yo@felipe-alfaro.com (single-drop); Mon, 21 Jun
	2004 10:00:43 +0200 (CEST)
Received: (qmail 12717 invoked by uid 0); 21 Jun 2004 07:22:01 -0000
X-OB-Received: from unknown (205.158.62.52) by mta45-1.us4.outblaze.com; 21
	Jun 2004 07:22:01 -0000
Received: from vger.kernel.org (vger.kernel.org [12.107.209.244]) by
	spf5-3.us4.outblaze.com (Postfix) with ESMTP id 2F4FE3CF2A for
	<felipe_alfaro@linuxmail.org>; Mon, 21 Jun 2004 07:17:50 +0000 (GMT)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
	S266143AbUFUHS6 (ORCPT <rfc822;felipe_alfaro@linuxmail.org>); Mon, 21 Jun
	2004 03:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266138AbUFUHS6
	(ORCPT <rfc822;linux-kernel-outgoing>); Mon, 21 Jun 2004 03:18:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:5803 "EHLO mail.osdl.org") by
	vger.kernel.org with ESMTP id S266144AbUFUHRV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>); Mon, 21 Jun 2004 03:17:21 -0400
Received: from bix (build.pdx.osdl.net [172.20.1.2]) by mail.osdl.org
	(8.11.6/8.11.6) with SMTP id i5L7H5r10678; Mon, 21 Jun 2004 00:17:05 -0700
Date:	Mon, 21 Jun 2004 00:16:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: lkml@lpbproduction.scom
Cc: lkml@lpbproductions.com, cs@tequila.co.jp, torvalds@osdl.org, norberto+linux-kernel@bensa.ath.cx, linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: 2.6.7-bk way too fast
Message-Id: <20040621001612.176bf8e1.akpm@osdl.org>
In-Reply-To: <200406210018.04883.lkml@lpbproductions.com>
References: <40D64DF7.5040601@pobox.com>
	 <Pine.LNX.4.58.0406202313510.11274@ppc970.osdl.org>
	 <40D688D1.7020308@tequila.co.jp>
	 <200406210018.04883.lkml@lpbproductions.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List:	linux-kernel@vger.kernel.org
X-Evolution-Source: imap://falfaro;auth=GSSAPI@192.168.0.1/
Content-Transfer-Encoding: 8bit

"Matt H." <lkml@lpbproductions.com> wrote:
>
> I can confirm simular behavior here. I loaded 2.6.7-mm1 tonite  and  tried  
> Andrew's  patch ( which didn't work ) and then Linus's  ( which also didn't 
> work ).
> 

hm.  This worked for me.  Could you double-check?


diff -puN arch/i386/kernel/mpparse.c~double-clock-speed-fix arch/i386/kernel/mpparse.c
--- 25/arch/i386/kernel/mpparse.c~double-clock-speed-fix	2004-06-20 23:28:16.655299120 -0700
+++ 25-akpm/arch/i386/kernel/mpparse.c	2004-06-20 23:28:20.468719392 -0700
@@ -1017,7 +1017,6 @@ void __init mp_config_acpi_legacy_irqs (
 
 		for (idx = 0; idx < mp_irq_entries; idx++)
 			if (mp_irqs[idx].mpc_srcbus == MP_ISA_BUS &&
-				(mp_irqs[idx].mpc_dstapic == ioapic) &&
 				(mp_irqs[idx].mpc_srcbusirq == i ||
 				mp_irqs[idx].mpc_dstirq == i))
 					break;
diff -puN arch/x86_64/kernel/mpparse.c~double-clock-speed-fix arch/x86_64/kernel/mpparse.c
--- 25/arch/x86_64/kernel/mpparse.c~double-clock-speed-fix	2004-06-20 23:28:16.672296536 -0700
+++ 25-akpm/arch/x86_64/kernel/mpparse.c	2004-06-20 23:28:20.469719240 -0700
@@ -861,7 +861,6 @@ void __init mp_config_acpi_legacy_irqs (
 
 		for (idx = 0; idx < mp_irq_entries; idx++)
 			if (mp_irqs[idx].mpc_srcbus == MP_ISA_BUS &&
-				(mp_irqs[idx].mpc_dstapic == ioapic) &&
 				(mp_irqs[idx].mpc_srcbusirq == i ||
 				mp_irqs[idx].mpc_dstirq == i))
 					break;
_

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

--=-frWLMeWBysRiM/kBUnV8--

