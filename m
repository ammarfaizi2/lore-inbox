Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264881AbUISWtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264881AbUISWtJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 18:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264903AbUISWtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 18:49:09 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:63628 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264881AbUISWtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 18:49:06 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm1: i8042.c: Can't read CTR while initializing i8042
Date: Sun, 19 Sep 2004 17:48:57 -0500
User-Agent: KMail/1.6.2
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
References: <0F0D52DF-0A80-11D9-96E1-000D9352858E@linuxmail.org>
In-Reply-To: <0F0D52DF-0A80-11D9-96E1-000D9352858E@linuxmail.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200409191748.58785.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 19 September 2004 04:08 pm, Felipe Alfaro Solana wrote:
> Hello,
> 
> My keyboard has suddenly stopped working with 2.6.9-rc2-mm1-VP-S1 and 
> 2.6.9-rc2-mm1. This is part of the output of dmesg:
> 
> i8042: ACPI  [P2KI] at I/O 0x0, 0x0, irq 1
> i8042: ACPI  [P2MI] at irq 12
> i8042.c: Can't read CTR while initializing i8042.
> 
> This does happen on 2.6.9-rc2-mm1-VP-S1 and 2.6.9-rc2-mm1 on a NEC 
> Chrom@ laptop, with a 440BX motherboard, Pentium III Mobile and 
> integrated PS/2 keyboard and mouse. It doesn't happen in 2.6.8.1, not 
> does it happen on my Pentium 4 machine, however.
> 
> Any ideas?
> 

It looks like your box has a badly written DSDT table. Try booting with
i8042.noacpi for now ot try Bjorn's patch that can be found here:

http://marc.theaimsgroup.com/?l=linux-kernel&m=109508824931419&w=2 

-- 
Dmitry
