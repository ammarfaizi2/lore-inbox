Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267605AbUBRPyv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 10:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267606AbUBRPyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 10:54:51 -0500
Received: from [193.170.124.123] ([193.170.124.123]:18661 "EHLO 23.cms.ac")
	by vger.kernel.org with ESMTP id S267605AbUBRPyq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 10:54:46 -0500
Date: Wed, 18 Feb 2004 16:54:23 +0100
From: JG <jg@cms.ac>
To: John Bradford <john@grabjohn.com>
Cc: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: could someone plz explain those ext3/hard disk errors
In-Reply-To: <200402181442.i1IEgwF2000170@81-2-122-30.bradfords.org.uk>
References: <20040209095227.AF4261A9ACF@23.cms.ac>
	<200402091026.i19AQ15t000678@81-2-122-30.bradfords.org.uk>
	<4033691F.7070804@tmr.com>
	<200402181442.i1IEgwF2000170@81-2-122-30.bradfords.org.uk>
X-Mailer: Sylpheed version 0.9.9claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Gentoo 1.4 ;)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Wed__18_Feb_2004_16_54_23_+0100_eXu_VsIk1QfHXFLA"
Message-Id: <20040218155433.D6BE41A9DC6@23.cms.ac>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__18_Feb_2004_16_54_23_+0100_eXu_VsIk1QfHXFLA
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

hi,

> I.E. Even though there is every chance that the drive is faulty, the
> posted error message doesn't indicate a drive failiure in itself, and
> you should look elsewhere.

i recently got the new disks and could backup nearly everything (after reboot the disks were accessible again, though i've lost some data).

i tried to zero out the disk with 'dd if=/dev/zero of=/dev/hdX' which led to a complete system lockup after some time.

after a reboot i wanted to run the long S.M.A.R.T. tests (smartctl -t long /dev/hdX, smartctl v5.26). it said that it is backgrounding for about 80 minutes. but again after some time => complete lockup.
i couldn't do anything anymore on the server, only sysrq-keys were working. killing the processes gave me some error messages (can't remember the exact wording but they were like: "DMA lost" on nearly every disk and some weird interrupt errors (related to the NIC).

$ cat /proc/interrupts
           CPU0
  0:  435370782          XT-PIC  timer
  1:        315          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:    6144225          XT-PIC  ide2, ide3, ide4, ide5
  8:          2          XT-PIC  rtc
 10:          0          XT-PIC  ohci_hcd
 11:   68722839          XT-PIC  eth1
 12:  227629214          XT-PIC  ohci_hcd, eth0
 14:    4515100          XT-PIC  ide0
 15:     643567          XT-PIC  ide1
NMI:          0
LOC:  435357136
ERR:     680356
MIS:          0

don't know if the ERR-rate is too high, this is with an uptime of 5 days. i usually have much higher ERR numbers. 

JG

--Signature=_Wed__18_Feb_2004_16_54_23_+0100_eXu_VsIk1QfHXFLA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAM4q5U788cpz6t2kRAol/AJ9LdSaK9zY/wj/baaD/TpzZ5TRk7wCbBCvo
obD68O+Me/zdeYTku8b6vzY=
=nNHr
-----END PGP SIGNATURE-----

--Signature=_Wed__18_Feb_2004_16_54_23_+0100_eXu_VsIk1QfHXFLA--
