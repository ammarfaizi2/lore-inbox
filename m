Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290827AbSBLIMi>; Tue, 12 Feb 2002 03:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290824AbSBLIMT>; Tue, 12 Feb 2002 03:12:19 -0500
Received: from inje.iskon.hr ([213.191.128.16]:43393 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S290827AbSBLIMK>;
	Tue, 12 Feb 2002 03:12:10 -0500
To: Jakub Travnik <J.Travnik@sh.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: emu10k1 - interrupt storm?
In-Reply-To: <3C684A88.5070307@sh.cvut.cz>
Reply-To: zlatko.calusic@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko.calusic@iskon.hr>
Date: Tue, 12 Feb 2002 09:12:04 +0100
In-Reply-To: <3C684A88.5070307@sh.cvut.cz> (Jakub Travnik's message of "Mon,
 11 Feb 2002 23:49:44 +0100")
Message-ID: <dny9hzunjf.fsf@magla.zg.iskon.hr>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Common Lisp,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Travnik <J.Travnik@sh.cvut.cz> writes:

> Hello and sorry for replying late,
>
> I did experienced same problems with emu10k1 on 2.4.8 (as is in Mandrake 8.1).
>
> After modprobing emu10k1, interrupts per second (as reported by vmstat)
> start to increase and in few minutes they were as high as 70000 per second.
> rmmod-ing emu10k1 caused number of interrupts per second to slowly decrease.
>
> Following setting affected this:
>
> In BIOS setup, PCI options:
> Interrupts triggered by
> 1, edge
> 2, level

Unfortunately I don't have that setting in my BIOS.

>
> value 'edge' causes problems,
> value 'level' makes thing work without problems.
>

But anyway, emu10k1 on irq 5 already uses level type:

  5:       5193       5183   IO-APIC-level  EMU10K1


> If you are experiencing problems with this, set to 'level'.
>

Eventually, I forced esd to exit after few seconds of inactivity. That
way I at least don't have interrupt storms when I don't have any sound
output through esd.

Regards,
-- 
Zlatko
