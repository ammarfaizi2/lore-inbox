Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275290AbTHGMJk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 08:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275249AbTHGMJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 08:09:40 -0400
Received: from 202-47-55-78.adsl.gil.com.au ([202.47.55.78]:13440 "HELO
	longlandclan.hopto.org") by vger.kernel.org with SMTP
	id S275290AbTHGMJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 08:09:36 -0400
Message-ID: <3F32417D.3090000@longlandclan.hopto.org>
Date: Thu, 07 Aug 2003 22:09:33 +1000
From: Stuart Longland <stuartl@longlandclan.hopto.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4b) Gecko/20030507
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Lernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Problems with Yamaha opl3sa2 under 2.4.20 and ongoing PCMCIA & USB
 problems on 2.6.0-test2
X-Enigmail-Version: 0.75.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,
	I've recently set up Linux 2.6.0-test2 on my laptop (Toshiba Protege
7010CT) which is running Slackware 9.0.  I've also set up the default
Slackware kernel so that I can run both kernels concurrently.

	So far, I've had minor problems with 2.4.20, but some even worse
problems with 2.6.0-test2.

Under 2.4.20:
	Everything works flawlessly, except the sound card (Yamaha OPL3-SAx)
refuses to work, the opl3sa2 driver does not recognise the card.

Under 2.6.0-test2:
	- Most things work nicely, even runs faster.
	- MySQL refuses to start (already noted on this list)
	- PCMCIA locks hard when adding and removing PCMCIA cards, even if I
run 'cardctl eject' first.
	- My combo network card & modem "Xircom RealPort Ethernet 10/100+Modem
56" only partially works.  Network works if I load 8250_cs, but
otherwise, the pcmcia-cs utilities try loading serial_cs.
	- My USB 2.0 hard drive box (aka IDE-TO-USB) does not function.  It
detects it, and automatically loads usb_storage, but I get an error
message saying the device was not found.

At the moment, I'm willing to stick with Linux 2.4.x, eventually I'll
upgrade to 2.4.21 or 22, depending on which is out, if I can get the
soundcard to detect.  However, I think getting Linux 2.6 fixed would be
the better option.

Is there something I might have missed in the kernel setup, or the
configuration of pcmcia-cs that needs to be changed?

Is it possible to, say, backport the opl3sa2 driver to Linux 2.4.2x?

Thanks,
- --
+-------------------------------------------------------------+
| Stuart Longland           stuartl at longlandclan.hopto.org |
| Brisbane Mesh Node: 719             http://stuartl.cjb.net/ |
| I haven't lost my mind - it's backed up on a tape somewhere |
| Griffith Student No:           Course: Bachelor/IT (Nathan) |
+-------------------------------------------------------------+
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE/MkF9IGJk7gLSDPcRAis6AJ0UJHHsrPdfISdd7LOpoj7iBN5E1QCdFcI2
ePJsTVcWFmU8DUg0Fe5Q0n8=
=CEuf
-----END PGP SIGNATURE-----

