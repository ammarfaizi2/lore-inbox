Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273463AbRJIH2z>; Tue, 9 Oct 2001 03:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273487AbRJIH2p>; Tue, 9 Oct 2001 03:28:45 -0400
Received: from atlas15.dnp.fmph.uniba.sk ([158.195.25.215]:48007 "EHLO
	melkor.dnp.fmph.uniba.sk") by vger.kernel.org with ESMTP
	id <S273463AbRJIH2d>; Tue, 9 Oct 2001 03:28:33 -0400
Date: Tue, 9 Oct 2001 09:28:58 +0200
From: Radovan Garabik <garabik@melkor.dnp.fmph.uniba.sk>
To: Guest section DW <dwguest@win.tue.nl>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] dead keys in unicode console mode
Message-ID: <20011009092858.A15708@melkor.dnp.fmph.uniba.sk>
In-Reply-To: <20011008215313.A11879@melkor.dnp.fmph.uniba.sk> <20011009041618.A6135@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011009041618.A6135@win.tue.nl>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2001 at 04:16:18AM +0200, Guest section DW wrote:
> On Mon, Oct 08, 2001 at 09:53:13PM +0200, Radovan Garabik wrote:
> > FWIW, this little patch makes it possible to
> > use dead keys in unicode console mode.
> > It is against 2.4.10, but should apply cleanly in
> > broader range of kernel versions.
> 
> >  struct kbdiacr {
> > -        unsigned char diacr, base, result;
> > +        unsigned char diacr, base;
> > +        unsigned short int result; /* holds UCS2 value */
> >  };
> 
> And now all existing binaries that use the KDGKBDIACR ioctl
> dump core? And all existing binaries that use the KDSKBDIACR
> ioctl do very strange things?

well, of course, existing binaries need to be recompiled,
that's what sources are for...
(and because unsigned char is subset of unsigned short, 
often they do not need to be even modified - btw how many
such binaries are there except of consoletools?)

> 
> If you want to do something like this, a new ioctl and a new
> structure are necessary. If you design something new, keep

More like complete redesign of console driver would be needed.
that is what linuxconsole.sf.net tries to do

> examples like Vietnamese in mind (with several accents on
> one symbol). We do support that now in the 8-bit world,

Think about someone who wants to use Vietnamese and Slovak
together (or Slovak and Russian as I need. Or Slovak, Lithuanian
and Russian - as one my friend needs. Or French and Hungarian as 
other friend of mine needs. Or any other combination from 
different ISO-8859 worlds). I converted my linux installation
almost completely to using UTF-8, and this (dead keys) was
a full stop, and I could forget about UTF-8.

> but complete support of the 16-bit world still requires
> some work. (And in the meantime Unicode has already gone beyond.)
> 

I do not argue.

-- 
 -----------------------------------------------------------
| Radovan Garabik http://melkor.dnp.fmph.uniba.sk/~garabik/ |
| __..--^^^--..__    garabik @ melkor.dnp.fmph.uniba.sk     |
 -----------------------------------------------------------
Antivirus alert: file .signature infected by signature virus.
Hi! I'm a signature virus! Copy me into your signature file to help me spread!
