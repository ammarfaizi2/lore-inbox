Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129289AbQLSPkV>; Tue, 19 Dec 2000 10:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130202AbQLSPkL>; Tue, 19 Dec 2000 10:40:11 -0500
Received: from [204.17.222.1] ([204.17.222.1]:21768 "EHLO picard.csihq.com")
	by vger.kernel.org with ESMTP id <S129289AbQLSPj5>;
	Tue, 19 Dec 2000 10:39:57 -0500
Message-ID: <03a001c069cd$8a593c50$e1de11cc@csihq.com>
From: "Mike Black" <mblack@csihq.com>
To: "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>
Subject: 2.2.18aa2 weird problem
Date: Tue, 19 Dec 2000 10:08:27 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got three machines -- two are identical motherboards.  I've been using
the same kernel binary on all three machines for over a year thru all the
upgrades since 2.2.15 (16, 17, and now 18aa2).

Now that I've compiled 2.2.18aa2 it only works on two of the machines.  Both
of these use RAID1/IDE for boot drives.  The machine that doesn't work uses
a boot floppy as the root drive is RAID5.

When the "bad" machine boots a "df" that has been inserted in rc.inet2 shows
the correct root drive having been mounted.  But, it seems as though the
system cannot see most of the RAID5 mount.  Booting complains about
/etc/mtab~ not being a directory, /lib/modules/2.2.18aa2 not existing (even
though it IS there), and several other files missing.  Executable binaries
seem to work though (i.e. all daemons try to start up).

The end results is that I can't login to the console (typing doesn't even
echo any characters).  So, I'm somewhat restricted on what I can debug.
Remote telnet doesn't work either.  Can't reboot either, have to alt-sysrq-U
and hit the reset key.

Rebooting this machine to 2.2.17-RAID works just fine

Might there be a problem with RAID5 as root?

________________________________________
Michael D. Black   Principal Engineer
mblack@csihq.com  321-676-2923,x203
http://www.csihq.com  Computer Science Innovations
http://www.csihq.com/~mike  My home page
FAX 321-676-2355

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
