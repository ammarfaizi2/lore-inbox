Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbUAIO02 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 09:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbUAIO02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 09:26:28 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:4739
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S261881AbUAIO00
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 09:26:26 -0500
Date: Fri, 9 Jan 2004 09:39:13 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: Strange lockup with 2.6.0
Message-ID: <20040109093913.A6710@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I usually do a backup of each filesystem simply using tar.  I attempted to
backup a machine I had that's running 2.6.0 and it hard locked.

The destination is over NFS to a server also running 2.6.0 (other machines
have performed the backup to this server w/o problems).  This server is
using KNFSD with v3 enabled.

I first thought the problem could be ACPI or Preemt so I disabled both of
these.  I thought it may be a module conflicting so I booted with
init=/bin/sh.  In the kernel, I have IDE support (intel piix, no HDD support
all ide devices are cds)  and aic7xxx.  My next thought was the NIC.  I was
using a 3c990 card so I swapped it with a 3c905c card.  No change.  I
thought it could be an over loaded power supply so I removed all drives
from the power supply except the boot drive.  No change.  I removed all
irrelevent hardware (leaving only the 3c905c nic and the aha39160 card).  I
also swapped memory around (3 128mb sticks) leaving only 1 stick in the
machine.  Still no change. (Only modules loaded was 3c59x, nfs, lockd, and
sunrpc)  I have NFSv3 snabled in NFS, but not v4.

I simply gave up trying to backup the machine to nfs.  I have a JAZ drive
installed on this machine (external) and decided to backup to the JAZ.  I
powered off the machine, booted with init=/bin/sh and performed the exact
same steps (excluding configuring the NIC and mounting NFS) that caused the
freeze.  This time it completed the entire backup.  No modules were loaded
at this time.

Hardware:
MS6163 System board
Pentium III 700mhz
3 128mb sticks memory (2 are same brand 2 sided, other is different 1 sided)
Adaptec 39160
3com 3c905c (eth0)
3com 3c990  (eth0, not installed at same time as 3c905c)
3com 3c900  (eth1)
Generic 56k ISA PNP modem
Belkin USB2.0 5 port
Ensonic ES1373 Sound card
Matrox G400Max dual AGP (was a G200 AGP)


Relevent kernel config available upon request.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
