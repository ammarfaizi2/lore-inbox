Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267178AbTAGOkY>; Tue, 7 Jan 2003 09:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267392AbTAGOkY>; Tue, 7 Jan 2003 09:40:24 -0500
Received: from hoochie.digium.com ([216.207.245.2]:22715 "EHLO
	hoochie.digium.com") by vger.kernel.org with ESMTP
	id <S267178AbTAGOkX>; Tue, 7 Jan 2003 09:40:23 -0500
Date: Tue, 7 Jan 2003 08:49:01 -0600 (CST)
From: Mark Spencer <markster@digium.com>
X-X-Sender: <markster@hoochie>
To: Asterisk mailing list <asterisk@marko.net>
cc: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [Asterisk] DTMF noise
In-Reply-To: <200301071455.32489.roy@karlsbakk.net>
Message-ID: <Pine.LNX.4.33.0301070848100.28779-100000@hoochie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The DTMF detector in the linux kernel is fairly simplistic and doesn't do
many relative energy tests.  The Zapata library has a much better tone
detector, but it is FP, and so would have to be made fixed point.  If
nothing else, it may provide some lessons for the ISDN folks.

Mark

On Tue, 7 Jan 2003, Roy Sigurd Karlsbakk wrote:

> hi
>
> when dialing out from the D-link MGCP phone (they actually work now - most of
> the time), I get lots of DTMF noise whenever the other person talks. I only
> get this from the MGCP phone - not with MSN messenger. This seems to be an
> error in isdn4linux falsely detecting DTMF in speech with Asterisk creating
> the actual noise.
>
> This testing has been done on hhe following cards (from lspci)
>
> 02:09.0 Network controller: Cologne Chip Designs GmbH ISDN network controller
> [HFC-PCI] (rev 02)
> 02:0a.0 Network controller: Cologne Chip Designs GmbH ISDN network controller
> [HFC-PCI] (rev 02)
> 02:0b.0 Network controller: Cologne Chip Designs GmbH ISDN network controller
> [HFC-PCI] (rev 02)
>
> roy
>
> --
> Roy Sigurd Karlsbakk, Datavaktmester
> ProntoTV AS - http://www.pronto.tv/
> Tel: +47 9801 3356
>
> Computers are like air conditioners.
> They stop working when you open Windows.
>

