Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289172AbSBXCIV>; Sat, 23 Feb 2002 21:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289191AbSBXCIL>; Sat, 23 Feb 2002 21:08:11 -0500
Received: from pD957B36C.dip.t-dialin.net ([217.87.179.108]:43016 "EHLO
	enigma.deepspace.net") by vger.kernel.org with ESMTP
	id <S289172AbSBXCIA>; Sat, 23 Feb 2002 21:08:00 -0500
Message-Id: <200202240206.DAA19045@enigma.deepspace.net>
Content-Type: text/plain; charset=US-ASCII
From: Wolly <wwolly@gmx.net>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Subject: Re: IDE DMA hard lock at boot time (KT266A chpiset)
Date: Sun, 24 Feb 2002 03:06:01 +0100
X-Mailer: KMail [version 1.2.1]
In-Reply-To: <Pine.LNX.4.33.0202231740270.23868-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.33.0202231740270.23868-100000@coffee.psychology.mcmaster.ca>
Cc: <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Thank you very much for your quick responses to my problem. 

Due to your help I was now able to solve both problems. 

Now everything works great (including UDMA and the ethernet NIC 
and ACPI)
[however, the rtl8139 still refuses to work, but I can use the eepro100]. 

The three core things were: 
- switch off apic stuff
- you may enable ACPI but you must _disable_ ide power down 
  in the BIOS (seems to be a bug somewhere)
- This message is normal and can be ignored: 
  PCI: No IRQ known for interrupt pin A of device 00:11.1. Please try using 
    pci=biosirq.

Regards,
Wolly

[Sorry; everyone who did not CC me did not reach me because I seem 
to be `mysteriously' unsubscribed from lkml since Feb 01 when my 
mail box ran out of space...]

> maybe I wasn't clear on this: your problem seems to be irq-routing
> or irq lossage.  others have reported the same thing, and have fixed
> it by turning off the (spurious UP apic usage), turning off apics
> in bios, etc.
