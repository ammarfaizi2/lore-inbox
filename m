Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315751AbSEJB04>; Thu, 9 May 2002 21:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315752AbSEJB0z>; Thu, 9 May 2002 21:26:55 -0400
Received: from smtp2.home.se ([195.66.35.201]:43621 "EHLO smtp2.home.se")
	by vger.kernel.org with ESMTP id <S315751AbSEJB0z>;
	Thu, 9 May 2002 21:26:55 -0400
Message-ID: <001101c1f7c1$c233fba0$0319450a@sandos>
From: =?iso-8859-1?Q?John_B=E4ckstrand?= <sandos@home.se>
To: <linux-kernel@vger.kernel.org>
Subject: sb16 isa non-pnp problems
Date: Fri, 10 May 2002 03:26:49 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ive been trying to get my sb16 isa non-pnp working on a
old 486, it has got two isa slots.

Ive checked the config of both my two NICs (tried two
different ones), and the config on my sb16, no
conflicts, and I am sure that I set the correct
parameters. I also tried a pnp isa sb16 (vibra). Ive
tried 2.2.20 and 2.4.17, both compiled in and module,
but not every possible combination though.

The problems Im seeing is for the pnp card that it isnt
detected at all, even if I do modprobe sb io=0x220
dma=1 irq=5, I guess that is because I cant seem to be
able to configure it using pnp, isapnp didnt print
anything and the conf-files seemed very long-winded.

The non-pnp card is atleast detected, and I can even
get sound from it. The sb16 DOS-util diagnose.exe from
creative plays fine on this card, but it doesnt even
detect the newer pnp card. Anyway, in linux I can cat
/dev/urandom > /dev/dsp on my non-pnp, and will get
noise. But my system will hang after about 10-20
seconds with this. Playing a mp3 using mpg123 gets me a
seg fault, or unable to handle paging request, aiiie:
killing interrupt handler or some other oops.

Any ideas? I have looked into /proc/interrupts,
/proc/ioports, /proc/dma, and there are no conflicts
afaics. Its an oldish 486, 20mb ram, running a
overdrive 80mhz right now.

---
John Bäckstrand


