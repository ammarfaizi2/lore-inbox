Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290475AbSBKVeq>; Mon, 11 Feb 2002 16:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290472AbSBKVeg>; Mon, 11 Feb 2002 16:34:36 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:31748 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290475AbSBKVeW>; Mon, 11 Feb 2002 16:34:22 -0500
Subject: Re: A7M266-D works?
To: maxk@qualcomm.com (Maksim Krasnyanskiy)
Date: Mon, 11 Feb 2002 21:48:02 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), jussi.laako@kolumbus.fi (Jussi Laako),
        linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20020211121409.08b9c5f0@mail1.qualcomm.com> from "Maksim Krasnyanskiy" at Feb 11, 2002 12:33:25 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16aOIs-00081T-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >-       The BIOS appears to misconfigure the PCI setup badly, so badly I've
> >         been sticking in PCI quirk fixups to make some drivers work
> Which board rev are you using ?
> I have 1.03. No problem with PCI so far. All cards that I tried worked just 
> fine.

Check PCI register 0x4C if bits 1 and 2 are clear your board is not running
in a PCI compliant mode and anything may happen. In paticular since memory
and PCI ordering is not preserved you may see corruption and failures. Most
devices don't have that dependancy but a few do - and break horribly.

Alan
