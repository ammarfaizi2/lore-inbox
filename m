Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135248AbQL3SXv>; Sat, 30 Dec 2000 13:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132865AbQL3SXm>; Sat, 30 Dec 2000 13:23:42 -0500
Received: from p3EE3C958.dip.t-dialin.net ([62.227.201.88]:11780 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S135301AbQL3SX3>; Sat, 30 Dec 2000 13:23:29 -0500
Date: Sat, 30 Dec 2000 18:34:14 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Evan Thompson <evaner@bigfoot.com>, linux-kernel@vger.kernel.org
Subject: Re: VIA IDE controller strangeness (2.4.0-test12/test13-pre5)
Message-ID: <20001230183414.C1950@emma1.emma.line.org>
Mail-Followup-To: Evan Thompson <evaner@bigfoot.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20001229185923.A477@evaner.penguinpowered.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001229185923.A477@evaner.penguinpowered.com>; from evaner@bigfoot.com on Fri, Dec 29, 2000 at 18:59:23 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Dec 2000, Evan Thompson wrote:

> ---(CC answer please)---

To: should be fine as well, I assume.

> I'm having a strange problem with my IDE controller.  I believe (and
> that's what Windows and the m/b manufaturer -- PC Chips -- say) that I
> have a VIA PCI BusMaster IDE controller, and I've had some strange
> history with it.  I've asked many people before on various help
> services, and I was able to fix my problem with the 2.2 series, but
> now my fix does not work.
> 
> THE PROBLEM: ------------
> 
> Ever since the 2.2 kernel series (I remeber this working properly in
> 2.0.36, without the conflicts), I would get hdc: lost interrupt during
> boot up, and my system would take bloody ages to boot up and load a
> CD.  I tracked it down to a strange IRQ conflict in which Linux would
> try to assign both the primary and secondary IDE channels IRQ 14,
> causing IRQ conflicts galore.  I was able to fix this by giving the
> kernel
> 
> ide1=0x170,0x376,15
> 
> at boot time.  This has worked for 2.2.12-.17 and Alan's 2.2.18pre21
> (I haven't compiled the official 2.2.18 yet, but I'm sure it will
> work).

Could you report the chip set type and revision? Quote the corresponding
parts from the "lspci -v" output, please. I've been using PC Chips main
boards with VIA chip sets without IDE difficulties ever since I bought
one of those in fall 1998. (VIA Apollo MVP3 AGP, VT82C598 + VT82C586
north+south bridges), both PC Chips M577 and Tyan Trinity S1590S.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
