Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292564AbSBTXBY>; Wed, 20 Feb 2002 18:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292566AbSBTXBO>; Wed, 20 Feb 2002 18:01:14 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:35342 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292564AbSBTXA7>; Wed, 20 Feb 2002 18:00:59 -0500
Subject: Re: Q: PCI Driver ioremap
To: dstroupe@keyed-upsoftware.com (David Stroupe)
Date: Wed, 20 Feb 2002 23:15:13 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C741BAF.9090300@keyed-upsoftware.com> from "David Stroupe" at Feb 20, 2002 03:57:03 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16dfxB-00054C-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> pci_enable_device (pdev)

Should check the return but that is fine I guess

>         if(base==0)
>            DBG("memory mapped wrong\n");//this is never reached
>         writew(0xffff, base + 0x48);
> <snip>
> The write is unsuccessful or at least the data never reaches the card. 
>  What am I doing incorrectly?


Looks fine to me. Obviously you should a read to make sure the write
reaches the card from PCI posting but I'd expect that to timeout and
hit the card
