Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316523AbSEPAKR>; Wed, 15 May 2002 20:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316524AbSEPAKQ>; Wed, 15 May 2002 20:10:16 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:23050 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316523AbSEPAKQ>; Wed, 15 May 2002 20:10:16 -0400
Subject: Re: [PATCH] Hotplug CPU prep V: x86 non-linear CPU numbers
To: rusty@rustcorp.com.au (Rusty Russell)
Date: Thu, 16 May 2002 01:29:19 +0100 (BST)
Cc: pavel@ucw.cz (Pavel Machek), torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, sfr@canb.auug.org.au
In-Reply-To: <E1787yp-0000RO-00@wagner.rustcorp.com.au> from "Rusty Russell" at May 16, 2002 09:14:47 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17898x-0003Cb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> APM is special: what it *really* wants to know is if only CPU 0 is
> online (this test will almost certainly fail miserably if the single
> online CPU is CPU 1, which previously wasn't possible).

It wants to know that only one CPU is running. Doesn't matter which.
APM as defined allows for SMP. APM in the real world doesn't work with
SMP but does work well with uniprocessors. People wanted an SMP kernel
on uniprocessor to do the right thing.

It may well be worth having an apm=on type option because some newer setups
especially those using SMM traps for everything seem to get it right

Alan
