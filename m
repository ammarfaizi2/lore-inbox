Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291688AbSBNPCu>; Thu, 14 Feb 2002 10:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291703AbSBNPCk>; Thu, 14 Feb 2002 10:02:40 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:23059 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291688AbSBNPC1>; Thu, 14 Feb 2002 10:02:27 -0500
Subject: Re: [PATCH} 2.5.5-pre1 VESA fb
To: dalecki@evision-ventures.com (Martin Dalecki)
Date: Thu, 14 Feb 2002 15:16:01 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <3C6BC4E7.3070407@evision-ventures.com> from "Martin Dalecki" at Feb 14, 2002 03:08:39 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16bNc9-0000GD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This adjusts the VESA fb driver to the new bus mapping API.
> I think that this time this is providing the right replacement.... but 
> who knows

The VESA fb window will be higher than the ISA window as its a linear
frame buffer

> -		pmi_base  = (unsigned short*)bus_to_virt(((unsigned long)screen_info.vesapm_seg << 4) + screen_info.vesapm_off);
> +		pmi_base  = (unsigned short*)isa_bus_to_virt(((unsigned long)screen_info.vesapm_seg << 4) + screen_info.vesapm_off);

I don't think it actually matters on x86 but phys_to_virt() is probably
more correct
