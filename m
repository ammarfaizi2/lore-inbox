Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263160AbRFCPLr>; Sun, 3 Jun 2001 11:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263346AbRFCPLh>; Sun, 3 Jun 2001 11:11:37 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:5 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263160AbRFCO5a>; Sun, 3 Jun 2001 10:57:30 -0400
Subject: Re: Linux 2.4.5-ac7
To: green@linuxhacker.ru (Oleg Drokin)
Date: Sun, 3 Jun 2001 15:54:59 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), rmk@arm.linux.org.uk (Russell King),
        laughing@shared-source.org (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010603185142.A1474@linuxhacker.ru> from "Oleg Drokin" at Jun 03, 2001 06:51:42 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E156ZHP-0004P4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Last time I looked, it was supported:
> > > + * usb-ohci-sa1111.h
> > So the SA1110 has PCI bus ? Or at least equivalent logic ?
> SA1110 do not have PCI bus. Neither do SA1111.

Well since its not part of the standard or -ac kernel tree I can't evaluate
other solutions. I think the ARM folks can deal with the question when they
reach it

> I am not sure what kind of equivalent logic you mean.
> All IO addresses are fixed and specified in chip spec.

OHCI is specified for PCI. It is specified in terms of PCI config registers
in part. It could be that the code needs to have $CONFIG_PCI on the dep
rules for OHCI and UHCI and the ARM driver be seperate. When the ARM stuff is
merged its worth working out.

