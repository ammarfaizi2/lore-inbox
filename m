Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265982AbUBJQ4V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 11:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266019AbUBJQxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 11:53:52 -0500
Received: from fep02.swip.net ([130.244.199.130]:33933 "EHLO
	fep02-svc.swip.net") by vger.kernel.org with ESMTP id S266005AbUBJQxY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 11:53:24 -0500
Message-ID: <40290A41.3030309@free.fr>
Date: Tue, 10 Feb 2004 17:43:45 +0100
From: Jean-Luc Fontaine <jfontain@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, ja
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2: i2c erroneous temperatures from sensors
References: <4027D2E6.7070706@free.fr>
In-Reply-To: <4027D2E6.7070706@free.fr>
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

|
| On my SIS based motherboard:
| ...
| I get:
| # sensors
| w83697hf-isa-0290
|...

May thanks to all who responded: the temperatures indeed needed being
divided by 10, and it looks like lm_sensors 2.8.4 fixed it as shipped:

$ sensors
w83697hf-isa-0290
Adapter: ISA adapter
VCore:     +1.62 V  (min =  +0.06 V, max =  +0.03 V)
+3.3V:     +3.31 V  (min =  +0.14 V, max =  +0.00 V)
+5V:       +5.08 V  (min =  +0.11 V, max =  +0.00 V)
+12V:     +11.92 V  (min =  +1.22 V, max =  +9.73 V)
- -12V:      +1.13 V  (min =  -4.22 V, max =  -4.38 V)
- -5V:       +2.09 V  (min =  -7.71 V, max =  -7.71 V)
V5SB:      +5.62 V  (min =  +5.43 V, max =  +0.27 V)
VBat:      +0.06 V  (min =  +0.03 V, max =  +1.28 V)
fan1:     2721 RPM  (min =   -1 RPM, div = 2)
fan2:        0 RPM  (min = 168750 RPM, div = 2)
temp1: +28°C (high =+40°C, hyst = +12°C) sensor = thermistor
temp2: +34.0°C (high = +120°C, hyst = +120°C) sensor = thermistor

The only thing I am missing now is the RPMs of fan #2 (available in the
BIOS). Any ideas?

Thanks again!


- --
Jean-Luc Fontaine
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFAKQpAkG/MMvcT1qQRAvVdAKCSWqHHAuCDA0lnFpfkaTlstqXeVQCgwtfM
v/njeDxQseNcUmN+phLZcuQ=
=jYct
-----END PGP SIGNATURE-----

