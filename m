Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286692AbSBSSdX>; Tue, 19 Feb 2002 13:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285829AbSBSScl>; Tue, 19 Feb 2002 13:32:41 -0500
Received: from FW.E-SA.COM ([208.151.48.2]:1185 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id <S286447AbSBSSbC>;
	Tue, 19 Feb 2002 13:31:02 -0500
Subject: atyfb compile fix
From: "Samuel M. Stringham" <sams@e-sa.com>
To: linux-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-/0mUhm0WQo3TPezkMBxw"
X-Mailer: Evolution/1.0.2 (1.0.2-1) 
Date: 19 Feb 2002 13:19:38 -0500
Message-Id: <1014142778.19056.9.camel@linux-admin.esa-hq.e-sa.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/0mUhm0WQo3TPezkMBxw
Content-Type: multipart/mixed; boundary="=-xyhgsRv2JF+2Nf5aJiBi"


--=-xyhgsRv2JF+2Nf5aJiBi
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

__initdata is rw not ro, so the const's in atyfb_base.c won't compile
for me without patch below.  This is my first patch post, so any
pointers are welcome.

Samuel Stringham
Network Administrator
www.e-sa.com

--=-xyhgsRv2JF+2Nf5aJiBi
Content-Description: 
Content-Disposition: inline; filename=atyfb.patch
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

--- linux/drivers/video/aty/atyfb_base.c	Tue Feb 19 12:51:46 2002
+++ linux/drivers/video/aty/atyfb_base.c	Tue Feb 19 12:24:50 2002
@@ -251,7 +251,7 @@
 static int default_mclk __initdata =3D 0;
=20
 #ifndef MODULE
-static const char *mode_option __initdata =3D NULL;
+static char *mode_option __initdata =3D NULL;
 #endif
=20
 #ifdef CONFIG_PPC
@@ -271,33 +271,33 @@
 static unsigned long phys_guiregbase[FB_MAX] __initdata =3D { 0, };
 #endif
=20
-static const char m64n_gx[] __initdata =3D "mach64GX (ATI888GX00)";
-static const char m64n_cx[] __initdata =3D "mach64CX (ATI888CX00)";
-static const char m64n_ct[] __initdata =3D "mach64CT (ATI264CT)";
-static const char m64n_et[] __initdata =3D "mach64ET (ATI264ET)";
-static const char m64n_vta3[] __initdata =3D "mach64VTA3 (ATI264VT)";
-static const char m64n_vta4[] __initdata =3D "mach64VTA4 (ATI264VT)";
-static const char m64n_vtb[] __initdata =3D "mach64VTB (ATI264VTB)";
-static const char m64n_vt4[] __initdata =3D "mach64VT4 (ATI264VT4)";
-static const char m64n_gt[] __initdata =3D "3D RAGE (GT)";
-static const char m64n_gtb[] __initdata =3D "3D RAGE II+ (GTB)";
-static const char m64n_iic_p[] __initdata =3D "3D RAGE IIC (PCI)";
-static const char m64n_iic_a[] __initdata =3D "3D RAGE IIC (AGP)";
-static const char m64n_lt[] __initdata =3D "3D RAGE LT";
-static const char m64n_ltg[] __initdata =3D "3D RAGE LT-G";
-static const char m64n_gtc_ba[] __initdata =3D "3D RAGE PRO (BGA, AGP)";
-static const char m64n_gtc_ba1[] __initdata =3D "3D RAGE PRO (BGA, AGP, 1x=
 only)";
