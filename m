Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262645AbSJLBks>; Fri, 11 Oct 2002 21:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262663AbSJLBks>; Fri, 11 Oct 2002 21:40:48 -0400
Received: from flamingo.mail.pas.earthlink.net ([207.217.120.232]:7146 "EHLO
	flamingo.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S262645AbSJLBkr>; Fri, 11 Oct 2002 21:40:47 -0400
Date: Fri, 11 Oct 2002 18:40:03 -0700 (PDT)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: [BK PATCH] console changes 1
In-Reply-To: <1749543871.1034360975@[10.10.2.3]>
Message-ID: <Pine.LNX.4.33.0210111831230.2595-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > This patch fixes some of the missed handle_sysrq functions not updated.
> > please apply.
>
> Are you going to have early console support (ie printk from before
> what is now console_init) done before the freeze, or should I just
> submit our version?

Depends on how fast Linus takes my patches. In the end vty_init will
initialize display drivers that need a other resource that are avaliable
latter (i.e pci handling, irqs) and the other drivers will be called by
vt_console_init. vt_console_init can be called much earlier than now. In
fact I will soon remove the need to call bootmem. I plan to removal all
the console related stuff from the arch directories!!! It can be done with
some work. I done it for the ix86 platform. The need for a dummy console
will also go away.

