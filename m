Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129584AbRACK2w>; Wed, 3 Jan 2001 05:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129588AbRACK2m>; Wed, 3 Jan 2001 05:28:42 -0500
Received: from [172.16.18.67] ([172.16.18.67]:50560 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S129584AbRACK2g>; Wed, 3 Jan 2001 05:28:36 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3A52F33D.2050105@demeter.cs.york.ac.uk> 
In-Reply-To: <3A52F33D.2050105@demeter.cs.york.ac.uk>  <3A1C6D4C.7060306@demeter.cs.york.ac.uk> <3A1AC075.4020506@cs.york.ac.uk> <4186.974889923@redhat.com> <11299.974975638@redhat.com> 
To: Michel Salim <mas118@demeter.cs.york.ac.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, dhinds@valinux.com
Subject: Re: i82365 PCI-PCMCIA bridge still not working in 2.4.0-test11 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 03 Jan 2001 09:58:05 +0000
Message-ID: <9752.978515885@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


mas118@demeter.cs.york.ac.uk said:
> Manually inputting i365_base=0x1030 when loading the module results in
>  the same freeze - nothing works at all, had to do a full hardware
> reset.  This is on the latest 2.4.0-prerelease... 

Is this the code in 2.4.0-prerelease or the code I sent you? Sounds like 
it's probably dying in an IRQ storm.


mas118@demeter.cs.york.ac.uk said:
>  David, any luck on your side? Sorry for the long absence, been a bit
> busy and then I went on holiday.

I have a full databook for the i82092aa and a selection of example boards - 
was yours one of those or another type? I'm not entirely sure when I'll 
have time to poke at it again - I may wait for the 2.5 branch.

mas118@demeter.cs.york.ac.uk said:
> Any chance it's due to IRQ sharing?

Possibly. Is any driver trying to use irq 11? Can you disable the irq for 
the video card in your BIOS?

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