-static const char m64n_gtc_bp[] __initdata =3D "3D RAGE PRO (BGA, PCI)";
-static const char m64n_gtc_pp[] __initdata =3D "3D RAGE PRO (PQFP, PCI)";
-static const char m64n_gtc_ppl[] __initdata =3D "3D RAGE PRO (PQFP, PCI, l=
imited 3D)";
-static const char m64n_xl[] __initdata =3D "3D RAGE (XL)";
-static const char m64n_ltp_a[] __initdata =3D "3D RAGE LT PRO (AGP)";
-static const char m64n_ltp_p[] __initdata =3D "3D RAGE LT PRO (PCI)";
-static const char m64n_mob_p[] __initdata =3D "3D RAGE Mobility (PCI)";
-static const char m64n_mob_a[] __initdata =3D "3D RAGE Mobility (AGP)";
+static char m64n_gx[] __initdata =3D "mach64GX (ATI888GX00)";
+static char m64n_cx[] __initdata =3D "mach64CX (ATI888CX00)";
+static char m64n_ct[] __initdata =3D "mach64CT (ATI264CT)";
+static char m64n_et[] __initdata =3D "mach64ET (ATI264ET)";
+static char m64n_vta3[] __initdata =3D "mach64VTA3 (ATI264VT)";
+static char m64n_vta4[] __initdata =3D "mach64VTA4 (ATI264VT)";
+static char m64n_vtb[] __initdata =3D "mach64VTB (ATI264VTB)";
+static char m64n_vt4[] __initdata =3D "mach64VT4 (ATI264VT4)";
+static char m64n_gt[] __initdata =3D "3D RAGE (GT)";
+static char m64n_gtb[] __initdata =3D "3D RAGE II+ (GTB)";
+static char m64n_iic_p[] __initdata =3D "3D RAGE IIC (PCI)";
+static char m64n_iic_a[] __initdata =3D "3D RAGE IIC (AGP)";
+static char m64n_lt[] __initdata =3D "3D RAGE LT";
+static char m64n_ltg[] __initdata =3D "3D RAGE LT-G";
+static char m64n_gtc_ba[] __initdata =3D "3D RAGE PRO (BGA, AGP)";
+static char m64n_gtc_ba1[] __initdata =3D "3D RAGE PRO (BGA, AGP, 1x only)=
";
+static char m64n_gtc_bp[] __initdata =3D "3D RAGE PRO (BGA, PCI)";
+static char m64n_gtc_pp[] __initdata =3D "3D RAGE PRO (PQFP, PCI)";
+static char m64n_gtc_ppl[] __initdata =3D "3D RAGE PRO (PQFP, PCI, limited=
 3D)";
+static char m64n_xl[] __initdata =3D "3D RAGE (XL)";
+static char m64n_ltp_a[] __initdata =3D "3D RAGE LT PRO (AGP)";
+static char m64n_ltp_p[] __initdata =3D "3D RAGE LT PRO (PCI)";
+static char m64n_mob_p[] __initdata =3D "3D RAGE Mobility (PCI)";
+static char m64n_mob_a[] __initdata =3D "3D RAGE Mobility (AGP)";
=20
=20
-static const struct {
+static struct {
     u16 pci_id, chip_type;
     u8 rev_mask, rev_val;
     const char *name;
@@ -357,24 +357,24 @@
 #endif /* CONFIG_FB_ATY_CT */
 };
=20
-static const char ram_dram[] __initdata =3D "DRAM";
-static const char ram_vram[] __initdata =3D "VRAM";
-static const char ram_edo[] __initdata =3D "EDO";
-static const char ram_sdram[] __initdata =3D "SDRAM";
-static const char ram_sgram[] __initdata =3D "SGRAM";
-static const char ram_wram[] __initdata =3D "WRAM";
-static const char ram_off[] __initdata =3D "OFF";
-static const char ram_resv[] __initdata =3D "RESV";
+static char ram_dram[] __initdata =3D "DRAM";
+static char ram_vram[] __initdata =3D "VRAM";
+static char ram_edo[] __initdata =3D "EDO";
+static char ram_sdram[] __initdata =3D "SDRAM";
+static char ram_sgram[] __initdata =3D "SGRAM";
+static char ram_wram[] __initdata =3D "WRAM";
+static char ram_off[] __initdata =3D "OFF";
+static char ram_resv[] __initdata =3D "RESV";
=20
 #ifdef CONFIG_FB_ATY_GX
-static const char *aty_gx_ram[8] __initdata =3D {
+static char *aty_gx_ram[8] __initdata =3D {
     ram_dram, ram_vram, ram_vram, ram_dram,
     ram_dram, ram_vram, ram_vram, ram_resv
 };
 #endif /* CONFIG_FB_ATY_GX */
=20
 #ifdef CONFIG_FB_ATY_CT
-static const char *aty_ct_ram[8] __initdata =3D {
+static char *aty_ct_ram[8] __initdata =3D {
     ram_off, ram_dram, ram_edo, ram_edo,
     ram_sdram, ram_sgram, ram_wram, ram_resv
 };

--=-xyhgsRv2JF+2Nf5aJiBi--

--=-/0mUhm0WQo3TPezkMBxw
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8cpc6AHsuhBrdlT0RAlxnAJ4yGAcBSPzma8edJnPd/7BBF+zOlQCdEOiv
kC0fS8OqqKQZhbeAztG02sU=
=XPXX
-----END PGP SIGNATURE-----

--=-/0mUhm0WQo3TPezkMBxw--
