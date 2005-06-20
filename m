Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261337AbVFTREm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbVFTREm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 13:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbVFTREm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 13:04:42 -0400
Received: from ws6-4.us4.outblaze.com ([205.158.62.107]:65467 "HELO
	ws6-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261337AbVFTREi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 13:04:38 -0400
Message-ID: <42B6F723.50808@grimmer.com>
Date: Mon, 20 Jun 2005 19:04:35 +0200
From: Lenz Grimmer <lenz@grimmer.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-thinkpad@linux-thinkpad.org
CC: linux-kernel@vger.kernel.org
Subject: Re: [ltp] Re: IBM HDAPS Someone interested?
References: <20050620155720.GA22535@ucw.cz> <005401c575b3$5f5bba90$600cc60a@amer.sykes.com> <20050620163456.GA24111@ucw.cz>
In-Reply-To: <20050620163456.GA24111@ucw.cz>
X-Enigmail-Version: 0.91.0.0
OpenPGP: id=B27291F2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

let me add my 2 cents here, as I have been toying around with this idea,
too..

Vojtech Pavlik wrote:

> Indeed, but there is a zillion of different approaches to an A/D. I'm
> quite sure IBM have rolled their own directly on the mainboard.
> 
> The main question is on which bus and which address it lives and what
> is the programming interface. It's not something Analog Devices would
> know.
> 
> It can be on some monitoring chip living on the SMBus (most likely)
> or coupled directly to the ACPI bridge on PCI, or anywhere else in
> the system.

I tried monitoring the output of the embedded controller register dump
that the "ibm-acpi" kernel module provides, using the following command
and then moving the Laptop (Thinkpad T42) to trigger changes:

  watch -n1 cat /proc/acpi/ibm/ecdump

Alas, there wasn't really a pattern that convinced me that the chip
actually is monitored via this controller. But of course it may not harm
if somebody else double checks this.

> Well, some piece of software needs to park the HDD when the notebook
> is falling, and that piece of software should better be running since
> the notebook is powered on. Hence my suspicion it's in the BIOS. It
> doesn't have to be visible to the user, at all.

On Windows, you need to run a separate tray application that enables the
protection. So it seems like it's implemented in "userspace". It may be
worth debugging what this Window applet actually does...

Bye,
	LenZ
- --
- ------------------------------------------------------------------
 Lenz Grimmer <lenz@grimmer.com>                             -o)
 [ICQ: 160767607 | Jabber: LenZGr@jabber.org]                /\\
 http://www.lenzg.org/                                       V_V
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCtvciSVDhKrJykfIRAuhyAJ42vpQg/lnZiNVvskrHXtqaBxn9MQCeNfqO
HGrR0AmgZUR9gmn3S4biJsA=
=cOZT
-----END PGP SIGNATURE-----
