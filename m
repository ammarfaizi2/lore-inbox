Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266715AbRGTHsE>; Fri, 20 Jul 2001 03:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266706AbRGTHrz>; Fri, 20 Jul 2001 03:47:55 -0400
Received: from titan.golden.net ([199.166.210.90]:15572 "EHLO titan.golden.net")
	by vger.kernel.org with ESMTP id <S266715AbRGTHrl>;
	Fri, 20 Jul 2001 03:47:41 -0400
From: "John L. Males" <software_iq@TheOffice.net>
Organization: Toronto, Ontario, Canada
To: linux-kernel@vger.kernel.org
Date: Fri, 20 Jul 2001 03:47:43 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Linux Kernel 2.2.19 Available Memory Bug
Reply-to: software_iq@TheOffice.net
Message-ID: <3B57A9DF.10547.A92B31@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

Please note I am not on the Kernel Mailing List so do try to copy me
in with any reply, questions, clarifications, confirmations, et al on
this bug report.

Before I forget I am using SuSE 6.4 with most of the updates from the
base applied, most meaning I generally lag a bit behind at times.  I
am NOT using the SuSE kernel due to bugs introduced into the SuSE
kernel with the SuSE patches/enhancements.  I am using the Linus
2.2.19 Kernel with the OpenWall patches.  System is AMD K6-2 500
based system.  The version of gcc was 2.95.2 to compile the kernel.

The bug I am reporting is that when one sets the amount of memory,
i.e. 128M, 256M; at the time of booting the 2.2.19 kernel the "Total
Memory" as reported by KDE, "free", etc is short by a important
amount.  To be more specific I will detail the results of "free"
below against the "mem" value passed to the kernel.  Please note for
the purposes of this test I always had 256MB or ram (2x128MB)
installed in my system.  The BIOS reports total system memory as
262144K.

"mem=256m"
***************

KDE reports 251.09 Total System memory, or 263290880 bytes.

"free -m" indicates "Total Memory" as 251
"free -k" indicates "Total Memory" as 257120
"free -k" indicates "Total Memory" as 263290880

The exact same vaules as noted above are indicated for "mem=262144k",
and "mem=268435546" (256 X 1024 x 1024).

"mem=128m"
***************

"free -m" indicates "Total Memory" as 124
"free -k" indicates "Total Memory" as 127344
"free -k" indicates "Total Memory" as 130400256


Regards,

John L. Males
Software I.Q. Consulting
Toronto, Ontario
Canada
20 July 2001 03:47
mailto:software_iq@TheOffice.net
mailto:jlmales@softhome.net

-----BEGIN PGP SIGNATURE-----
Version: PGPfreeware 6.5.8 for non-commercial use 
<http://www.pgp.com>

iQA/AwUBO1fwKPLzhJbmoDZ+EQKQowCfcqeGPdpduaFpTQO1P9XaOlJccHEAn20p
v0V59vV7rrFEvMQCLwzXyO2V
=Ezn3
-----END PGP SIGNATURE-----

