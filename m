Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263281AbTGXLrl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 07:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263315AbTGXLrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 07:47:41 -0400
Received: from fep01-mail.bloor.is.net.cable.rogers.com ([66.185.86.71]:62802
	"EHLO fep01-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S263281AbTGXLrk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 07:47:40 -0400
Message-ID: <002a01c351db$c4e426c0$7f0a0a0a@lappy7>
Reply-To: "Sean" <seanlkml@rogers.com>
From: "Sean" <seanlkml@rogers.com>
To: "carbonated beverage" <ramune@net-ronin.org>
Cc: <linux-kernel@vger.kernel.org>
References: <fa.etf9pq0.cj6k82@ifi.uio.no>
Subject: Re: 2.5 bk build failure.
Date: Thu, 24 Jul 2003 08:04:43 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at fep01-mail.bloor.is.net.cable.rogers.com from [24.102.213.108] using ID <seanlkml@rogers.com> at Thu, 24 Jul 2003 08:02:17 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Searched the archive, found a few posts talking about this, but no solution
> seems to have been posted.

> Anyone have an idea?

> Thanks,

>         ld -m elf_i386  -T arch/i386/vmlinux.lds.s [snip]

> drivers/built-in.o: In function `x25_asy_changed_mtu':
> drivers/built-in.o(.text+0x6eae6): undefined reference to `save_flags'
> drivers/built-in.o(.text+0x6eaeb): undefined reference to `cli'
> drivers/built-in.o(.text+0x6eba1): undefined reference to `restore_flags'
> make: *** [.tmp_vmlinux1] Error 1


Those macros are being phased out in the new kernel.  The code needs to 
be updated in the x25_asy driver.   Until then, it should still work fine for you 
if you compile the kernel for UP instead of SMP.

Cheers,
Sean

