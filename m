Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279146AbRJ2LB4>; Mon, 29 Oct 2001 06:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279147AbRJ2LBq>; Mon, 29 Oct 2001 06:01:46 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:12548 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279146AbRJ2LBh>; Mon, 29 Oct 2001 06:01:37 -0500
Subject: Re: 2.4.13-acX: NM256 hangs at boot
To: suonpaa@iki.fi (Samuli Suonpaa)
Date: Mon, 29 Oct 2001 11:08:20 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <87y9luohi8.fsf@puck.erasmus.jurri.net> from "Samuli Suonpaa" at Oct 29, 2001 12:41:35 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15yAHE-0002M1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> CPtC400 until I upgraded from kernel 2.4.12-ac5 to 2.4.13-ac3. Now the
> system hangs at boot - or to be more precise, right after boot when
> modutils try to load nm256_audio.o as instructed in /etc/modules.
> Lockup is complete, even power-button doesn't work so I have to remove
> battery and power-cord to get the machine shut down. I have
> APM-support compiled in, no ACPI.

Ok.

> NM256 is PCI-based, so I checked whether CONFIG_HOTPLUG_PCI would have
> any effect. It didn't.
> 
> Exactly the same thing happens with 2.4.13-ac4.
> 
> If I compile the kernel without sound-support, everything works just
> fine.

Jeff Garzik updated the neomagic driver to use the generic ac97 codec. It
looks like he didnt quite get it right firs ttime around. I'll take a look
and its then a case of either fixing it or reverting Jeff's change
