Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263483AbTEIVeS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 17:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263487AbTEIVeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 17:34:18 -0400
Received: from netmail02.services.quay.plus.net ([212.159.14.221]:10480 "HELO
	netmail02.services.quay.plus.net") by vger.kernel.org with SMTP
	id S263483AbTEIVeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 17:34:16 -0400
From: "Riley Williams" <Riley@Williams.Name>
To: "Andy Pfiffer" <andyp@osdl.org>, "Christophe Saout" <christophe@saout.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: ext3/lilo/2.5.6[89] (was: [KEXEC][2.5.69] kexec for 2.5.69available)
Date: Fri, 9 May 2003 21:46:50 +0100
Message-ID: <BKEGKPICNAKILKJKMHCACEJHCLAA.Riley@Williams.Name>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <1052513725.15923.45.camel@andyp.pdx.osdl.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy, Christophe.

 >>> I had an unrelated delay in posting this due to some strange
 >>> behavior of late with LILO and my ext3-mounted /boot partition
 >>> (/sbin/lilo would say that it updated, but a subsequent reboot
 >>> would not include my new kernel)

 >> So I'm not the only one having this problem... I think I first
 >> saw this with 2.5.68 but I'm not sure.

 > Well, that makes two of us for sure.

 >> My boot partition is a small ext3 partition on a lvm2 volume
 >> accessed over device-mapper (I've written a lilo patch for
 >> that, but the patch is working and) but I don't think that has
 >> something to do with the problem.
 >>
 >> When syncing, unmounting and waiting some time after running
 >> lilo, the changes sometimes seem correctly written to disk, I
 >> don't know when exactly.
 >
 > My /boot is an ext3 partition on an IDE disk. My symptoms and
 > your symptoms match -- wait awhile, and it works okay. If you
 > don't wait "long enough" the changes made in /etc/lilo.conf are
 > not reflected in the after running /sbin/lilo and rebooting
 > normally.

One suggestion: ext3 is a journalled version of ext2, so if you can
boot with whatever is needed to specify that the boot partition is
to be mounted as ext2 rather than ext3, you can isolate the journal
system: If the problem's still there in ext2 then the journal is
not involved, but if the problem vanishes there, it's something to
do with the journal.

I have to admit that the above sounds very much like the details
are being recorded in the journal, but the journal isn't being
played back to update the actual files.

Best wishes from Riley.
---
 * Nothing as pretty as a smile, nothing as ugly as a frown.

---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.478 / Virus Database: 275 - Release Date: 6-May-2003

