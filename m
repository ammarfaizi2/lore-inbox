Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268854AbUHUG6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268854AbUHUG6N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 02:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268867AbUHUG6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 02:58:13 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:51419 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S268854AbUHUG6H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 02:58:07 -0400
Message-ID: <4126F27B.9010107@dgreaves.com>
Date: Sat, 21 Aug 2004 07:58:03 +0100
From: David Greaves <david@dgreaves.com>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       fsteiner-mail@bio.ifi.lmu.de, kernel@wildsau.enemy.org,
       diablod3@gmail.com, B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
References: <200408041233.i74CX93f009939@wildsau.enemy.org> <4124BA10.6060602@bio.ifi.lmu.de> <1092925942.28353.5.camel@localhost.localdomain> <200408191800.56581.bzolnier@elka.pw.edu.pl> <4124D042.nail85A1E3BQ6@burner> <1092938348.28370.19.camel@localhost.localdomain> <4125FFA2.nail8LD61HFT4@burner> <101FDDA2-F2F5-11D8-8DEC-000393ACC76E@mac.com>
In-Reply-To: <101FDDA2-F2F5-11D8-8DEC-000393ACC76E@mac.com>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Kyle Moffett wrote:

|
| Security issue:
|     Anybody with read access to certain block devices (Like CD-RW

~                    ^^^^

| drives.) could reflash the firmware or otherwise turn the drive into a
| rather expensive doorstop.
|
| Chosen solution for 2.6.8.1:
|     Only allow certain known-safe commands, anything else needs
| root privileges, specifically CAP_SYS_RAWIO or CAP_SYS_ADMIN,

~    ^^^^^^^^

|  (Seems sane, and follows with the general design of the  rest of the
| kernel).

Can someone explain why it isn't anyone with _write_ access to the device?
Surely it's better to drop a user into a group or setgid a program?

If I have write access to a device then I can wipe it's media anyway.
Is there something I'm missing?

| Personally, I'd rather have a setuid executable on my system than
| allow anybody in the cdwriters group to reflash my CDROM drive.

OK, you keep the users out of the group and make the progaram setgid
cdwriters.
Then if someone makes a mess of the set[gu]id code you lose your
cdwriter (which would be gone anyway) and not your whole system.

Why force the program to escalate to root?

David
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBJvJ78LvjTle4P1gRAgFSAJ92lFbuqHqibMlotNi0jXln10SrhgCePBlS
a4xebwkvjNxVV7L9eoLB7cI=
=bswe
-----END PGP SIGNATURE-----

