Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287215AbSACMfV>; Thu, 3 Jan 2002 07:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287212AbSACMfM>; Thu, 3 Jan 2002 07:35:12 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:2321 "HELO mail.pha.ha-vel.cz")
	by vger.kernel.org with SMTP id <S287206AbSACMe4>;
	Thu, 3 Jan 2002 07:34:56 -0500
Date: Thu, 3 Jan 2002 13:34:54 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: esr@thyrsus.com, David Woodhouse <dwmw2@infradead.org>,
        Dave Jones <davej@suse.de>, Lionel Bouton <Lionel.Bouton@free.fr>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
Message-ID: <20020103133454.A17280@suse.cz>
In-Reply-To: <20020103040924.B6936@thyrsus.com> <E16M6lk-00087l-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16M6lk-00087l-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Jan 03, 2002 at 12:14:47PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2002 at 12:14:47PM +0000, Alan Cox wrote:

> > You have my intentions backwards. What I'd like to be able to do is
> > suppress ISA_SLOTS when there are detectably *no* ISA cards.  Unfortunately
> > I have had it demonstrated that the DMI tables can give false negatives
> > (false positives would not have been a showstopper).
> 
> Thats why I also suggested using lspci and looking for an ISA bridge.
> If you have no PCI its probably ISA. If you have no PCI/ISA bridge its
> very very unlikely to be ISA

Uh, no. Almost all 486 PCI boards and early Pentium/K5/K6 boards have
the PCI bus hanging of the VLB or other local bus, and on those ISA
isn't behind an ISA bridge. These chipsets do have ISA but no ISA
bridge.

To name one example: VIA Apollo Master, vt82c570 chipset has only Host
Bridge and IDE Controller visible on the PCI bus.

-- 
Vojtech Pavlik
SuSE Labs
