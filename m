Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965170AbWBGTiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965170AbWBGTiz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 14:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965171AbWBGTiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 14:38:55 -0500
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:41352 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S965170AbWBGTiy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 14:38:54 -0500
Date: Tue, 7 Feb 2006 20:38:50 +0100 (CET)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: Meelis Roos <mroos@linux.ee>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Duplicated SCSI messages (Was: Re: libATA  PATA status report, new
 patch)
In-Reply-To: <Pine.SOC.4.61.0602071856520.11554@math.ut.ee>
Message-ID: <Pine.BSO.4.63.0602071843510.20433@rudy.mif.pg.gda.pl>
References: <20060207084347.54CD01430C@rhn.tartu-labor> 
 <1139310335.18391.2.camel@localhost.localdomain>  <Pine.SOC.4.61.0602071305310.10491@math.ut.ee>
  <1139312330.18391.14.camel@localhost.localdomain>
 <1139324653.18391.41.camel@localhost.localdomain> <Pine.SOC.4.61.0602071856520.11554@math.ut.ee>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1451446207-1139334633=:20433"
Content-ID: <Pine.BSO.4.63.0602072025080.20433@rudy.mif.pg.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1451446207-1139334633=:20433
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-2; FORMAT=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.BSO.4.63.0602072025081.20433@rudy.mif.pg.gda.pl>

On Tue, 7 Feb 2006, Meelis Roos wrote:
[..]
> SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
> sda: Write Protect is off
> SCSI device sda: drive cache: write back
> SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
> Unknown interrupt or fault at EIP 00000286 00000060 c0112acd
> sda: Write Protect is off
> SCSI device sda: drive cache: write back
> sda:Unknown interrupt or fault at EIP 00000246 00000060 c010162b

I'm allways confused to see this kind messages output with duplicated
SCSI subsystem initialization device reports in kernel logs.
It it not kind of bug ?

Usualy information about single SCSI device takes:

SCSI device sdb: 71687340 512-byte hdwr sectors (36704 MB)
sdb: Write Protect is off
sdb: Mode Sense: cb 00 00 08
SCSI device sdb: drive cache: write back
SCSI device sdb: 71687340 512-byte hdwr sectors (36704 MB)
sdb: Write Protect is off
sdb: Mode Sense: cb 00 00 08
SCSI device sdb: drive cache: write back
  sdb: sdb1 sdb2 sdb3
sd 0:0:3:0: Attached scsi disk sdb
   Vendor: MAXTOR    Model: ATLAS10K5_73WLS   Rev: JNZH
   Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:6:0: Tagged Queuing enabled.  Depth 4
  target0:0:6: Beginning Domain Validation
  target0:0:6: wide asynchronous
  target0:0:6: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 127)
  target0:0:6: Domain Validation skipping write tests
  target0:0:6: Ending Domain Validation

.. 18 lines (14 after remove duplicated lines). Is it not to much ?
Best IMO will write only information like "found/initialize device <foo>; 
</phisical/path>" like in Solaris. All other detailed information can be 
IMO moved to sysfs (informations about partition/slices are now 
in sysfs).

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--0-1451446207-1139334633=:20433--
