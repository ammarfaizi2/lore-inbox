Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288689AbSADTEj>; Fri, 4 Jan 2002 14:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288712AbSADTET>; Fri, 4 Jan 2002 14:04:19 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:3337 "HELO mail.pha.ha-vel.cz")
	by vger.kernel.org with SMTP id <S288689AbSADTEO>;
	Fri, 4 Jan 2002 14:04:14 -0500
Date: Fri, 4 Jan 2002 20:04:10 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, esr@thyrsus.com,
        David Woodhouse <dwmw2@infradead.org>, Dave Jones <davej@suse.de>,
        Lionel Bouton <Lionel.Bouton@free.fr>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
Message-ID: <20020104200410.E21887@suse.cz>
In-Reply-To: <20020103133454.A17280@suse.cz> <Pine.GSO.3.96.1020104191141.829B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1020104191141.829B-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Fri, Jan 04, 2002 at 07:28:58PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2002 at 07:28:58PM +0100, Maciej W. Rozycki wrote:

> > > Thats why I also suggested using lspci and looking for an ISA bridge.
> > > If you have no PCI its probably ISA. If you have no PCI/ISA bridge its
> > > very very unlikely to be ISA
> > 
> > Uh, no. Almost all 486 PCI boards and early Pentium/K5/K6 boards have
> > the PCI bus hanging of the VLB or other local bus, and on those ISA
> > isn't behind an ISA bridge. These chipsets do have ISA but no ISA
> > bridge.
> 
>  These can be checked for explicitly as the list isn't likely to grow.  I
> can dig a few Intel docs for IDs of 486-class PCI chipsets that have no
> PCI-ISA bridge if they'd be useful.
> 
>  Also note that there are PCI-ISA bridges that are reported as "non-VGA
> unclassified" devices as they predate PCI 2.0.  The SIO (82378IB/ZB) comes
> to mind here.  The bridge is used in certain models of Alpha systems as
> well.  The bridges would need to be listed by IDs, too. 

And of course, there will be a huge amount of false positives, because
all the new chipsets have an ISA bridge built into the southbridge chip
and it is there even when no ISA slots are present.

-- 
Vojtech Pavlik
SuSE Labs
