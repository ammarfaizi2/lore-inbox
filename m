Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265192AbTFMHNd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 03:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265206AbTFMHNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 03:13:33 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:64407 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S265192AbTFMHNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 03:13:30 -0400
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: grendel@caudium.net
Subject: Re: [BUG] 2.5.70-mm8 and the 3com NIC driver
Date: Fri, 13 Jun 2003 09:27:02 +0200
User-Agent: KMail/1.5.9
References: <20030612214626.GA1770@thanes.org>
In-Reply-To: <20030612214626.GA1770@thanes.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_KzX6+qrIeNZJdQc";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200306130927.06971.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_KzX6+qrIeNZJdQc
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marek!

I had a similar problem and for me there were two solutions.

1. Disable ACPI (for example with the 'acpi=off' boot option)
  This was no major impact for me as ACPI never worked here well...

2. Revert the pci-init-ordering-fix from
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.70/2.5.70-mm8/broken-out/pci-init-ordering-fix.patch
  This may be only suboptimal, as this patch seems to fix some problems...

Best regards
   Thomas Schlichter

Marek Habersack wrote:
> Hello,
>
>   As mentioned in the subject, the kernel doesn't work with a 3Com 3c905
> card. Here's what's shown on the screen and in the logs on both startup and
> in intervals during normal system run:
>
> NETDEV WATCHDOG: eth0: transmit timed out
> eth0: transmit timed out, tx_status 00 status e601.
> diagnostics: net 0cc0 media 8802 dma 0000003b fifo 0000
> eth0: Interrupt posted but not delivered -- IRQ blocked by another device?
> Flags; bus-master 1, dirty 240(0) current 240(0)
> Transmit list 00000000 vs. efce2200.
> 0: @efce2200  length 8000002a status 0000002a
> 1: @efce22a0  length 80000050 status 00000050
> 2: @efce2340  length 8000002a status 0000002a
> 3: @efce23e0  length 8000002a status 0000002a
> 4: @efce2480  length 8000002a status 0000002a
> 5: @efce2520  length 80000036 status 00000036
> 6: @efce25c0  length 80000036 status 00000036
> 7: @efce2660  length 80000036 status 00000036
> 8: @efce2700  length 80000050 status 00000050
> 9: @efce27a0  length 80000050 status 00000050
> 10: @efce2840  length 80000050 status 00000050
> 11: @efce28e0  length 80000050 status 00000050
> 12: @efce2980  length 80000050 status 00000050
> 13: @efce2a20  length 80000050 status 00000050
> 14: @efce2ac0  length 80000050 status 80000050
> 15: @efce2b60  length 80000050 status 80000050
> eth0: Resetting the Tx ring pointer.
>
> All the earlier -mm kernels worked fine in this regard,
>
> marek

--Boundary-02=_KzX6+qrIeNZJdQc
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+6XzKYAiN+WRIZzQRAkMwAKCsWCrcK/7lU+zkXJtTcXTHpdUkYACcCy+8
Q3S48VAITIuemuM64NXxnsM=
=r/iL
-----END PGP SIGNATURE-----

--Boundary-02=_KzX6+qrIeNZJdQc--
