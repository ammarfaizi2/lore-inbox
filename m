Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318236AbSHDTgN>; Sun, 4 Aug 2002 15:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318234AbSHDTgM>; Sun, 4 Aug 2002 15:36:12 -0400
Received: from mailrelay.nefonline.de ([212.114.153.196]:29958 "EHLO
	mailrelay.nefonline.de") by vger.kernel.org with ESMTP
	id <S318231AbSHDTgM>; Sun, 4 Aug 2002 15:36:12 -0400
Message-Id: <200208041939.VAA15993@myway.myway.de>
From: "Daniela Engert" <dani@ngrt.de>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Sun, 04 Aug 2002 21:39:39 +0200 (CDT)
Reply-To: "Daniela Engert" <dani@ngrt.de>
X-Mailer: PMMail 2.20.2200 for OS/2 Warp 4.05
In-Reply-To: <1028492839.15200.14.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: Linux 2.4.19-ac2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04 Aug 2002 21:27:19 +0100, Alan Cox wrote:

> 	if((r9 & 0x0A) != 0x0A)		/* Legacy only */
> 	/* Request programmability */
> 	pci_write_config_byte(dev, PCI_CLASS_PROG, r9|0x05);

There is no guarantee that this will succeed. Quite some PCI IDE
controller chips (f.e. ALi, SiS) may have config register 9 r/o locked
by some other means.

Ciao,
  Dani


