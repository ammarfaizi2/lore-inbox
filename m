Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261411AbREMOjd>; Sun, 13 May 2001 10:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261410AbREMOjW>; Sun, 13 May 2001 10:39:22 -0400
Received: from smtp3.libero.it ([193.70.192.53]:24317 "EHLO smtp3.libero.it")
	by vger.kernel.org with ESMTP id <S261408AbREMOjF>;
	Sun, 13 May 2001 10:39:05 -0400
Message-ID: <3AFE9C7F.6081665B@alsa-project.org>
Date: Sun, 13 May 2001 16:38:55 +0200
From: Abramo Bagnara <abramo@alsa-project.org>
Organization: Opera Unica
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i586)
X-Accept-Language: it, en
MIME-Version: 1.0
To: Jes Sorensen <jes@sunsite.dk>
CC: "David S. Miller" <davem@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: unsigned long ioremap()?
In-Reply-To: <3AF10E80.63727970@alsa-project.org> <Pine.LNX.4.05.10105030852330.9438-100000@callisto.of.borg> <15089.979.650927.634060@pizda.ninka.net> <11718.988883128@redhat.com> <3AF12B94.60083603@alsa-project.org> <15089.63036.52229.489681@pizda.ninka.net> <3AF25700.19889930@alsa-project.org> <d37kzltkky.fsf@lxplus015.cern.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen wrote:
> 
> >>>>> "Abramo" == Abramo Bagnara <abramo@alsa-project.org> writes:
> 
> Abramo> "David S. Miller" wrote:
> >> One final point, I want to reiterate that I believe:
> >>
> >> foo = readl(&regs->bar);
> >>
> >> is perfectly legal and should not be discouraged and in particular,
> >> not made painful to do.
> 
> Abramo> I disagree: regs it's not a dereferenceable thing and I think
> Abramo> it's an abuse of pointer type. You're keeping a pointer that
> Abramo> need a big sign on it saying "Don't dereference me", it's a
> Abramo> mess.
> 
> Thats complete rubbish, in many cases the regs structure matches a
> regs structure seen by another CPU on the other side of the PCI bus
> (ie. the firmware case). There is nothing wrong with the above
> approach as long as you keep in mind that you cannot dereference the
> struct without using readl and you have to make sure to explicitly do
> padding in the struct (not all CPUs guarantee the same natural
> alignment).

"As long as you handle with gloves thick enough such a shit, there's no
problems.."

-- 
Abramo Bagnara                       mailto:abramo@alsa-project.org

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy

ALSA project               http://www.alsa-project.org
It sounds good!
