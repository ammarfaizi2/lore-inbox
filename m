Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131009AbRAMR1U>; Sat, 13 Jan 2001 12:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131011AbRAMR1L>; Sat, 13 Jan 2001 12:27:11 -0500
Received: from air.lug-owl.de ([62.52.24.190]:43270 "HELO air.lug-owl.de")
	by vger.kernel.org with SMTP id <S131009AbRAMR1B>;
	Sat, 13 Jan 2001 12:27:01 -0500
Date: Sat, 13 Jan 2001 18:26:09 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: sparc10 with 512M of RAM hangs on boot
Message-ID: <20010113182609.B11253@lug-owl.de>
Reply-To: jbglaw@lug-owl.de
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010113034809.28919.qmail@web1001.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010113034809.28919.qmail@web1001.mail.yahoo.com>; from ronnnyc@yahoo.com on Fri, Jan 12, 2001 at 07:48:09PM -0800
X-Operating-System: Linux air 2.4.0-test8-pre1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2001 at 07:48:09PM -0800, Ron Calderon wrote:
> every kernel after 2.4.0-test5 hangs my sparc10
> at the same spot. Has anyone looked into this?

Well, that's when highmen support was introduced into sparc32, right?

> Uncompressing image...
> PROMLIB: obio_ranges 5
> bootmem_init: Scan sp_banks,=20
> init_bootmem(spfn[121],bpfn[121],mlpfn[c000])
> free_bootmem: base[0] size[c000000]
> reserve_bootmem: base[0] size[121000]
> reserve_bootmem: base[121000] size[1800]
>=20
> the last kernel I tried was cvs'ed from vger last
> night. I beleive it was 2.4.1-pre2.

That's quite the same output I get. However, supplying mem=3D128M
(I have got 128MB) at least allows me to boot up with about
25MB of RAM (sparc has holes...):

CVS_Root  DIFF_f  REMOVE  scsi-gui
jbglaw@sparcling:~$ cat /proc/cmdline=20
ro root=3D/dev/sda1 mem=3D128M console=3Dttya
jbglaw@sparcling:~$ free
             total       used       free     shared    buffers     cached
Mem:         26564      21720       4844          0        720      12104
-/+ buffers/cache:       8896      17668
Swap:        49840          0      49840
jbglaw@sparcling:~$ uname -a
Linux sparcling 2.4.0-test12 #2 SMP Sat Dec 16 02:25:25 CET 2000 sparc unkn=
own

It's a SparcStation 10 w/ 2 CPUs.

Anton, do you have any clue where changes could have broke SS10 support?

MfG, JBG

--=20
Fehler eingestehen, Gr=F6=DFe zeigen: Nehmt die Rechtschreibreform zur=FCck=
!!!
/* Jan-Benedict Glaw <jbglaw@lug-owl.de> -- +49-177-5601720 */
keyID=3D0x8399E1BB fingerprint=3D250D 3BCF 7127 0D8C A444 A961 1DBD 5E75 83=
99 E1BB
     "insmod vi.o and there we go..." (Alexander Viro on linux-kernel)

--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.2 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjpgj7EACgkQHb1edYOZ4bup5ACfe1MtjoCCOiTjirU/zieoX35q
PksAnRgoQpyWqPUVy9YwN+9Tn1GWjBjc
=P7kw
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
