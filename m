Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311320AbSD1QMz>; Sun, 28 Apr 2002 12:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311564AbSD1QMy>; Sun, 28 Apr 2002 12:12:54 -0400
Received: from inje.iskon.hr ([213.191.128.16]:59568 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S311320AbSD1QMy>;
	Sun, 28 Apr 2002 12:12:54 -0400
To: Jarno Paananen <jpaana@s2.org>
Cc: Pierre Rousselet <pierre.rousselet@wanadoo.fr>,
        lkml <linux-kernel@vger.kernel.org>, mingo@elte.hu
Subject: Re: 2.5.9 - HPT366 ide unexpected interrupts
In-Reply-To: <3CC5BAA3.3080705@wanadoo.fr> <m3u1q0smou.fsf@kalahari.s2.org>
Reply-To: zlatko.calusic@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko.calusic@iskon.hr>
Date: Sun, 28 Apr 2002 18:12:37 +0200
Message-ID: <878z77er9m.fsf@atlas.iskon.hr>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Common Lisp,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jarno Paananen <jpaana@s2.org> writes:

> Pierre Rousselet <pierre.rousselet@wanadoo.fr> writes:
>
> | PIII 650/Abit BE6 HPT366(ide2, ide3)
> | 
> | dmesg gives 482 times the same line :
> | ide: unexpected interrupt 0 11

I'm having the same problems on dual PIII (VIA chipset) with addon
Promise IDE card:

Apr 24 19:34:51 atlas kernel: ide: unexpected interrupt 1 11

Lots of those...

Looks like it favors additional IDE interfaces. As system appears to
behave sanely, modulo flooded logs, I decided to comment the printk
for the time being.

Ingo, does it have anything to do with your interrupt balancing code?
If you need additional testing, let me know.
-- 
Zlatko
