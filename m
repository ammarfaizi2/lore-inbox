Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290511AbSAYTi4>; Fri, 25 Jan 2002 14:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290513AbSAYTiq>; Fri, 25 Jan 2002 14:38:46 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:46122 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S290511AbSAYTid> convert rfc822-to-8bit; Fri, 25 Jan 2002 14:38:33 -0500
Date: Fri, 25 Jan 2002 00:43:20 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: chus Medina <chuslists@hotmail.com>
cc: <linux-kernel@vger.kernel.org>, <chus@glue.umd.edu>
Subject: Re: PCI #LOCK assertion
In-Reply-To: <F4T0giSftNtzsG06vdG0001152a@hotmail.com>
Message-ID: <20020125003124.K1588-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 25 Jan 2002, chus Medina wrote:

> Hola,
>
> I need to create module to perform atomic transactions through the PCI bus
> between the processor and an IDE hard disk. The PCI bus specifications 2.2
> point to the #LOCK signal to perform such a transaction. Is possible to
> assert the #LOCK signal of the PCI bus using the Linux Kernel? How? I didnt
> see any pointers in include/pci.h or anywhere in the source code.
>
> I will truly appreciate any help/pointers,

This has nothing to do with the kernel.
This only depends on your CPU and on the PCI-HOST bridge of your system.

For example, some (all?) Intel PCI-HOST bridges will translate a LOCK
prefixed memory READ to PCI into a locked PCI transaction. It is also
possible to perform a locked READ/MODIFY transaction to PCI using the
corresponding LOCK prefixed memory instruction.

I suggest you to download PCI-HOST bridge documents from Intel site and
to look into them, if obviously you are interestested in such hardware.

Just, PCI-to-PCI bridges do not carry the PCI LOCK# protocol. As a result
a subsystem relying on PCI LOCK# will not work (as expected) if PCI agents
are talking through a PCI-to-PCI bridge.

  Gérard.

