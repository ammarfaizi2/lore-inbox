Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289888AbSBKRl1>; Mon, 11 Feb 2002 12:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289865AbSBKRlR>; Mon, 11 Feb 2002 12:41:17 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:5649 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289885AbSBKRkE>; Mon, 11 Feb 2002 12:40:04 -0500
Subject: Re: 2.5.4, cs46xx snd, and virt_to_bus
To: tom_gall@vnet.ibm.com (Tom Gall)
Date: Mon, 11 Feb 2002 17:53:49 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C6808E7.7F8BC131@vnet.ibm.com> from "Tom Gall" at Feb 11, 2002 12:09:43 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16aKeD-0007NH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   Well forgive me for not being up on the lastest news but from building
> 2.5.4 kernel for my box, which uses the cs46xx.c sound driver, it would
> appear that virt_to_bus and bus_to_virt has gone the way of the do-do. 

You need to switch to using pci_alloc_consistet, pci_map_* and friends. Its
been the case for a while that drivers should be using the PCI api, and its
needed on some non x86 platforms - now its enforced for 2.5
