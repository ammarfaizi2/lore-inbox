Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287283AbSALSgN>; Sat, 12 Jan 2002 13:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287293AbSALSgC>; Sat, 12 Jan 2002 13:36:02 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:46096 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287283AbSALSft>; Sat, 12 Jan 2002 13:35:49 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
To: zippel@linux-m68k.org (Roman Zippel)
Date: Sat, 12 Jan 2002 18:46:52 +0000 (GMT)
Cc: yodaiken@fsmlabs.com, landley@trommello.org (Rob Landley),
        rml@tech9.net (Robert Love), alan@lxorguk.ukuu.org.uk (Alan Cox),
        nigel@nrg.org, akpm@zip.com.au (Andrew Morton),
        linux-kernel@vger.kernel.org
In-Reply-To: <3C4023A2.8B89C278@linux-m68k.org> from "Roman Zippel" at Jan 12, 2002 12:53:06 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16PTB7-0002rC-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >         Hey my DVD player has stalled, lets add sem_with_revolting_priority_trick!
> >         Why the hell is UP Windows XP3 blowing away my Linux box on DVD playing while
> >         Linux now runs with the grace and speed of IRIX?
> 
> Because the IRIX implementation sucks, every implementation has to suck?
> Somehow I have the suspicion you're trying to discourage everyone from
> even trying, because if he'd succeeded you'd loose a big chunk of
> potential RTLinux customers.

Victor has had the same message for years, as have others like Larry McVoy
(in fact if Larry and Victor agree on something its unusual enough to
 remember). So I can vouch for the fact Victor hasn't changed his tune from
before rtlinux was ever any real commercial toy. I think you owe him an
apology.

Now rtlinux and low latency in the main kernel are two different things. One
gives you effectively a small embedded system to program for which talks
to Linux. From that you draw extremely reliable behaviour and very bounded
delay times. Its small enough you can validate it too

RtLinux isn't going to help you one bit when it comes to smooth movie playback 
because the DVD playback is dependant on the Linux file system layers and a
whole pile of other code. Low-latency does this quite nicely, and it takes
you to the point where hardware becomes the biggest latency cause for the
general case. Pre-empt doesn't buy you anything more. You can spend a
millisecond locked in an I/O instruction to an irritating device.

Alan
