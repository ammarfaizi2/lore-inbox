Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265119AbUFRL6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265119AbUFRL6U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 07:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265124AbUFRL6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 07:58:19 -0400
Received: from ms-1.rz.RWTH-Aachen.DE ([134.130.3.130]:24540 "EHLO
	ms-dienst.rz.rwth-aachen.de") by vger.kernel.org with ESMTP
	id S265119AbUFRL6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 07:58:15 -0400
Date: Fri, 18 Jun 2004 13:50:39 +0200
From: Alexander Gran <alex@zodiac.dnsalias.org>
Subject: Re: ACPI S3 - USB resume problem (kernel 2.6.7)
In-reply-to: <200406181341.39546.cr7@os.inf.tu-dresden.de>
To: Carsten Rietzschel <cr7@os.inf.tu-dresden.de>
Cc: linux-kernel@vger.kernel.org
Message-id: <200406181350.44016@zodiac.zodiac.dnsalias.org>
MIME-version: 1.0
Content-type: Text/Plain; charset=iso-8859-15
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.6.2
X-Ignorant-User: yes
References: <200406171744.29244.cr7@os.inf.tu-dresden.de>
 <200406172123.38043@zodiac.zodiac.dnsalias.org>
 <200406181341.39546.cr7@os.inf.tu-dresden.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

My ACPI additionall want's to put the devices to state 2 instead of 3 when 
going to STR. I have hacked up the pcicode to convert state 2 to state 3 
transitions, but this cannot be the solution, i suppose. 
However acpi still fucks up the interrupts. Perhaps it's an dsdt problem.

Alex

Am Freitag, 18. Juni 2004 13:41 schrieb Carsten Rietzschel:
> Hello,
>
> thanks Alex. You're right - the e1000 doesn't work too.
> Also all other PCI-devices like firewire, USB and soundcard do not.
> So it's not a problem of USB, but of ACPI-PCI.
>
> After reading a few mails of the acpi-mailinglist and some bug reports, I
> know now, I'm not alone with this problem :/
>
> I'll have a closer look to acpi-list & bug reports.
> Maybe someone here, has found a solution or has some hints what to do next
> ???
>
> Regards,
> Carsten
>
> Am Donnerstag, 17. Juni 2004 21:23 schrieb Alexander Gran:
> > Am Donnerstag, 17. Juni 2004 17:44 schrieb Carsten Rietzschel:
> > > Noticed that in /proc/interrupts the values for uhci_hcd are not
> > > incremented after resume. So are no IRQs where received (is that right
> > > ?). What could be reason ?
> >
> > No Idea. I also tried to get this working, without success (And no more
> > time at the moment to dig deeper). The e1000 driver has the same problem.
> > No Interrupts on RX. Someone suggested to "Hook the driver to the timer
> > interrupt and see if that works at least somehow", however I'm unsure how
> > to do that ;)
> >
> > regards
> > Alex
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

- -- 
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA0tcS/aHb+2190pERAh4YAKCZwzHKhU19deLn16eRpJdj4kyiwACfVnHn
tGDWuxzBPCb0H5Ipf00wMAI=
=bNOL
-----END PGP SIGNATURE-----

