Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264918AbTLRDRC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 22:17:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264919AbTLRDRC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 22:17:02 -0500
Received: from pca-232-243.stwr.brightok.net ([205.162.232.243]:14103 "EHLO
	nomad5.nomadics.com") by vger.kernel.org with ESMTP id S264918AbTLRDQ7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 22:16:59 -0500
Message-ID: <3FE11C27.8000107@nomadics.com>
Date: Wed, 17 Dec 2003 21:16:55 -0600
From: Eric Towers <etowers@nomadics.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030630
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel hang with Jaz
X-Enigmail-Version: 0.76.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Dec 2003 03:16:57.0963 (UTC) FILETIME=[65378BB0:01C3C515]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I have (re-)discovered a problem with vectoring from LILO to the Linux 
kernel (2.4.x).  When there is no cartridge in my Jaz drive, LILO will 
load and uncompress the kernel, then hang.  Cartridge in Jaz: LILO 
successfully vectors to the kernel.

This does not appear to be a well documented problem.  I found 
references on a Linux PPC page.  Then (finally) section 6.6 of
http://packetstormsecurity.nl/linux/admin/Mini-HOWTOs-FAQs/Jaz-Drive
(The Mini-HOWTOs appear to have generally vanished from the obvious 
sources.)  This reference states
<quote>
6.6. What happens if there is no disk inserted when I boot ?

The kernel will try to read the partition table, but the operation
will (eventually) time out.

When you change disks, it is a good idea always to use fsck to
check the partition structure on the new disk.

The BIOS on some SCSI host adapters will attempt to read the partition
table on your disk during the system boot. If you cannot disable this
check, you may be forced always to boot with a disk in the drive.
</quote>

I have not observed a timeout.  I have left this machine idle for a 
week.  (I was going on vacation, so this wasn't a significant burden.)

Turning the Jaz drive off to ensure that I can't use it under Linux is 
also a workaround (of no utility).

The reference describes a workaround that will accelerate the death of 
the inserted cartridge.  How can I help fix this (not a programmer)? or 
help champion fixing it?
- --
~    -- Eric Towers ! fuzzyeric@bigfoot.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE/4RwnEJrYj/1UkJARAuPDAJ0XAbu6LsopNGUBCw+ZpAUAR4yIBACggZgv
C5U1RkFj3zQippngOjtu63A=
=/pr7
-----END PGP SIGNATURE-----


