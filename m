Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318892AbSHSO1o>; Mon, 19 Aug 2002 10:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318893AbSHSO1o>; Mon, 19 Aug 2002 10:27:44 -0400
Received: from smtp03.web.de ([217.72.192.158]:20773 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S318892AbSHSO1n> convert rfc822-to-8bit;
	Mon, 19 Aug 2002 10:27:43 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: kernel panic while cd writing
References: <20020817203010.GA251@poczta.gazeta.pl>
X-Face: 8omYku?tAexGd1v,5cQg?N#5RsX"8\+(X=<ysy((i6Hr2uYha{J%Mf!J:,",CqCZSr,>8o[ Ve)k4kR)7DN3VM-`_LiF(jfij'tPzNFf|MK|vL%Z9_#[ssfD[=mFaBy]?VV0&vLi09Jx*:)CVQJ*e3
 Oyv%0J(}_6</D.eu`XL"&w8`%ArL0I8AD'UKOxF0JODr/<g]
From: Markus Plail <plail@web.de>
Date: Mon, 19 Aug 2002 16:30:09 +0200
Message-ID: <873ctaudji.fsf@plailis.homelinux.net>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.3.50
 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Justyna!

* Justyna Bia³a writes:
>Hi.

>I have LiteOn 40x12x48x cd-writer, linux 2.4.19, cdrecord 1.11a24,
>Duron 1000 MHz, ECS K7S5A with SIS735 chipset. My cd-writer works fine
>only in two cases: 

I also have a ECS K7S5A, but I have an acer 2010A cd-writer.

>1. when the speed is not higher than 12x (no matter if the dma is on)
>2. with speed = 32x but only when I turn the dma off with hdparm

My problem was, that the system load was almost unbearable at higher
speeds, but only when I was burning DAO. Do you burn DAO? Is your
system load (top) also very high?
Now I just upgraded to 2.4.20-pre3 and everything is just fine :-) I am
not really sure if it was only the kernel, because I still have the
same problem when I tell the kernel to umask the drive's IRQ (hdparm -u1).
I am not 100% sure if I tried it without umask before.
But without umask, everything seems to work fine now. There's just a
few percent CPU load when doing c2scan or writing DAO.
The only thing is that if I do a c2scan under X, X consumes all my CPU
time after some time and gets unresponsive. Doing the same in the
console there's no problem at all. So I am pretty sure this is a X
problem and not the kernel's.

regards
Markus

