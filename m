Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270247AbRHMPVe>; Mon, 13 Aug 2001 11:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270250AbRHMPVY>; Mon, 13 Aug 2001 11:21:24 -0400
Received: from [65.100.125.89] ([65.100.125.89]:62962 "EHLO golux.thyrsus.com")
	by vger.kernel.org with ESMTP id <S270247AbRHMPVO>;
	Mon, 13 Aug 2001 11:21:14 -0400
Date: Mon, 13 Aug 2001 11:18:50 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: S2464 (K7 Thunder) hangs -- some lessons learned
Message-ID: <20010813111850.D21008@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20010812212430.A9300@thyrsus.com> <E15WGvO-0007Ig-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15WGvO-0007Ig-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Aug 13, 2001 at 01:34:30PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk>:
> > Alas, the 2.4.8+ emu10k1 driver does not completely banish the K7 Thunder
> > lockups problem.  It makes them a lot rarer, though, and enabled us to get
> > to the next level of diagnosis.
> 
> What version of the chipset do you have. The current ones can hang
> the PCI bus during IDE transfers if you have IDE read/write prefetch
> enabled in the bios setup.

I don't know what version we have.  Is there a way to query it through /proc?

We have IDE disabled in the BIOS, so we're not likely to see this bug.

> It also has problems with the APIC implementation where an IRQ masked in
> the APIC re-occurs which can hang the system. Worrying this one is marked
> 'nofix'. You might want to trying running "noapic"

I'll bear that in mind if the lockups recur.  I'll copy this to Gary, who
might find himself building IDE systems around this board.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"America is at that awkward stage.  It's too late to work within the system,
but too early to shoot the bastards."
	-- Claire Wolfe
