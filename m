Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314277AbSEUMe2>; Tue, 21 May 2002 08:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314417AbSEUMe1>; Tue, 21 May 2002 08:34:27 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:6930 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314277AbSEUMe0>; Tue, 21 May 2002 08:34:26 -0400
Subject: Re: PROBLEM: memory corruption with i815 chipset variant
To: alex@alphac.it (Alessandro Morelli)
Date: Tue, 21 May 2002 13:54:41 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200205211144.g4LBi6dY004917@shiva.lab.novalabs.net> from "Alessandro Morelli" at May 21, 2002 01:44:06 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17A9A1-0007hu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 8. Graphic card has 16MB of memory: Region 0 is reported to be 128M
> (AFAIK, it could be correct).

Quite probably

> ASUS has used the i815 chipset without the CGC, using a Radeon
> Mobility M6 LY instead.  All problems seem to stem from the agpgart
> module: since at least 2.4.9 (after the VM change, IIRC) the kernel
> has shown fundamental instability on this machine.

That means its actually using the same GART code as the 440BX and friends
if I remember rightly (the i815 special stuff is for on board video)

> Without agpgart module, kernel seems stable.  A naive (totally naive,
> I admit it) interpretation suggests a problem in setting the AGP aperture.

Does the ram survive memtest86 overnight with no errors logged if you boot
memtest86 and just leave it ?
