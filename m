Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131655AbRA3Avg>; Mon, 29 Jan 2001 19:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131657AbRA3Av0>; Mon, 29 Jan 2001 19:51:26 -0500
Received: from h201.s254.netsol.com ([216.168.254.201]:4772 "EHLO
	tesla.admin.cto.netsol.com") by vger.kernel.org with ESMTP
	id <S131655AbRA3AvX>; Mon, 29 Jan 2001 19:51:23 -0500
Date: Mon, 29 Jan 2001 19:50:33 -0500
From: Pete Toscano <pete@research.netsol.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
Subject: Via PCI IRQ routing problem related? (was: PCI IRQ routing problem in 2.4.0)
Message-ID: <20010129195033.A16505@tesla.admin.cto.netsol.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
In-Reply-To: <200101290511.XAA21997@isunix.it.ilstu.edu> <Pine.LNX.4.10.10101282150540.5509-200000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10101282150540.5509-200000@penguin.transmeta.com>; from torvalds@transmeta.com on Sun, Jan 28, 2001 at 10:03:20PM -0800
X-Uptime: 7:41pm  up 20 days,  1:50,  4 users,  load average: 0.24, 0.18, 0.21
X-Married: 442 days, 23 hours, 56 minutes, and 7 seconds
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hmmm, would these sis-related pirq problems be related to the current
problems lots of people with a via chipset (at least the apollo pro 133a
chipset) and an smp-enabled kernel are seeing?  currently, people with
this chipset and an smp-enabled kernel have to disable apic if they wish
to use usb.  i've been told a few times that it's a problem with pci irq
routing, but have been able to find a fix.  reports of this problem pop
up every-so-often on the linux-usb list.

here's my dump_pirq output:

Interrupt routing table found at address 0xfdb50:
  Version 1.0, size 0x00a0
  Interrupt router is device 00:07.0
  PCI exclusive interrupt mask: 0x1c20 [5,10,11,12]
  Compatible router: vendor 0x1106 device 0x0596

Device 00:0f.0 (slot 1): FireWire (IEEE 1394)
  INTA: link 0x05, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTB: link 0x01, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTC: link 0x02, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTD: link 0x03, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]

Device 00:10.0 (slot 2): SCSI storage controller
  INTA: link 0x01, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTB: link 0x02, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTC: link 0x03, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTD: link 0x05, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]

Device 00:11.0 (slot 3): Multimedia audio controller
  INTA: link 0x02, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTB: link 0x03, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTC: link 0x05, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTD: link 0x01, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]

Device 00:12.0 (slot 4): Unknown mass storage controller
  INTA: link 0x03, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTB: link 0x05, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTC: link 0x01, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTD: link 0x02, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]

Device 00:13.0 (slot 5): Ethernet controller
  INTA: link 0x05, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTB: link 0x01, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTC: link 0x02, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTD: link 0x03, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]

Device 00:14.0 (slot 6):=20
  INTA: link 0x01, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTB: link 0x02, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTC: link 0x03, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTD: link 0x05, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]

Device 00:01.0 (slot 0): PCI bridge
  INTA: link 0x01, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTB: link 0x02, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTC: link 0x03, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTD: link 0x05, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]

Device 00:07.0 (slot 0): ISA bridge
  INTC: link 0x03, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTD: link 0x05, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]

Interrupt router at 00:07.0: VIA 82C596 PCI-to-ISA bridge
  PIRQA (link 0x01): irq 11
  PIRQB (link 0x02): irq 5
  PIRQC (link 0x03): irq 10
  PIRQD (link 0x05): irq 12

any ideas?  i also saved the lspci -vvvxxx and dmesg output if that'll
be helpful.

thanks,
pete



On Sun, 28 Jan 2001, Linus Torvalds wrote:

> On Sun, 28 Jan 2001, Tim Hockin wrote:
> >=20
> > In reading the PIRQ specs, and making it work for our board, I thought
> > about this.  PIRQ states that link is chipset-dependant.  No chipset th=
at I
> > have seen specifies what link should be.  So, as this case demonstrates=
, it
> > may be 'A' - the value the chipset expects, or 1, the logical index.
> > Either one makes sense, assuming the PIRQ routing code knows what link
> > means.  Here we see two BIOS vendors/versions that apparently do it
> > differently for the same chipset.    Grrr.
>=20
> They _may_ do the same thing for the same chipset, it's just that we don't
> know exactly what that "same" thing is.
>=20
> Ok, I want to see what people have. ANYBODY who has a SiS chipset, please
> take 5 seconds to do this as root (yes, you need to be root):
>=20
> 	dump_pirq | mail -s "dump_pirq" torvalds@transmeta.com

--=20
Pete Toscano    p:sigsegv@psinet.com     w:pete@research.netsol.com
GPG fingerprint: D8F5 A087 9A4C 56BB 8F78  B29C 1FF0 1BA7 9008 2736

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6dg/ZH/Abp5AIJzYRAqgeAKCTuCElJLX6p9W1gUhz6389evZnlgCgu44D
GZZPGU2lh7kxcR1wirWTUK0=
=KpLm
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
