Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265178AbUBIWEE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 17:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265181AbUBIWEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 17:04:04 -0500
Received: from fep04.swip.net ([130.244.199.132]:248 "EHLO fep04-svc.swip.net")
	by vger.kernel.org with ESMTP id S265178AbUBIWD7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 17:03:59 -0500
Message-ID: <4027D2E6.7070706@free.fr>
Date: Mon, 09 Feb 2004 19:35:18 +0100
From: Jean-Luc Fontaine <jfontain@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, ja
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.2: i2c erroneous temperatures from sensors
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


On my SIS based motherboard:

# lspci
00:00.0 Host bridge: Silicon Integrated Systems [SiS] 746 Host (rev 10)
00:01.0 PCI bridge: Silicon Integrated Systems [SiS] SG86C202
00:02.0 ISA bridge: Silicon Integrated Systems [SiS]: Unknown device
0964 (rev 36)
00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev 01)
00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS]
Sound Controller (rev a0)
00:03.0 USB Controller: Silicon Integrated Systems [SiS] USB 1.0
Controller (rev 0f)
00:03.1 USB Controller: Silicon Integrated Systems [SiS] USB 1.0
Controller (rev 0f)
00:03.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0
Controller (rev 0f)
00:03.3 USB Controller: Silicon Integrated Systems [SiS] USB 2.0 Controller
01:00.0 VGA compatible controller: ATI Technologies Inc: Unknown device
5964 (rev 01)

I get:

# sensors
w83697hf-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
VCore:     +1.62 V  (min =  +0.06 V, max =  +0.03 V)
+3.3V:     +3.31 V  (min =  +0.14 V, max =  +0.00 V)
+5V:       +5.08 V  (min =  +0.11 V, max =  +0.00 V)
+12V:     +11.86 V  (min =  +0.97 V, max =  +9.73 V)
- -12V:      +1.13 V  (min =  -4.22 V, max =  -4.38 V)
- -5V:       +2.09 V  (min =  -7.71 V, max =  -7.71 V)
V5SB:      +5.62 V  (min =  +5.43 V, max =  +0.27 V)
VBat:      +0.06 V  (min =  +0.03 V, max =  +1.28 V)
fan1:     2700 RPM  (min =   -1 RPM, div = 2)
fan2:        0 RPM  (min = 168750 RPM, div = 2)
temp1: +280 C (high =  +400 C, hyst =  +120 C) sensor = thermistor

temp2: +345.0 C (high = +1200 C, hyst = +1200 C) sensor = thermistor


As you can see, the temperatures are obviously wrong, and what are they
for (CPU, motherboard)?

Is there anything I can do to help debug the problem? Please let me know
(I know C and can patch).

Many thanks in advance,


Jean-Luc
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFAJ9LjkG/MMvcT1qQRAh2nAJoDXtdgk/MQmogYHW1nyHT9Cjaz5gCgqh9s
sdoxry78C5Tqjk8V1ulwldM=
=knbX
-----END PGP SIGNATURE-----

