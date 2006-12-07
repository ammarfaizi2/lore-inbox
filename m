Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031643AbWLGGQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031643AbWLGGQZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 01:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031656AbWLGGQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 01:16:25 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:49516 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031643AbWLGGQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 01:16:24 -0500
Date: Thu, 7 Dec 2006 17:16:23 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: albertl@mail.com
Cc: Albert Lee <albertcc@tw.ibm.com>, linux-ide@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       LKML <linux-kernel@vger.kernel.org>, ppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: Oops in pata_pdc2027x
Message-Id: <20061207171623.fa0384c5.sfr@canb.auug.org.au>
In-Reply-To: <457790F0.2070208@tw.ibm.com>
References: <20061205170144.0b98d7e6.sfr@canb.auug.org.au>
	<457790F0.2070208@tw.ibm.com>
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__7_Dec_2006_17_16_23_+1100_jDScxizf0QVQEAtA"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__7_Dec_2006_17_16_23_+1100_jDScxizf0QVQEAtA
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Thu, 07 Dec 2006 11:56:32 +0800 Albert Lee <albertcc@tw.ibm.com> wrote:
>
> It seems the opps occurred in the ata_exec_internal(). Could you please
> try the attached patch and see if the older ata_exec_internal() works?
> This can help to narrow it down.

This worked much better:

Waiting for /dev to be fully populated...pata_pdc2027x 0001:cc:01.0: PLL input clock 32721 kHz
ata1: PATA max UDMA/133 cmd 0xD0000800801457C0 ctl 0xD000080080145FDA bmdma 0xD000080080145000 irq 324
ata2: PATA max UDMA/133 cmd 0xD0000800801455C0 ctl 0xD000080080145DDA bmdma 0xD000080080145008 irq 324
scsi1 : pata_pdc2027x
ata1.00: ATAPI, max UDMA/66
ata1.00: configured for UDMA/66
scsi2 : pata_pdc2027x
ATA: abnormal status 0x8 on port 0xD0000800801455DF
scsi 1:0:0:0: CD-ROM            IBM      DROM00205L1   H0 P533 PQ: 0 ANSI: 2
sr0: scsi3-mmc drive: 24x/24x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:0:0: Attached scsi generic sg4 type 5
done.

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__7_Dec_2006_17_16_23_+1100_jDScxizf0QVQEAtA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFd7G3FdBgD/zoJvwRAnvrAKCISQ59ZqrcorBm0FgYlLSv+iGDXgCePdwM
vf+/qufsnb2xGdqNniWJH88=
=NbCo
-----END PGP SIGNATURE-----

--Signature=_Thu__7_Dec_2006_17_16_23_+1100_jDScxizf0QVQEAtA--
