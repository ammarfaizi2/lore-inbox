Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312675AbSDFRjh>; Sat, 6 Apr 2002 12:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312644AbSDFRjg>; Sat, 6 Apr 2002 12:39:36 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:18192 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312687AbSDFRjR>; Sat, 6 Apr 2002 12:39:17 -0500
Subject: Re: Faster reboots (and a better way of taking crashdumps?)
To: fletch@aracnet.com (Martin J. Bligh)
Date: Sat, 6 Apr 2002 18:56:35 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1650399759.1018005181@[10.10.2.3]> from "Martin J. Bligh" at Apr 05, 2002 11:13:01 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16tuQV-0002Lt-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What's to stop me rebooting by having machine_restart load
> the first sector of the first disk (as the BIOS does), where
> the LILO code should be, and just jumping to it?

In theory nothing

> 1. Are there tables that are created by the BIOS that we 
> destroy during Linux runtime? mps tables spring to mind - 
> I can't see where we preserve them ...

They should be in E820 reserved pages anyway and we do keep them and the
EBDA safe. You will however have blown away ACPI pages marked as disposable

> 2. Things that are reset by reboot that we don't reset during
> normal kernel boot?

Possibly. I wouldnt like to hand control back to the BIOS but the kernel
ought to be ok with itself.

Alan
