Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315895AbSEGQuB>; Tue, 7 May 2002 12:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315900AbSEGQuA>; Tue, 7 May 2002 12:50:00 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:58130 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315895AbSEGQuA>; Tue, 7 May 2002 12:50:00 -0400
Subject: Re: [PATCH] 2.5.14 IDE 56
To: padraig@antefacto.com (Padraig Brady)
Date: Tue, 7 May 2002 18:08:06 +0100 (BST)
Cc: torvalds@transmeta.com (Linus Torvalds),
        aia21@cantab.net (Anton Altaparmakov),
        dalecki@evision-ventures.com (Martin Dalecki),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <3CD800FE.4050004@antefacto.com> from "Padraig Brady" at May 07, 2002 05:29:50 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1758Ra-00081f-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> All the info I've ever needed is /proc/ide/hdx/capacity
> which I could get from /proc/partitions with more a bit
> more effort, so I vote for removing /proc/ide.

/proc/ide has useful information in it that you can't get easily by
other means at the moment - which controller is driving the disks, what
devices are present etc.

> For e.g. could the same arguments could be made for lspci only
> interface to pci info rather than /proc/bus/pci? The following
> references are made to /proc/bus/pci on my system:

lspci relies on /proc/bus/pci - its the only part of the universe that
actually knows how to handle PCI and virtualised PCI devices. Unlike the
older /proc/pci interface it keeps all the complex gunk out of the kernel
