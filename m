Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279715AbRKIIfQ>; Fri, 9 Nov 2001 03:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279722AbRKIIfG>; Fri, 9 Nov 2001 03:35:06 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:522 "HELO mail.pha.ha-vel.cz")
	by vger.kernel.org with SMTP id <S279715AbRKIIex>;
	Fri, 9 Nov 2001 03:34:53 -0500
Date: Fri, 9 Nov 2001 09:34:50 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: george anzinger <george@mvista.com>, Jonas Diemer <diemer@gmx.de>,
        linux-kernel@vger.kernel.org
Subject: Re: VIA 686 timer bugfix incomplete
Message-ID: <20011109093450.A7676@suse.cz>
In-Reply-To: <3BEAF962.8E407C30@mvista.com> <E161ydI-000178-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E161ydI-000178-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Nov 08, 2001 at 11:30:52PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2001 at 11:30:52PM +0000, Alan Cox wrote:
> > Me thinks the real solution is the ACPI pm timer.  3 times the
> > resolution of the PIT and you can not stop it.  The high-res-timers
> > patch will allow you to use this as the time keeper and just use the PIT
> > to generate interrupts.
> 
> For awkward boxes you can use the PIT, for good boxes we can use rdtsc or
> eventually the ACPI timers when running with ACPI

The problem is that we use PIT even together with TSC because we need to
know how much time passed since last interrupt to be able to synchronize
the TSC with possibly delayed timer interrupts and TSC doesn't tell us
that ... but hopefully this can be done with some kind of PLL ...

-- 
Vojtech Pavlik
SuSE Labs
