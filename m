Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289643AbSAWCDA>; Tue, 22 Jan 2002 21:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289644AbSAWCCu>; Tue, 22 Jan 2002 21:02:50 -0500
Received: from [200.82.42.109] ([200.82.42.109]:11715 "EHLO
	indra.zacarias.com.ar") by vger.kernel.org with ESMTP
	id <S289643AbSAWCCo>; Tue, 22 Jan 2002 21:02:44 -0500
Message-ID: <3C4E1983.CC5FD675@zacarias.com.ar>
Date: Tue, 22 Jan 2002 23:01:39 -0300
From: Gustavo Zacarias <gustavo@zacarias.com.ar>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Rene Rebe <rene.rebe@gmx.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Athlon PSE/AGP Bug
In-Reply-To: <1011737673.10474.12.camel@psuedomode>
		<c5qr4uk3adm53fgvuibld2tnjtnfnq0a5i@4ax.com>
		<5.1.0.14.0.20020123112137.009ef8b0@mail.amc.localnet> <20020123.022054.884034824.rene.rebe@gmx.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Rebe wrote:

> Here I only see one Athlon system crashing all the time. This is a
> 700Mhz Duron runnign in a Asus A7V. With a 2.4.16 kernel compiled with
> Athlon optimization all applications are crashing all time (sed, cc,
> gcc, sawfish - all. Simply sig-11), with a 2.4.4 kernel (using the
> same .config) it seem to run just fine. 4 passes of memtest86 showed
> no error, either ...
> 
> I see the broken via chips involved most of the time.
> 
> We will try a i386-only optimized kernel tomorrow.

Hmmm... i'm running a Thunderbird 800 on an A7V (not the A7V133) without
any major problems, with 2.4.17 and athlon optimized.
Of course i have the latest BIOS from Asus (1009), with earlier ones i
did have some AGP-related instabilities, with a GeForce2 GTS.
Of course i also flashed the GF2, just the combination of both things
solved my problems, though now my ASUS GF2 is a "generic nvidia" one.
I compiled on the same run a full XFree86 4.2.0 + GNOME 1.4 without
even one coredump / sig-11, and this is a FULLY compiled gnome.
I have 2 out of 3 dimm slots populated with 256+64 pc133 dimms,
el cheapo brand, and pass memtest86 without a hitch.
HDD is an issue... i got en masse corruption once, but then it's no
wonder with the good record IBM's 75GXP's have... (somehow traced
to ext3+unmask irq on). It corrupted beyond his limits, destroying
the windos partition data also. Now i'm with ext3 but without unmasking,
and got no corruption so far.
I'm using NVIDIA_kernel #2314 forced to AGP 4x w/ SBA & FW on,
though no serious 3D load beyond xscreensaver eyecandy, with no
problems whatsoever.
Distro is (kinda) redhat 7.2, everything compiled with gcc 2.96, EXCEPT
xfree that doesn't like it very much (which was compiled with 2.95.3).
