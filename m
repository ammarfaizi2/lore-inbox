Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263070AbTIGJij (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 05:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263075AbTIGJij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 05:38:39 -0400
Received: from mail-15.iinet.net.au ([203.59.3.47]:27071 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263070AbTIGJi1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 05:38:27 -0400
Subject: Re: [PATCH] Re: Problems with PCMCIA (Texas Instruments PCI1450)
From: Sven Dowideit <svenud@ozemail.com.au>
Reply-To: svenud@ozemail.com.au
To: Russell King <rmk@arm.linux.org.uk>
Cc: Daniel Ritz <daniel.ritz@gmx.ch>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Tom Marshall <tommy@home.tig-grr.com>
In-Reply-To: <20030906174140.C29417@flint.arm.linux.org.uk>
References: <200308270056.33190.daniel.ritz@gmx.ch>
	 <200309052019.30051.daniel.ritz@gmx.ch>
	 <20030905193811.C14076@flint.arm.linux.org.uk>
	 <200309052140.27906.daniel.ritz@gmx.ch>
	 <20030905205429.D14076@flint.arm.linux.org.uk>
	 <20030906174140.C29417@flint.arm.linux.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-fvPEkI2iC1/VxJISy2+F"
Message-Id: <1062963183.761.0.camel@sven>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 08 Sep 2003 05:33:03 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fvPEkI2iC1/VxJISy2+F
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-09-07 at 02:41, Russell King wrote:=20
> I'd like to hear back from people who have been affected by this bug
> before I push this patch to Linus.
it fixes my pcmcia problem at startup :)

and for bonus points, it also when plugged into the docking station
pcmcia cards (which is one up on the last 2.4 i used)

when i get a chance I will put the pc-card bridge back into my dual
processor piii, and see how that goes too.. is the PC-Card code supposed
to work on SMP?

> Thanks.
no, thank you!=20

in the process of playing around with cardctl eject, insert and pulling
out the card without warning i have gotten the following..=20

airo: Doing fast bap_reads
airo: MAC enabled eth1 0:40:96:33:e:a4
eth1: index 0x05: Vcc 5.0, Vpp 5.0, irq 3, io 0x0100-0x013f
nfs warning: mount version older than kernel
nfs: server 10.10.10.10 not responding, still trying
nfs: server 10.10.10.10 OK
nfs: server 10.10.10.10 not responding, still trying
RPC: sendmsg returned error 101
nfs: RPC call returned error 101
RPC: sendmsg returned error 101
nfs: RPC call returned error 101
RPC: sendmsg returned error 101
nfs: RPC call returned error 101
airo:  Probing for PCI adapters
kobject_register failed for airo (-17)
Call Trace:
[<c0214da9>] kobject_register+0x59/0x60
[<c023c1e2>] bus_add_driver+0x52/0xb0
[<c021ef7e>] pci_register_driver+0x6e/0xa0
[<e08670e8>] airo_init_module+0xe8/0x10d [airo]
[<c0139f0f>] sys_init_module+0x12f/0x260
[<c010b0db>] syscall_call+0x7/0xb

airo:  Finished probing for PCI adapters
airo: Doing fast bap_reads
airo: MAC enabled eth1 0:40:96:33:e:a4
eth1: index 0x05: Vcc 5.0, Vpp 5.0, irq 3, io 0x0100-0x013f
airo:  Probing for PCI adapters
kobject_register failed for airo (-17)
Call Trace:
[<c0214da9>] kobject_register+0x59/0x60
[<c023c1e2>] bus_add_driver+0x52/0xb0
[<c021ef7e>] pci_register_driver+0x6e/0xa0
[<e08670e8>] airo_init_module+0xe8/0x10d [airo]
[<c0139f0f>] sys_init_module+0x12f/0x260
[<c010b0db>] syscall_call+0x7/0xb

airo:  Finished probing for PCI adapters
airo: Doing fast bap_reads
airo: MAC enabled eth1 0:40:96:33:e:a4
eth1: index 0x05: Vcc 5.0, Vpp 5.0, irq 3, io 0x0100-0x013f
irq 9: nobody cared!
Call Trace:
[<c010d45a>] __report_bad_irq+0x2a/0x90
[<c010d550>] note_interrupt+0x70/0xb0
[<c010d890>] do_IRQ+0x160/0x1a0
[<c010ba48>] common_interrupt+0x18/0x20
[<e087007b>] yenta_get_status+0x4b/0x110 [yenta_socket]
[<c010d3e0>] handle_IRQ_event+0x30/0x80
[<c010d7e7>] do_IRQ+0xb7/0x1a0
[<c010ba48>] common_interrupt+0x18/0x20
[<e0828253>] apm_bios_call_simple+0x83/0x100 [apm]
[<e0828437>] apm_do_idle+0x27/0x80 [apm]
[<e0828572>] apm_cpu_idle+0xa2/0x140 [apm]
[<c0105000>] _stext+0x0/0x70
[<c0108c8b>] cpu_idle+0x3b/0x50
[<c03ea919>] start_kernel+0x199/0x1d0
[<c03ea490>] unknown_bootoption+0x0/0x120

handlers:
[<c0260f90>] (ide_intr+0x0/0x1e0)
[<e08708b0>] (yenta_interrupt+0x0/0x40 [yenta_socket])
[<e08708b0>] (yenta_interrupt+0x0/0x40 [yenta_socket])
Disabling IRQ #9

> diff -ur ref/drivers/pcmcia/cs.c linux/drivers/pcmcia/cs.c
> -- ref/drivers/pcmcia/cs.c	Tue Aug  5 11:19:39 2003
> +++ linux/drivers/pcmcia/cs.c	Sat Sep  6 15:07:25 2003


--=-fvPEkI2iC1/VxJISy2+F
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/W4fvPAwzu0QrW+kRArZaAJ4zdjLsbtWfDUdTJW1Yc4Ru2kg/OACgpiFZ
oBzJq3ayGyRyQFQjhcMTM4M=
=JxRn
-----END PGP SIGNATURE-----

--=-fvPEkI2iC1/VxJISy2+F--

