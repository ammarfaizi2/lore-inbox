Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262928AbTI2JC2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 05:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262929AbTI2JC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 05:02:28 -0400
Received: from mail.uptime.at ([62.116.87.11]:53409 "EHLO mail.uptime.at")
	by vger.kernel.org with ESMTP id S262928AbTI2JC0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 05:02:26 -0400
From: "Oliver Pitzeier" <o.pitzeier@uptime.at>
To: <viro@parcelfarce.linux.theplanet.co.uk>,
       "'Oliver Pitzeier'" <oliver@linux-kernel.at>
Cc: "'Linus Torvalds'" <torvalds@osdl.org>,
       "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: Linux 2.6.0-test6
Date: Mon, 29 Sep 2003 11:00:35 +0200
Organization: UPtime system solutions
Message-ID: <000801c38668$296324f0$020b10ac@pitzeier.priv.at>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: 
X-SpamMunger-MailScanner-Information: Please contact UPtime for more information
X-SpamMunger-MailScanner: clean
X-SpamMunger-MailScanner-SpamCheck: not spam (whitelisted),
	SpamAssassin (Wertung=-4.9, benoetigt 5.2, BAYES_00 -4.90)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viro!

[ ... ]
> > It work's on my Intel machine, but on Alpha, I get this: <snip>
> >   CC      init/version.o
> >   LD      init/built-in.o
> >   LD      .tmp_vmlinux1
> > kernel/built-in.o: In function `try_to_wake_up':
> > kernel/built-in.o(.text+0x438): undefined reference to `sched_clock'
> 
> Add
> unsigned long long default_sched_clock(void)
> {
> 	return (unsigned long long)jiffies * (1000000000 / HZ);
> }
> 
> in kernel/sched.c and
> 
> #define sched_clock default_sched_clock
> 
> in include/asm-alpha/system.h
> 
> FWIW, the former should've been done from the very beginning

[ ... ]

This seems to work!

Thanks!

Best,
 Oliver

