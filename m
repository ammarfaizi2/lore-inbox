Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132589AbRDSKgB>; Thu, 19 Apr 2001 06:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135585AbRDSKfn>; Thu, 19 Apr 2001 06:35:43 -0400
Received: from gadget.lut.ac.uk ([158.125.96.50]:38672 "EHLO gadget.lut.ac.uk")
	by vger.kernel.org with ESMTP id <S132589AbRDSKfZ>;
	Thu, 19 Apr 2001 06:35:25 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: ookhoi@dds.nl
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Grover, Andrew" <andrew.grover@intel.com>,
        "Acpi-PM (E-mail)" <linux-power@phobos.fachschaften.tu-muenchen.de>,
        linux-kernel@vger.kernel.org, acpi@phobos.fachschaften.tu-muenchen.de
Subject: Re: Linux 2.4.3-ac7 
In-Reply-To: Message from Ookhoi <ookhoi@dds.nl> 
   of "Thu, 19 Apr 2001 08:46:35 +0200." <20010419084635.D545@humilis> 
Date: Thu, 19 Apr 2001 11:35:13 +0100
From: Martin Hamilton <martin@net.lut.ac.uk>
Message-Id: <E14qBmL-0000BM-00@gadget.lut.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

(cc'd to the acpi list, where people have also been talking about 
this recently...)

Ookhoi writes:

| I tried swsusp on my vaio (also a c1ve :-) and it didn't work because it
| (said it) couldn't stop [kreiserfsd]. :-(  It didn't do any harm also
| afaics. 

FWIW, I didn't have any luck with the 2.4.3 swsusp-v8pre3 patch - my
C1VE suspended to disk, but on re-reading the memory image from swap
space the machine reset and we were back to the LILO prompt & fsck.

I tried turning everything off at build time that I didn't need to
actually boot the machine, and with 'CONFIG_HWSTATE_RESTORE' both on
and off - to no avail.  Will do a bit more digging to see if I can
figure out the problem, since I was enjoying running the bleeding edge
kernels on this box...

On the other hand the swsusp-v7c patch worked against 2.2.19 with only
minor tweakings, and presumably out-of-the-box against 2.2.18, which
is what it was actually indended for.  Yay!

Just so you don't get your hopes up too high, with this patch (only
tried with CONFIG_HWSTATE_RESTORE off so far) I still had to restart
networking and X after powering up again.  Compared with a full reboot
(of RedHat 7.1!) that's a small price to pay ;-)

But as Alan Cox says, expected the unexpected if you use this in
conjunction with ext3 or ReiserFS at the minute... !

Cheers,

Martin



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999 + martin

iD8DBQE63r9gVw+hz3xBJfQRAnVLAKCaKjSbR7wbRMGQIEFYMRXNDDM8tgCffGTO
MAC6PG1MyHCcaD7vsCvpdh4=
=7nBk
-----END PGP SIGNATURE-----

