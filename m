Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264923AbTLFB6K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 20:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264925AbTLFB6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 20:58:10 -0500
Received: from c-130372d5.012-136-6c756e2.cust.bredbandsbolaget.se ([213.114.3.19]:51087
	"EHLO pomac.netswarm.net") by vger.kernel.org with ESMTP
	id S264923AbTLFB6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 20:58:04 -0500
Subject: Re: Catching NForce2 lockup with NMI watchdog - found?
From: Ian Kumlien <pomac@vapor.com>
To: linux-kernel@vger.kernel.org
Cc: cbradney@zip.com.au, prakashpublic@gmx.de, cheuche+lkml@free.fr
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-3AJBsgs5FhOM6CP+BVR6"
Message-Id: <1070675882.1991.7.camel@big.pomac.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 06 Dec 2003 02:58:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3AJBsgs5FhOM6CP+BVR6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Quoting myself...=20
> I'm more hopeful about the patch from Mathieu <cheuche+lkml () free ! fr>=
...

>           CPU0
>   0:     267486    IO-APIC-edge  timer
>   1:       9654    IO-APIC-edge  keyboard
>   2:          0          XT-PIC  cascade
>   8:          1    IO-APIC-edge  rtc
>   9:          0   IO-APIC-level  acpi
>  14:      28252    IO-APIC-edge  ide0
>  15:        103    IO-APIC-edge  ide1
>  16:     251712   IO-APIC-level  eth0
>  17:      90632   IO-APIC-level  EMU10K1
>  19:     415529   IO-APIC-level  nvidia
>  20:          0   IO-APIC-level  usb-ohci
>  21:        153   IO-APIC-level  ehci_hcd
>  22:      58257   IO-APIC-level  usb-ohci
> NMI:        479
> LOC:     265875
> ERR:          0
> MIS:          0

> this far and it feels like a closer match to what windows does from what
> i have read on the ml.=20

I think that this is what we want, ie know how windows handles the spic
since i just bet that all the mb manuf. ppl only care about windows and
anything else is secondary. [Can we get some more info from nvidia about
differences in the setup?]

> I haven't even come close to testing this yet, I've only been up 45 mins
> but i'll leave it running and do what i usually do when it hangs... =3D)

And that some great 2 hours, everything was dandy, screen refreshes
faster (moving windows with contents was snappier and you saw less
trailing refreshes)... but it ended in a beeeeeeeep deadlock.

I later reproduced it again in console mode... It required 2 full grep
-rne test * in my /usr/src, that is, 2.6.0-test11 and 2.4.23*2 + some
rpm's... all in all: 624M + 219M

--=20
Ian Kumlien <pomac@vapor.com>

--=-3AJBsgs5FhOM6CP+BVR6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/0Teq7F3Euyc51N8RAjEVAKCWbw2ZpZP/CcxSCFFtusdKnO9KhwCfSkZe
BPl0skqFCdO/Vut0DfkLW/M=
=5EuJ
-----END PGP SIGNATURE-----

--=-3AJBsgs5FhOM6CP+BVR6--

