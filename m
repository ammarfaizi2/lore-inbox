Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282523AbSAARGr>; Tue, 1 Jan 2002 12:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282418AbSAARGi>; Tue, 1 Jan 2002 12:06:38 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:9733 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280725AbSAARGb>; Tue, 1 Jan 2002 12:06:31 -0500
Subject: Re: 2.4.16 with es1370 pci
To: wakko@animx.eu.org (Wakko Warner)
Date: Tue, 1 Jan 2002 17:15:28 +0000 (GMT)
Cc: pierre.rousselet@wanadoo.fr (Pierre Rousselet),
        linux-kernel@vger.kernel.org
In-Reply-To: <20020101104611.A30843@animx.eu.org> from "Wakko Warner" at Jan 01, 2002 10:46:11 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16LSVd-0000pj-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> used the 2nd dsp on this card since this boot, but I know it works since I
> used it the last boot.  When the first quits, they both are gone.  But
> seeing how no interrupts are being delivered, makes sense (see below)

Boot withg the "noapic" option. Quite how your system has managed to
lose an interrupt in the APIC hardware I don't know, but the APIC's
certainly have bugs. It could also be an edge/level trigger but if the BIOS
confused it because IRQ15 was for some kind of IDE device, but I see no
evidence of that.

If it happens with APIC disabled ("noapic")  then the second option might
be worth investigating.
