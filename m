Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288985AbSAZCQc>; Fri, 25 Jan 2002 21:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288987AbSAZCQX>; Fri, 25 Jan 2002 21:16:23 -0500
Received: from www.k.ro ([194.102.255.23]:57498 "EHLO www.k.ro")
	by vger.kernel.org with ESMTP id <S288985AbSAZCQF>;
	Fri, 25 Jan 2002 21:16:05 -0500
Date: Sat, 26 Jan 2002 04:16:02 +0200
Message-Id: <200201260216.g0Q2G2D05333@www.k.ro>
From: Adrian Partenie <partenie_a@k.ro>
X-Mailer: Super-Mail@k.ro http://mail.k.ro/
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Sender-IP: 193.226.81.13
To: linux-kernel@vger.kernel.org
Subject: ISA PNP sound card not detected 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  
Hi, 

I hope I'm not wasting your time and I report a kernel bug for sb.0 module.



	I have a Radio Max (Zoltrix RSS 58800 ) sound card for ISA slot. Under
Linux I used it with Red Hat 6.0 and 7.0 (kernels 2.2.5-15 and 2.2.16)
which worked almost fine (except the well known fact that SoundBlaster
under Linux is supported only on 8bits, Mad16 module didn't worked and was
silent until booted with loadlin). I used the pnpdump and isapnp to
configure it and the sb.o module (with module dependencies sound,
soundelow, soundcore, uart401), and opl30sa for midi.
	I installed Red Hat 7.2 (kernel 2.4.10) and although 
isapnp initializes the sound card I can't insert module sb.o; dependencies
sound.0, uart401.o and sb_lib.o are satisfied, but when i try insmod sb.o I
get a message like wrong irq or io. 
	I tried 
"modprobe sb.0 irq=5 io=0x220 ( dma=0 )" which are correct values and I get
the message can't find ISA pnp card, no such device; dmesg | tail shows the
same message. Same result with sndconfig tool - there is no ISA pnp card
...
	Why isapnp initializes the card but then the kernel can't see it?

I checked /proc files, there are not in use irq5, dma0 and io0x220 which is
normally because sb.o is not present. 

System configuration:

Pentium 200MMX, Acorp MB with Intds,
Adrian Partenie

 



------------------------------
K Free E-mail http://www.k.ro/
by KappaNet http://www.kappa.ro/





