Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289484AbSBZX7U>; Tue, 26 Feb 2002 18:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289813AbSBZX7M>; Tue, 26 Feb 2002 18:59:12 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:65285 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S289484AbSBZX67>;
	Tue, 26 Feb 2002 18:58:59 -0500
Date: Wed, 27 Feb 2002 10:56:25 +1100
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sven Koch <haegar@sdinet.de>, linux-kernel@vger.kernel.org
Subject: Re: Problems with orinoco_cs and i810_audio
Message-ID: <20020226235625.GM9850@zax>
Mail-Followup-To: David Gibson <hermes@gibson.dropbear.id.au>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Sven Koch <haegar@sdinet.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.40.0202261314260.695-100000@space.comunit.de> <E16fh0g-0000XD-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16fh0g-0000XD-00@the-village.bc.nu>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2002 at 12:47:10PM +0000, Alan Cox wrote:
> > Feb 26 13:13:40 aurora kernel: i810_audio: only 48Khz playback available.
> > Feb 26 13:13:40 aurora kernel: i810_audio: AC'97 codec 0 supports AMAP,
> > total ch annels = 2
> > Feb 26 13:13:40 aurora kernel: ac97_codec: AC97 Modem codec, id:
> > 0x5349:0x4c27 (Unknown)
> > Feb 26 13:13:50 aurora kernel: i810_audio: timed out waiting for codec 1
> > analog
> 
> Ok the codec timeout I fixed in -ac but it isnt related to your other 
> problem.
> 
> > with ZV Support, Toshiba America Info Systems ToPIC95 PCI to Cardbus
> > Bridge with ZV Support (#2), usb-uhci, usb-uhci, orinoco_cs, Intel ICH2
> 
> Exclude IRQ11 in your /etc/pcmcia/config - the orinoco card probably isnt
> going to like sharing if its pcmcia not cardbus

In theory we can share.  Maybe.  There is some evidence of a firmware
bug which means we can get interrupts without status bits being set
properly.  If this is so, then sharing will be very difficult.  At the
moment the "Null event" message is in there to help track this down -
with the side effect that sharing is not possible - at least not
without dealing with thousands of "Null event" messages.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

