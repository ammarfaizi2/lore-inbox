Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313506AbSC3Rbq>; Sat, 30 Mar 2002 12:31:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313508AbSC3Rbg>; Sat, 30 Mar 2002 12:31:36 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:32516 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313506AbSC3RbZ>; Sat, 30 Mar 2002 12:31:25 -0500
Subject: Re: Linux 2.4.19-pre5: bad config
To: rmk@arm.linux.org.uk (Russell King)
Date: Sat, 30 Mar 2002 17:46:21 +0000 (GMT)
Cc: eyal@eyal.emu.id.au (Eyal Lebedinsky),
        marcelo@conectiva.com.br (Marcelo Tosatti),
        linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <20020330090602.B23576@flint.arm.linux.org.uk> from "Russell King" at Mar 30, 2002 09:06:02 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16rMvl-0003Oz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > -dep_tristate '  SA1100 support' CONFIG_PCMCIA_SA1100 $CONFIG_ARCH_SA1100 $CONFIG_PCMCIA
> > +if [ "$CONFIG_ARCH_SA1100" = "y" ]; then
> > +	dep_tristate '  SA1100 support' CONFIG_PCMCIA_SA1100 $CONFIG_PCMCIA
> > +fi
> 
> It's basically to wrap it in an CONFIG_ARM and leave the SA1100 dependency.
> Why?  There are other ARM PCMCIA drivers, and rather have a mass of if
> statements, I'd rather see dep_*

dep_ won't work for this case. The ARM symbols are not set on non ARM boxes
