Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268166AbUH2BnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268166AbUH2BnK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 21:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268158AbUH2BnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 21:43:10 -0400
Received: from dci.doncaster.on.ca ([66.11.168.194]:43662 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S268166AbUH2BnC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 21:43:02 -0400
From: Andrew Miklas <public@mikl.as>
Reply-To: public@mikl.as
To: Gianni Tedesco <gianni@scaramanga.co.uk>
Subject: Re: Linux Incompatibility List
Date: Sat, 28 Aug 2004 21:42:43 -0400
User-Agent: KMail/1.7
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <87r7q0th2n.fsf@dedasys.com> <200408250159.20606.public@mikl.as> <1093418493.18600.10.camel@sherbert>
In-Reply-To: <1093418493.18600.10.camel@sherbert>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart156251825.WiuWTpF0tG";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200408282143.05304.public@mikl.as>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart156251825.WiuWTpF0tG
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On August 25, 2004 03:21 am, Gianni Tedesco wrote:
<snip>
> Also I think that the pciproxy[0] technique currently offers a simpler
> solution. Analyzing the data produced is more akin to reverse
> engineering a network protocol than machine code. Reverse engineering
> protocols is much less 'copyright sensitive' than decompiling machine
> code and, I think, more easily shared.

(Sorry for the long delay...)

Yeah, we tried that at first too (actually, we were using Frank Cornelis' =
=20
patches to Bochs).  The problem with dumping all the PCI activity (even whi=
le=20
the interface isn't sending/receiving) is that there is a huge amount of da=
ta=20
to sift through.  Even capturing for just a for a few seconds generates=20
megabytes of data.  You also have to deal with various events (like the=20
watchdog timer) going off at random times and getting mixed in with the=20
send/receive data.  We also found DMA a little tricky too (ie. you need to=
=20
dump out any data that the chip will bus-master to itself to see how it is=
=20
structured).

Also, we figured it would cause problems for supporting the whole range of=
=20
devices that can be handled by the wl.o drivers.  For example, from looking=
=20
at the module, we can see that the driver will have somewhat different=20
behaviour according to exactly what MAC and radio chips are present, the=20
interface being used (ie. PCI, cardbus, etc.), the vendor, model number, an=
d=20
revision of the board itself, the contents of the ROM, etc.  We decided tha=
t=20
there was simply too many combinations to make the data capture approach=20
useful over the entire range of Broadcom hardware, unless you repeat the=20
process on every variation.


> Anyway, perhaps once I've had some time to make a little more progress
> we would be able to compare some notes?

Sure, let me know when you're ready.


=2D- Andrew

--nextPart156251825.WiuWTpF0tG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Key ID: EC3F6CCD (www.keyserver.net)

iD8DBQBBMTSpTHKGaOw/bM0RAvvlAJ9Gfw9BInED8HixHAR1E9hjvKsiEQCgmhNK
jKLbfJLQYEpRYSmklYQuqGM=
=jsIn
-----END PGP SIGNATURE-----

--nextPart156251825.WiuWTpF0tG--
