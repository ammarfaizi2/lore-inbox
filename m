Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315532AbSECBw4>; Thu, 2 May 2002 21:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315533AbSECBwz>; Thu, 2 May 2002 21:52:55 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:39940 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315532AbSECBwy>; Thu, 2 May 2002 21:52:54 -0400
Subject: Re: Linux 2.4.19-pre8: compile failure - umem.c, sdla_fr.c
To: eyal@eyal.emu.id.au (Eyal Lebedinsky)
Date: Fri, 3 May 2002 03:11:31 +0100 (BST)
Cc: marcelo@conectiva.com.br (Marcelo Tosatti),
        linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <3CD1E60B.2E9FDD6F@eyal.emu.id.au> from "Eyal Lebedinsky" at May 03, 2002 11:21:15 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E173SXj-0005RH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> sdla_fr.c: In function `process_route':
> sdla_fr.c:2819: warning: unknown conversion type character `U' in format
> sdla_fr.c:2819: warning: too many arguments for format

Yep. Thats a silly little bug someone made.

> sdla_fr.c: In function `process_ARP':
> sdla_fr.c:4351: structure has no member named `ida_list'

And this one is brilliant. Whoever hacked the printk levels in this file
didn't even bother compiling them before submitting.

Fixed in 2.4.19pre8-ac1 when it appears (should be ifa_list).

Alan
