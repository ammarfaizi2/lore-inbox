Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278461AbRJVKGx>; Mon, 22 Oct 2001 06:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278469AbRJVKGn>; Mon, 22 Oct 2001 06:06:43 -0400
Received: from ns1.yggdrasil.com ([209.249.10.20]:12980 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S278461AbRJVKGg>; Mon, 22 Oct 2001 06:06:36 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 22 Oct 2001 03:06:21 -0700
Message-Id: <200110221006.DAA13565@baldur.yggdrasil.com>
To: alain@topaze.homeip.net, aphro@portal.aphroland.org, dm@uun.org,
        laufaml@hotmail.com, partur@enter.net.pl
Subject: Sort-of workaround for Via pro133a IDE interrupt loss
Cc: andre@linux-ide.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	People in the "to" field: I am sending you this email because
you reported problems with IDE timeouts on the Via Pro133a chipset (such
as on an ASUS P3V4X motherboard).  I am also cc'ing the linux-kernel
mailing list primarily so that it will be archived and emailing the
Linux IDE maintainer in the hopes that this information will prove
helpful.

	I was using an ASUS P3V4X motherboard that has a Via Pro133A
chipset and experiencing the mysterious IDE timeouts every few minutes
from a 27.2GB Maxtor IDE drive.  laufaml@hotmail.com reported a similar
problem also using a P3V4X + a Maxtor drive, while aphro@portal.aphroland.org
reported no problems with a P3V4X + and IBM drive.

	I have discovered that the problem disappears (under
Linux 2.4.13-pre6) if I replace the 27.2GB Maxtor IDE drive with an
80GB Maxtor IDE drive.  This may be related to the 80GB drive being
able to do ATA100 or some bug fix or workaround in newer Maxtor hard
drive firmware.  

	Note that reports of the problem is not limited to Maxtor.
I saw at least one usenet posting about the problem from someone
with three hard disks, none of them from Maxtor.

	Also see a posting by "Ed &Annemarie (dus.dek@wanadoo.nl)"
regarding a patch by George E. Breese that seems to indicate that
setting the PCI latency register of the Pro133A to 0 (or possibly
to 0x80) solves the problem.  However, when I previously changed
it from 16 to 8 and 128 (0x80), that seemed to have no effect.
I have not tried setting it to zero.

	Anyhow, I hope this information about which drives trigger the
problem and which drives will be of practical use to other people
experiencing the problem or of some use in analyzing and fixing it
in Linux.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
