Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284580AbSADTWL>; Fri, 4 Jan 2002 14:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288726AbSADTWB>; Fri, 4 Jan 2002 14:22:01 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:10505 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S284580AbSADTVy>; Fri, 4 Jan 2002 14:21:54 -0500
Date: Fri, 4 Jan 2002 20:21:51 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: "Eric S. Raymond" <esr@thyrsus.com>,
        "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        David Woodhouse <dwmw2@infradead.org>, Dave Jones <davej@suse.de>,
        Lionel Bouton <Lionel.Bouton@free.fr>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
Message-ID: <20020104202151.A22445@suse.cz>
In-Reply-To: <20020103133454.A17280@suse.cz> <Pine.GSO.3.96.1020104191141.829B-100000@delta.ds2.pg.gda.pl> <20020104200410.E21887@suse.cz> <20020104140538.A19746@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020104140538.A19746@thyrsus.com>; from esr@thyrsus.com on Fri, Jan 04, 2002 at 02:05:38PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2002 at 02:05:38PM -0500, Eric S. Raymond wrote:
> Vojtech Pavlik <vojtech@suse.cz>:
> > And of course, there will be a huge amount of false positives, because
> > all the new chipsets have an ISA bridge built into the southbridge chip
> > and it is there even when no ISA slots are present.
> 
> Yeah.  That's what makes the lspci approach unusable for my purposes.
> 
> The approach I want to take is this:
> 
> 1. Get guaranteed access to the DMI data, either via a /{proc,sys}/dmi
>    or /var/run/dmi initialized at boot time.
> 
> 2. Develop an exception list of mobos that have ISA slots that don't
>    show up under DMI.
> 
> My logic would then be: if the box has PCI, and DMI shows no ISA slots,
> and the motherboard is not on the exception list, then suppress ISA 
> questions.
> 
> This would be a kluge, but it would have the advantage that the exception
> list is finite and can be expected to stop growing.

You'll have to add motherboards that have no ISA slots, but onboard ISA
devices to the list.

I'd suggest looking at the output of /proc/bus/isapnp as well, because
if it lists any devices, you certainly need ISA support. 

-- 
Vojtech Pavlik
SuSE Labs
