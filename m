Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262406AbUF0NP7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbUF0NP7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 09:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbUF0NP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 09:15:59 -0400
Received: from stud.fbi.fh-darmstadt.de ([141.100.40.65]:39389 "EHLO
	stud1.fbihome.de") by vger.kernel.org with ESMTP id S262406AbUF0NPy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 09:15:54 -0400
From: Sergio Vergata <vergata@stud.fbi.fh-darmstadt.de>
To: linux-kernel@vger.kernel.org
Subject: ACPI Hibernate and Suspend Strange behavior 2.6.7/-mm1
Date: Sun, 27 Jun 2004 15:15:26 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200406271515.32148.vergata@stud.fbi.fh-darmstadt.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi all,

I have an IBM t40P.
Starting testing since i got my Laptop, Now starting with 2.6.7 and -mm1 i
Switched from APM to ACPI  and use SwSusp.

Now i trying to get the system working reliable with ACPI, suspending to RAM
will not work as ist should it switch of Display Fan HDD this ist what i see
and hear, but it will not suspend DVDRom an for sure it leave the CPU
powered. I see that cpu i on because the system heats itself up. The time for
the suspended system is round about 10 hours after that the system powers of
and the battery is empty.

Problem number 2 is the problem that of suspending to ram will not reawake the
interrupts of nvram and the acpi interrupts IRQ 9.

Now to the Suspend to Disk problem. Hibernating writes the image to disk
works, but only with disabled apic it poweroff the system in the right way,
with apic the Fan will not shut down don't know if something else isn't
poweredoff.

So i don't use Apic and so acpi works now after powering on the machine and
booting with acpi resume kernel all get to work again. Only sometimes, don't
know why and in witch circumstances, the system boots the kernel and find the
Image in Swapspace, but reading that image says that this is an corruptet
image and stop booting, now if I power the system whith resume=noresume the
kernel boots up find the Image in swap (why that) and restore this found
image back to an running system at the last state. Strange ! After the system
boots everything goes back to work. Only the IRQ problem remains and
hibernating and resuming again will work.

Finaly I have an request: could the acpi_wakeup_devices be addet to some patch
set ? Or preferable to kerneltree it self?!


So i hope someone will read this, and maybe report the same problems, or
better an hint what it could be :-)

CU Sergio
- -- 
Microsoft is to operating systems & security ....
             .... what McDonalds is to gourmet cooking

PGP-Key http://vergata.it/GPG/F17FDB2F.asc
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA3shzVP5w5vF/2y8RApZQAKDXwXf+UJ9RfGb6QtgIyyHxF3681ACglVM0
vAA10ekLqnTqaqzhmN+UqaA=
=UiMb
-----END PGP SIGNATURE-----
