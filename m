Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbVF0Ov3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbVF0Ov3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 10:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261722AbVF0OsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 10:48:11 -0400
Received: from ws6-4.us4.outblaze.com ([205.158.62.107]:58822 "HELO
	ws6-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262107AbVF0Mdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:33:44 -0400
Message-ID: <42BFF220.2060704@grimmer.com>
Date: Mon, 27 Jun 2005 14:33:36 +0200
From: Lenz Grimmer <lenz@grimmer.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-thinkpad@linux-thinkpad.org
CC: Alejandro Bonilla <abonilla@linuxwireless.org>,
       Pavel Machek <pavel@suse.cz>, Paul Sladen <thinkpad@paul.sladen.org>,
       Eric Piel <Eric.Piel@tremplin-utc.net>, borislav@users.sourceforge.net,
       "'Yani Ioannou'" <yani.ioannou@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [ltp] IBM HDAPS Someone interested? (Accelerometer)
References: <1119559367.20628.5.camel@mindpipe> <Pine.LNX.4.21.0506250712140.10376-100000@starsky.19inch.net> <20050625144736.GB7496@atrey.karlin.mff.cuni.cz> <20050625150030.GA1636@ucw.cz> <42BD9F1E.5090407@linuxwireless.org> <20050625201442.GB1591@ucw.cz>
In-Reply-To: <20050625201442.GB1591@ucw.cz>
X-Enigmail-Version: 0.91.0.0
OpenPGP: id=B27291F2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

Vojtech, thanks for the great description.

Vojtech Pavlik wrote:

> Every PC has a small microprocessor on the mainboard, descended from
> the ancient Intel i8042. It is primarily intended to take care of
> the keyboard and mouse, but in notebooks the input functionality is 
> overshadowed by other uses.
> 
> Those often include: Battery monitoring and communication, display 
> backlight control, power on/off, and similar stuff.
> 
> It is usually accessible through ACPI, and ACPI calls it the EC - 
> embedded controller. ACPI doesn't mandate the EC to be the 8042, they
>  could be separate, but for cost reasons, they usually are the same 
> chip.
> 
> Since the 8042 is the chip where you attach stuff that no other chip 
> wants, it's probably the primary choice for connecting the ADXL 
> output.
> 
> A small problem is that the 8042 normally doesn't have any ADCs, 
> however, I assume most of the 8042 implementations in modern 
> notebooks do have at least a few ADCs, for battery monitoring, etc.

Hmm, but isn't that exactly the kind of data that is printed by the
ibm_acpi kernel module in "/proc/acpi/ibm/ecdump" then?

According to the README "this feature dumps the values of 256 embedded
controller registers." So shouldn't the reading of the accelerometers
be included in these values as well?

Or could this mean that the embedded controller might have more than
these 256 registers that could be read out? Or does it need to be "told"
to poll the accelerometer for these values repeatedly?

Many register values in there change automatically (e.g. fan speed), but
so far we have not seen a pattern of register value changes that look
like they are related to acceleration of the laptop in any direction.

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

iD8DBQFCv/IeSVDhKrJykfIRAokmAJ45VnDjUXgopPJrlatdXs1DXoArqACfaJKD
sQgfJr0mZ0JLmypk7HmfxYk=
=qcpP
-----END PGP SIGNATURE-----
