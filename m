Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131101AbQLLSPg>; Tue, 12 Dec 2000 13:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131194AbQLLSP1>; Tue, 12 Dec 2000 13:15:27 -0500
Received: from h201.s254.netsol.com ([216.168.254.201]:13697 "EHLO
	tesla.admin.cto.netsol.com") by vger.kernel.org with ESMTP
	id <S131101AbQLLSPR>; Tue, 12 Dec 2000 13:15:17 -0500
Date: Tue, 12 Dec 2000 12:45:12 -0500
From: Pete Toscano <pete@research.netsol.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] PROBLEM: USB (MS Intellimouse specifically) does not work with SMP Linux 2.2.18.
Message-ID: <20001212124512.E1139@tesla.admin.cto.netsol.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20001212093534.M3046@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="kORqDWCi7qDJ0mEj"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001212093534.M3046@kroah.com>; from greg@kroah.com on Tue, Dec 12, 2000 at 09:35:34AM -0800
X-Uptime: 12:34pm  up  1:15,  5 users,  load average: 0.06, 0.17, 0.15
X-Married: 394 days, 16 hours, 49 minutes, and 29 seconds
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--kORqDWCi7qDJ0mEj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


what mobo/chipset are you using?  i and a bunch of other people have
been having very similar problems with this and the 2.4.0-test kernels.
we all use the tyan tiger 133 mobo with the apollo pro 133a chipset.  i
believe that the 2.2.18 usb support has been pulled from the 2.4.0-test
source, so i'm not surprised to be seeing this.

on the linux-usb list, i was talking with johannes erdfel and doing some
checks for him.  he thinks that it's a pci irq problem as the usb
controller (uhci and usb-uhci) don't get any interrupts on smp-enabled
kernels when apic is enabled.  i've written martin mares about this (but
to the email address listed on his web page -- not mj@suse.cz, yet -- so
it probably got dropped into /dev/null) and i'm eager to hear his
opinion on matters.  i'll bet that now that the problem has moved into
the 2.2 line, we'll be seeing more noise about it.

laramie, try disabling apic at the lilo prompt (add "noapic" after your
kernel image's name) and see if that helps. =20

pete

On Tue, 12 Dec 2000, Greg KH wrote:

> On Tue, Dec 12, 2000 at 02:07:59PM -0000, Laramie Leavitt wrote:
> > [1.] One line summary of the problem:
> > USB (MS Intellimouse specifically) does not work with SMP kernel 2.2.18.
> >=20
> > [2.] Full description of the problem/report:
> > When trying to install a Microsoft Intellimouse Explorer (USB)
> > to a SMP kernel, I get the following error multiple times:
> >=20
> > usb.c: USB device not accepting new address (error=3D-110)
>=20
> What's your BIOS setting for MSR?
>=20
> And how about the contents of /proc/interrupts?
>=20
> This is a case of when the usb code isn't getting the hardware interrupt
> delivered properly.
>=20
> thanks,
>=20
> greg k-h

--=20
Pete Toscano    p:sigsegv@psinet.com     w:pete@research.netsol.com
GPG fingerprint: D8F5 A087 9A4C 56BB 8F78  B29C 1FF0 1BA7 9008 2736

--kORqDWCi7qDJ0mEj
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6NmQoH/Abp5AIJzYRApqEAJ9y7+Hx5ytiMbWATIOBD3I3kz//gQCg1BWX
5kk+OMVDOL316EuthNchWZ4=
=YnMQ
-----END PGP SIGNATURE-----

--kORqDWCi7qDJ0mEj--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
