Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261413AbVE2TSC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbVE2TSC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 15:18:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbVE2TSC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 15:18:02 -0400
Received: from mailfe04.swip.net ([212.247.154.97]:18825 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261413AbVE2TRu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 15:17:50 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: 2.6.12-rc5-git3 fails compile -- acpi_boot_table_init
From: Alexander Nyberg <alexn@telia.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Pete Clements <clem@clem.clem-digital.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0505291157120.10545@ppc970.osdl.org>
References: <200505281206.j4SC6iLa015878@clem.clem-digital.net>
	 <1117287439.952.17.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0505291157120.10545@ppc970.osdl.org>
Content-Type: text/plain
Date: Sun, 29 May 2005 21:17:40 +0200
Message-Id: <1117394260.957.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This is a neverending story
> > 
> > linux/acpi.h contains empty declarations for acpi_boot_init() &
> > acpi_boot_table_init() but they are nested inside #ifdef CONFIG_ACPI.
> > 
> > So we'll have to #ifdef in arch/i386/kernel/setup.c: setup_arch()
> 
> Wouldn't it be much nicer to just fix <linux/acpi.h> instead? Or, if you
> really prefer this, then you should remove the now useless code from
> acpi.h. In either case, this patch looks wrong.
> 

There's no question that the patch isn't the correct solution to the
problem, it's a band-aid for a -rc5 kernel. The current acpi include
system doesn't work very well.

Fixing it up for real with the risk of making some arch/config not
compile for a long awaited 2.6.12 and having someone chase me with a
spade isn't something i'm longing to try out. But if you insist...

