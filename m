Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbTJRK1T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 06:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbTJRK1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 06:27:19 -0400
Received: from [141.30.245.2] ([141.30.245.2]:18048 "HELO
	flapp.schottelius.org") by vger.kernel.org with SMTP
	id S261515AbTJRK1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 06:27:08 -0400
Date: Sat, 18 Oct 2003 14:27:08 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 3c59x problem with 2.4.6-test[34]
Message-ID: <20031018122708.GA401@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	Tom Rini <trini@kernel.crashing.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-net@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <20030907212348.GA836@ip68-0-152-218.tc.ph.cox.net> <20030929151827.GB862@ip68-0-152-218.tc.ph.cox.net> <20031015183505.GA963@ip68-0-152-218.tc.ph.cox.net> <20031017235325.GA957@ip68-0-152-218.tc.ph.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
In-Reply-To: <20031017235325.GA957@ip68-0-152-218.tc.ph.cox.net>
X-MSMail-Priority: gibbet nicht.
X-Mailer: cat << EOF | netcat mailhost 110
Organization: http://nerd-hosting.net/
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux flapp 2.6.0-test7
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

another lspci -vvv where the card works f***cking slow:

00:0b.0 Ethernet controller: 3Com Corporation 3c905 100BaseTX [Boomerang]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (750ns min, 2000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at a000 [size=3D64]
        Expansion ROM at <unassigned> [disabled] [size=3D64K]


Nico

Tom Rini [Fri, Oct 17, 2003 at 04:53:25PM -0700]:
> On Wed, Oct 15, 2003 at 11:35:06AM -0700, Tom Rini wrote:
> > On Mon, Sep 29, 2003 at 08:18:27AM -0700, Tom Rini wrote:
> > > On Sun, Sep 07, 2003 at 02:23:48PM -0700, Tom Rini wrote:
> > > > Hello.  I've run into an odd problem with the 3c59x driver on
> > > > 2.6.0-test[34] (and 2.6.0-test4-mm6).  First, from scripts/ver_linu=
x:
> > > >=20
> > > > If some fields are empty or look unusual you may have an old versio=
n.
> > > > Compare to the current minimal requirements in Documentation/Change=
s.
> > > > =20
> > > > Linux opus 2.6.0-test4 #2 SMP Sat Sep 6 20:43:52 MST 2003 i686 GNU/=
Linux
> > > > =20
> > > > Gnu C                  3.3.2
> > > > Gnu make               3.80
> > > > util-linux             2.11z
> > > > mount                  2.11z
> > > > e2fsprogs              1.35-WIP
> > > > PPP                    2.4.1
> > > > nfs-utils              1.0.5
> > > > Linux C Library        2.3.2
> > > > Dynamic linker (ldd)   2.3.2
> > > > Procps                 3.1.11
> > > > Net-tools              1.60
> > > > Console-tools          0.2.3
> > > > Sh-utils               5.0.90
> > > > Modules Loaded         parport_pc lp parport ipt_REJECT iptable_fil=
ter ipt_MASQUERADE ip_nat_ftp ip_conntrack_ftp iptable_nat ip_conntrack ip_=
tables 8250 core soundcore microcode rtc tulip crc32 af_packet 3c59x hid uh=
ci_hcd usbcore ext2
> > > >=20
> > > > and lspci:
> > > > 00:00.0 Host bridge: Intel Corp. 440LX/EX - 82443LX/EX Host bridge =
(rev 03)
> > > > 00:01.0 PCI bridge: Intel Corp. 440LX/EX - 82443LX/EX AGP bridge (r=
ev 03)
> > > > 00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 01)
> > > > 00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
> > > > 00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
> > > > 00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 01)
> > > > 00:0b.0 Ethernet controller: Lite-On Communications Inc LNE100TX (r=
ev 20)
> > > > 00:0c.0 Multimedia audio controller: Ensoniq ES1370 [AudioPCI]
> > > > 00:0d.0 SCSI storage controller: LSI Logic / Symbios Logic 53c895 (=
rev 01)
> > > > 00:0e.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyc=
lone] (rev 24)
> > > > 00:0f.0 Unknown mass storage controller: Promise Technology, Inc. 2=
0262 (rev 01)
> > > > 01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 A=
GP (rev 04)
> > > >=20
> > > > What seems to happen on every other boot (and just rebooting the ma=
chine
> > > > will 'fix' this) is that when 3c59x is loaded I get:
> > > > 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
> > > > 0000:00:0e.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xe480. Vers LK1=
=2E1.19
> > > >   ***WARNING*** No MII transceivers found!
> > > >=20
> > > > and then dhcp never gets an IP.   Virtually all of 2.4 has run just=
 fine
> > > > in this particular setup.
> > >=20
> > > This is still a problem with 2.6.0-test6.
> >=20
> > And with 2.6.0-test7.
>=20
> .. and 2.6.0-test8.
>=20
> A full lspci on the card gives:
> $ sudo lspci -vvv -s 00:0e.0
> 00:0e.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] =
(rev 24)
>         Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParEr=
r- Stepping- SERR+ FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort=
- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 64 (2500ns min, 2500ns max), Cache Line Size: 0x08 (32 b=
ytes)
>         Interrupt: pin A routed to IRQ 9
>         Region 0: I/O ports at e480 [size=3D128]
>         Region 1: Memory at febffd80 (32-bit, non-prefetchable) [size=3D1=
28]
>         Expansion ROM at febc0000 [disabled] [size=3D128K]
>         Capabilities: [dc] Power Management version 1
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1+,=
D2+,D3hot+,D3cold-)
>                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
>=20
>=20
> --=20
> Tom Rini
> http://gate.crashing.org/~trini/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-net" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
quote:   there are two time a day you should do nothing: before 12 and afte=
r 12
         (Nico Schottelius after writin' a very senseless email)
cmd:     echo God bless America | sed 's/.*\(A.*\)$/Why \1?/'
pgp:     new id: 0x8D0E27A4 | ftp.schottelius.org/pub/family/nico/pgp-key.n=
ew
url:     http://nerd-hosting.net - domains for nerds (from a nerd)

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/kTGczGnTqo0OJ6QRAmlBAJ9S7Dc8OKZF7PpvN0jtQLzb1au0lQCfYOi6
/JN7IeMlYhvmmqHj9Gto5fI=
=Pp0r
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
