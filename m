Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290734AbSARQdt>; Fri, 18 Jan 2002 11:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290735AbSARQdk>; Fri, 18 Jan 2002 11:33:40 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:20487 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290734AbSARQd3>; Fri, 18 Jan 2002 11:33:29 -0500
Subject: Re: I2O kernel oops with Promise SuperTrak SX6000
To: S.Zimmermann@tu-harburg.de (Sebastian Zimmermann)
Date: Fri, 18 Jan 2002 16:45:31 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <3C483460.70100@tu-harburg.de> from "Sebastian Zimmermann" at Jan 18, 2002 03:42:40 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Rc8x-0007Ha-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When the system is powered up, the SuperTrak BIOS is initializing the 
> adapter. If we manually *abort* the initialization, Linux will boot 
> without problems and we can use the hardware raid.
> 
> However, if we let the controller initialze the adapter (that is the 
> default), the kernel will always Oops when I2O is loaded:

Please try 2.4.18pre3-ac first of all. That has one small detail changed
that may matter.

> My guess is that the i2o module tries to initialize the board. When it 
> already was initialized by the BIOS, the system crashes.

At the moment I've no idea. The i2o code is entitled to reinit the board 
should it want to, and the supertrak 100 certainly works with 18pre3-ac3.

