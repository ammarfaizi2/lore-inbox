Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287055AbSABWNO>; Wed, 2 Jan 2002 17:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287027AbSABWMz>; Wed, 2 Jan 2002 17:12:55 -0500
Received: from ns.suse.de ([213.95.15.193]:5388 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S287022AbSABWMp>;
	Wed, 2 Jan 2002 17:12:45 -0500
Date: Wed, 2 Jan 2002 23:12:44 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: "Eric S. Raymond" <esr@thyrsus.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <20020102164757.A16976@thyrsus.com>
Message-ID: <Pine.LNX.4.33.0201022305090.427-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jan 2002, Eric S. Raymond wrote:

> > > Consider the lives of people administering large server farms or
                            ^^^^^^^^^^^^^^^^^^^^
> > > clusters.  Their hardware is not necessarily homogenous, and the
> > > ability to query the DMI tables on the fly could be useful both
> > > for administration and automatic process migration.
> > Given that 'dmidecode' works fine in those circumstances, that's still
> > not a convincing argument imo.
> But only for people and programs with root privileges.
               ^^^^^^
Someone building a new kernel for a box (ie administrator) will have
root priveledges. Though running 'make guessconfig' or whatever as
root would suck.

What Alan suggests (ripping the necessary bits out of dmidecode
and making a setuid program) sounds better, as long as someone
audits it afterwards.

> then, on whether we want to insist that all software doing hardware
> probing must have root privileges to function.

probing isa isn't pretty. which is why we don't have anything
as nice as /proc/bus/pci. The pnpbios support goes a little towards
this, but only detects PNP cards obviously. Ye olde ISA is all but
invisible to /proc

As we get the devicefs in 2.5 fleshed out, hopefully such things will
come in time for the older busses like PNPISA & EISA

> There is already stuff in /proc that seems to be there for precisely this
> reason.  So /proc/dmi would hardly be a violation of norms.

Just because its a shitbucket, doesn't mean we should keep adding to it.
It's become the dumping ground for so much crap that just doesn't need to
be there.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

