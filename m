Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311687AbSCTPkd>; Wed, 20 Mar 2002 10:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311685AbSCTPkX>; Wed, 20 Mar 2002 10:40:23 -0500
Received: from ns01.passionet.de ([62.153.93.33]:47761 "HELO
	mail.cgn.kopernikus.de") by vger.kernel.org with SMTP
	id <S311672AbSCTPkM>; Wed, 20 Mar 2002 10:40:12 -0500
Date: Wed, 20 Mar 2002 16:39:44 +0100
From: Manon Goo <manon@manon.de>
Reply-To: Manon Goo <manon@manon.de>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: arrays@compaq.com, linux-kernel@vger.kernel.org, tytso@MIT.EDU,
        =?ISO-8859-1?Q?Markus_Schr=F6der?= <schroeder.markus@allianz.de>
Subject: Re: Hooks for random device entropy generation missing in
 cpqarray.c
Message-ID: <4915602.1016642384@eva.dhcp.gimlab.org>
In-Reply-To: <Pine.LNX.4.44.0203201630100.1268-100000@netfinity.realnet.co.sz>
X-Mailer: Mulberry/2.2.0b3 (Mac OS X)
X-manon-file: sentbox
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="==========04927708=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--==========04927708==========
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

No its is not there are certain bloc devices like cpqarray an mylex DAC960=20
(which handles this correctly)
which do noether use the SCSI or the IDE driver.

Manon

--On Mittwoch, 20. M=E4rz 2002 16:38 Uhr +0200 Zwane Mwaikambo=20
<zwane@linux.realnet.co.sz> wrote:

> On Wed, 20 Mar 2002, Manon Goo wrote:
>
>> All hooks for the random ganeration (add_blkdev_randomness() ) are
>> ignored  in the cpqarray / ida  driver.
>> 	Is a patch available ?
>> 	or an other updated driver ?
>> 	any hints where to put add_blkdev_randomness() in your driver ?
>
> Its all handled by drivers/scsi/scsi_lib.c, its a generic service so is
> done for all drivers.
>
>> is add_interrupt_randomness() called on an i386 SMP IO-APCI system ?
>
> Yes, check out arch/i386/kernel/irq.c:handle_IRQ_event, irq.c is the
> generic code which sits on top of the real interrupt controller driver,
> be  it an IOAPIC or regular PIC.
>
> Cheers,
> 	Zwane
>
>


--==========04927708==========
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (Darwin)
Comment: For info see http://www.gnupg.org

iD8DBQE8mK1Alp/TJR6NORURAqZ3AKCghDLrNot/W7K9XAuMDm5H/CdSRwCgqCCd
+JfDe9vJ5hBK+LVJ58y/bZ0=
=pJev
-----END PGP SIGNATURE-----

--==========04927708==========--

