Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263207AbREaUWn>; Thu, 31 May 2001 16:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263209AbREaUWe>; Thu, 31 May 2001 16:22:34 -0400
Received: from [216.156.138.34] ([216.156.138.34]:37383 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S263207AbREaUWY>;
	Thu, 31 May 2001 16:22:24 -0400
Message-ID: <3B16A7E3.1BD600F3@colorfullife.com>
Date: Thu, 31 May 2001 22:21:55 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-ac2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: thunder7@xs4all.nl, linux-kernel@vger.kernel.org
Subject: Re: [lkml]Re: interrupt problem with MPS 1.4 / not with MPS 1.1 ?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> I know that with MPS 1.4, the USB controller finds itself at an 
> unshared interrupt 19. I can't reboot at the moment to check. 
>
lspci -vxxx -s 00:07.0

the APIC sits in the southbridge.
the low 2 bits of offset 0x58 must be set [route USB IRQ to APIC], and 

lspci -vx -s 00:07.2

offset 0x3C must be set to 3 [19 & 15]

There was some discussion about the same problem with the sound part of
the southbridge.

What are the current values of these registers?

--
	Manfred
