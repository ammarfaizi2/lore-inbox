Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291353AbSBMMCY>; Wed, 13 Feb 2002 07:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291372AbSBMMCO>; Wed, 13 Feb 2002 07:02:14 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:34567 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291353AbSBMMCK>; Wed, 13 Feb 2002 07:02:10 -0500
Subject: Re: SMT, again (was: Re: [PATCH]: Fix MTRR handling on HT CPUs)
To: Martin.Wilck@fujitsu-siemens.com (Martin Wilck)
Date: Wed, 13 Feb 2002 12:15:52 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        Martin.Wilck@fujitsu-siemens.com (Martin Wilck),
        linux-kernel@vger.kernel.org (Linux Kernel mailing list),
        marcelo@conectiva.com.br (Marcelo Tosatti)
In-Reply-To: <Pine.LNX.4.33.0202131228290.11012-100000@biker.pdb.fsc.net> from "Martin Wilck" at Feb 13, 2002 12:42:03 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16ayKH-00057F-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I just found out that Intel specifies that on SMT-enabled
> ("Jackson") systems the BIOS MP tables list only the physical CPUs.
> Logical CPUs will only be available through the ACPI tables.

Yep. Thats why the miniacpi scanning stuff is in the current kernel

> All my attempts to get ACPI running on our SMT-enabled system have failed
> so far (I'm working on a bug report on that for linux-acpi).

You don't need ACPI itself. See arch/i386/kernel/acpitable.c. Intel contributed
patches to handle this stuff already.

Alan
