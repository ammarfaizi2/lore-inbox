Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291519AbSBHKBv>; Fri, 8 Feb 2002 05:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291522AbSBHKBm>; Fri, 8 Feb 2002 05:01:42 -0500
Received: from dns.uni-trier.de ([136.199.8.101]:20930 "EHLO
	rzmail.uni-trier.de") by vger.kernel.org with ESMTP
	id <S291519AbSBHKBd>; Fri, 8 Feb 2002 05:01:33 -0500
Date: Fri, 8 Feb 2002 11:01:19 +0100 (CET)
From: Daniel Nofftz <nofftz@castor.uni-trier.de>
X-X-Sender: nofftz@hades.uni-trier.de
To: Wayne Whitney <whitney@math.berkeley.edu>
cc: Rasmus =?iso-8859-1?Q?B=F8g?= Hansen <moffe@amagerkollegiet.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: status on northbridge disconnection apm saving?
In-Reply-To: <200202071633.g17GXuX01867@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
Message-ID: <Pine.LNX.4.40.0202081053570.7911-100000@hades.uni-trier.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Feb 2002, Wayne Whitney wrote:

> I have an ASUS A7V (KT133) motherboard, BIOS 1009, with Athlon 100MHz
> (100MHz FSB).  I also find that if the PCI Master Read Caching is
> disabled in the BIOS, then the amd_disconnect kills audio playback (it
> sounds like molasses or something).  There are actually three related
> BIOS options on this motherboard:
>
> System Performance:		Optimal or Normal
> PCI Master Read Caching:	Enabled or Disabled
> PCI Delayed Transaction:	Enabled or Disabled
>
> This System Performance option is a sort of master option, setting it
> to normal forces the other two to disabled.
>
> Anyway, below are some diffs of the output of "lspci -s 0:0 -xxx".
> What is surprising to me is that setting the PCI Master Read Caching
> to Disabled changes the Northbridge settings in a way that is a
> superset of just setting PCI Delayed Transaction to Disabled.
>
> Hope this helps.
>
> Cheers, Wayne

of cause this helps ... thank you :)
we know now, that there are pci setting which affect the behavior in
relation fot audio playback.
as far as i know on some boards it could be, that the system bus hangs for
a short time, when the cpu is reconnected after a disconnect. it looks
like some caching for the pci bus could "cure" the sound skips which
happens when the system bus hangs for a short time.
so everyone who has problems with his audio and vidio playback while the
diconnect patch is active should look at his bios settings ... maybe he
could activate this pci master read cashing and his problems went away.

hmmm ... by the way: i could not reproduce your experiences, cause i have
no bios siwtch for pci master read cashing ...

oh ... and the pci delayed transaction could be dangerous on older via
chipsets cause the famous soutbridge bug in combination with an sound
blaster card. so be carefull if you have a sound blaster live  ....

daniel



# Daniel Nofftz
# Sysadmin CIP-Pool Informatik
# University of Trier(Germany), Room V 103
# Mail: daniel@nofftz.de

