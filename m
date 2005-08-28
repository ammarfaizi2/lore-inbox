Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbVH1HoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbVH1HoV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 03:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbVH1HoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 03:44:21 -0400
Received: from ns1.osuosl.org ([140.211.166.130]:9621 "EHLO ns1.osuosl.org")
	by vger.kernel.org with ESMTP id S1750803AbVH1HoU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 03:44:20 -0400
Message-ID: <43116B45.1030702@engr.orst.edu>
Date: Sun, 28 Aug 2005 00:44:05 -0700
From: Michael Marineau <marineam@engr.orst.edu>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050728)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nishanth Aravamudan <nacc@us.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, benh@kernel.crashing.org,
       Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Radeon acpi vgapost
References: <43111298.80507@engr.orst.edu> <20050828051225.GA4225@us.ibm.com>
In-Reply-To: <20050828051225.GA4225@us.ibm.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig25B8D574476E0B69467C0E7B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig25B8D574476E0B69467C0E7B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Nishanth Aravamudan wrote:
> On 27.08.2005 [18:25:44 -0700], Michael Marineau wrote:
> 
>>Thses patches resume ATI radeon cards from acpi S3 suspend when using
>>radeonfb by reposting the video bios. This is needed to be able to use
>>S3 when the framebuffer is enabled.
> 
> 
> Just wanted to report that these patches lead to progress on my T41p;
> relevant lspci -vvv:
> 
> 0000:01:00.0 VGA compatible controller: ATI Technologies Inc M10 NT [FireGL Mobility T2] (rev 80) (prog-if 00 [VGA])
> 	Subsystem: IBM: Unknown device 054f
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B+
> 	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 66 (2000ns min), Cache Line Size: 0x08 (32 bytes)
> 	Interrupt: pin A routed to IRQ 11
> 	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
> 	Region 1: I/O ports at 3000 [size=256]
> 	Region 2: Memory at c0100000 (32-bit, non-prefetchable) [size=64K]
> 	Capabilities: <available only to root>
> 
> In 2.6.13-rc7 or 2.6.13-rc6-mm2, after echo mem > /sys/power/state, the
> lcd light comes back, but no video is actually displayed (I just notice
> that the backlight turns on). With your patches, I now see (with either
> rc7 or rc6-mm2) a mostly black screen with "inux" in the upper left --
> basically a garbled console -- which slowly turns completely white.

I've seen the "inux" thing in the past, but by pressing a key shortly
after the screen turns back on the system continued to resume as usual.
 Given that the backlight normally turns back on for you maybe this post
method isn't the correct solution for your card. Mine wouldn't even turn
on the backlight.

> 
> If you would like me to do more debugging, I would be more than happy to
> do so.

What is the behaviour when the framebuffer is not enabled? If in that
case it doesn't work out of the box, does it work with a userspace trick
like vbetool?

-- 
Michael Marineau
marineam@engr.orst.edu
Oregon State University

--------------enig25B8D574476E0B69467C0E7B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDEWtFiP+LossGzjARAvnhAKDHNNl8vAH9En+YYrbCjM/FknO2UACgta52
uF9wG8FH+kBH41f2MUV3J20=
=M6a6
-----END PGP SIGNATURE-----

--------------enig25B8D574476E0B69467C0E7B--
