Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262595AbTHWMsW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 08:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263520AbTHWMsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 08:48:22 -0400
Received: from moutng.kundenserver.de ([212.227.126.184]:16847 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262595AbTHWMsR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 08:48:17 -0400
From: Patrick Dreker <patrick@dreker.de>
To: Mikael Pettersson <mikpe@csd.uu.se>, kenton.groombridge@us.army.mil
Subject: Re: nforce2 lockups
Date: Sat, 23 Aug 2003 14:48:06 +0200
User-Agent: KMail/1.5.9
Cc: linux-kernel@vger.kernel.org
References: <200308231220.h7NCKdrC017875@harpo.it.uu.se>
In-Reply-To: <200308231220.h7NCKdrC017875@harpo.it.uu.se>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200308231448.12536.patrick@dreker.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am Samstag, 23. August 2003 14:20 schrieb Mikael Pettersson <mikpe@csd.uu.se> 
zum Thema Re: nforce2 lockups:
> On Sat, 23 Aug 2003 10:41:46 +0900, kenton.groombridge@us.army.mil wrote:
> Passing nolapic to a kernel which doesn't recognise it causes it to
> simply be passed through to init, with no error message.
> So either you used non-standard versions of 2.4.22-rc2/2.6.0-test3,
> or nolapic wasn't the thing that fixed your nforce2 board.
It probably was a combination of the other measures mentioned in my mail then. 
I have (had) the same problems, and one has to completely avoid the local 
APIC it seems. Passing noapic and disabling APIC Mode in the BIOS did not do 
that (2.6.0-test3 + acpi20030730). 

> "noapic" (note: no "l") might very well fix your board, but that's
see above. noapic had no effect on the freezes. On boot it still said "found 
and enabling local APIC" and the system freezes within minutes when I push 
data across the network. Just after compiling a kernel with absolutely no 
APIC stuff compiled in, it worked... Note that the nmi_watchdog was not 
triggered by the freezes, and that seems to run via the APIC, too.

> acpi=off or pci=noacpi might also fix the board, if ACPI is busted.
ACPI works fine, when using at least acpi20030730. Without ACPI the interrupts 
are not assigned OK, as e.g. the onboard 3com NIC does not work (at least 
here).

- -- 
Patrick Dreker

GPG KeyID  : 0xFCC2F7A7 (Patrick Dreker)
Fingerprint: 7A21 FC7F 707A C498 F370  1008 7044 66DA FCC2 F7A7
Key available from keyservers or http://www.dreker.de/pubkey.asc
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/R2KMcERm2vzC96cRAstLAJ9ontoUXT7DS3Nij6rvHdEs7lN7kwCfRlFt
9rGbg6ebuFgAVpXReX4MXuY=
=u10b
-----END PGP SIGNATURE-----
