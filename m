Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310625AbSCPUpv>; Sat, 16 Mar 2002 15:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310622AbSCPUpo>; Sat, 16 Mar 2002 15:45:44 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:36874 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310635AbSCPUpd>; Sat, 16 Mar 2002 15:45:33 -0500
Subject: Re: [PATCH] devexit fixes in i82092.c
To: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 16 Mar 2002 21:00:09 +0000 (GMT)
Cc: jgarzik@mandrakesoft.com (Jeff Garzik),
        torvalds@transmeta.com (Linus Torvalds),
        andersg@0x63.nu (Anders Gustafsson), arjanv@redhat.com,
        linux-kernel@vger.kernel.org, mochel@osdl.org
In-Reply-To: <m1lmcsxqhy.fsf@frodo.biederman.org> from "Eric W. Biederman" at Mar 16, 2002 12:27:21 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16mLHd-00079Z-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Please for the Linux booting Linux scenario it is mandatory we get this right
> for reboot.  I know for a fact that currently we leave active receive buffers on
> network cards when we reboot. (If you haven't downed the interface).  So it
> is possible for a network packet to come in and hose a machine that is rebooting.

Thats a bios bug. Its pretty much the whole reason for having bus master
enable bits in the PCI configuration. The BIOS should have killed the bus
masters.

Alan
