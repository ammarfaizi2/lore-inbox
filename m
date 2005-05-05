Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262097AbVEEPoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262097AbVEEPoA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 11:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbVEEPoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 11:44:00 -0400
Received: from mail01.solnet.ch ([212.101.4.135]:48132 "EHLO mail01.solnet.ch")
	by vger.kernel.org with ESMTP id S262097AbVEEPni (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 11:43:38 -0400
From: Damir Perisa <damir.perisa@solnet.ch>
To: linux-kernel@vger.kernel.org
Subject: how to handle ... warning: `something' is deprecated ...
Date: Thu, 5 May 2005 17:39:36 +0200
User-Agent: KMail/1.8
X-Face: +)fhYFmn|<pyRIlgch_);krg#jn!^z'?xy(Ur#Z6rZi)KD+_-V<Y@i>0pOVfJ4<=?utf-8?q?Q1/=26/=26z=0A=093cxqRa=3B7O=5C4g=5C=7C=5DF-!H0!ew9kx1LqK/iP?=
 =?utf-8?q?Ov8eXi=26I7=60Pez0V0VNMAxnqRL8-30qqKK=3DxGM=0A=09pExQc=5B2=7C?=
 =?utf-8?q?l6v=23?=<iwBvEO9+h|_YS[48z%/kuD2*aT*S/$0323VCL3V9?@}jq<
 =?utf-8?q?Ns6V=3A0m=27Qia=0A=09?="[#oJg[RVe}Sy/lP95E@pa[vdKzqLqn&M`exb91"`,<k`3;Vt97cLjhub0.v+]m`%|>@Z(
 =?utf-8?q?=0A=09EeC/zU7=25?=@"L6mi#..8Q^M
Alanine: true
Glycine: true
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1436303.EtGClLQ6Hs";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200505051739.42521.damir.perisa@solnet.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1436303.EtGClLQ6Hs
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hi all,

i was wondering what i should do with warnings that come up. especially i=20
wonder about depreached code. should it be posted to the ML? do the=20
people maintaining the drivers/code know about them? what is the general=20
procedure? (i know warnings are not errors ;-)

examples (kernel26mm 2.6.12-rc3-mm3):

  CC      drivers/char/agp/efficeon-agp.o
drivers/char/agp/efficeon-agp.c: In function `efficeon_create_gatt_table':
drivers/char/agp/efficeon-agp.c:222: warning: passing arg 1 of=20
`virt_to_phys' makes pointer from integer without a cast

  CC [M]  drivers/char/specialix.o
drivers/char/specialix.c: In function `sx_check_io_range':
drivers/char/specialix.c:343: warning: `check_region' is deprecated=20
(declared at include/linux/ioport.h:124)

  CC [M]  drivers/ide/ide-tape.o
drivers/ide/ide-tape.c: In function `idetape_copy_stage_from_user':
drivers/ide/ide-tape.c:2659: warning: ignoring return value of=20
`copy_from_user', declared with attribute warn_unused_result
drivers/ide/ide-tape.c: In function `idetape_copy_stage_to_user':
drivers/ide/ide-tape.c:2686: warning: ignoring return value of=20
`copy_to_user', declared with attribute warn_unused_result

  CC [M]  drivers/isdn/capi/capidrv.o
drivers/isdn/capi/capidrv.c:2108:3: warning: #warning FIXME: maybe a race=20
condition the card should be removed here from global list /kkeil

  CC [M]  drivers/isdn/hisax/config.o
drivers/isdn/hisax/config.c: In function `HiSax_readstatus':
drivers/isdn/hisax/config.c:636: warning: ignoring return value of=20
`copy_to_user', declared with attribute warn_unused_result
drivers/isdn/hisax/config.c:647: warning: ignoring return value of=20
`copy_to_user', declared with attribute warn_unused_result

  CC      drivers/mca/mca-legacy.o
In file included from drivers/mca/mca-legacy.c:31:
include/linux/mca-legacy.h:12:2: warning: #warning "MCA legacy - please=20
move your driver to the new sysfs api"
In file included from drivers/mca/mca-legacy.c:31:
include/linux/mca-legacy.h:12:2: warning: #warning "MCA legacy - please=20
move your driver to the new sysfs api"

  CC [M]  drivers/net/irda/nsc-ircc.o
drivers/net/irda/nsc-ircc.c: In function `nsc_ircc_cleanup':
drivers/net/irda/nsc-ircc.c:229: warning: `pm_unregister_all' is=20
deprecated (declared at include/linux/pm.h:117)
drivers/net/irda/nsc-ircc.c: In function `nsc_ircc_open':
drivers/net/irda/nsc-ircc.c:366: warning: `pm_register' is deprecated=20
(declared at include/linux/pm.h:107)

  CC [M]  drivers/net/irda/smsc-ircc2.o
drivers/net/irda/smsc-ircc2.c: In function `smsc_ircc_open':
drivers/net/irda/smsc-ircc2.c:465: warning: `pm_register' is deprecated=20
(declared at include/linux/pm.h:107)
drivers/net/irda/smsc-ircc2.c: In function `smsc_ircc_close':
drivers/net/irda/smsc-ircc2.c:1696: warning: `pm_unregister' is deprecated=
=20
(declared at include/linux/pm.h:112)

  CC [M]  drivers/net/irda/ali-ircc.o
drivers/net/irda/ali-ircc.c: In function `ali_ircc_cleanup':
drivers/net/irda/ali-ircc.c:231: warning: `pm_unregister_all' is=20
deprecated (declared at include/linux/pm.h:117)
drivers/net/irda/ali-ircc.c: In function `ali_ircc_open':
drivers/net/irda/ali-ircc.c:360: warning: `pm_register' is deprecated=20
(declared at include/linux/pm.h:107)

  CC [M]  drivers/net/tulip/dmfe.o
drivers/net/tulip/dmfe.c: In function `dmfe_parse_srom':
drivers/net/tulip/dmfe.c:1805: warning: passing arg 1 of `__le16_to_cpup'=20
from incompatible pointer type
drivers/net/tulip/dmfe.c:1817: warning: passing arg 1 of `__le32_to_cpup'=20
from incompatible pointer type
drivers/net/tulip/dmfe.c:1817: warning: passing arg 1 of `__le32_to_cpup'=20
from incompatible pointer type

    CC [M]  drivers/net/ne2.o
In file included from drivers/net/ne2.c:73:
include/linux/mca-legacy.h:12:2: warning: #warning "MCA legacy - please=20
move your driver to the new sysfs api"

thank you in advance,

Damir Perisa

=2D-=20
No one knows what he can do till he tries.
		-- Publilius Syrus

--nextPart1436303.EtGClLQ6Hs
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCej4+PABWKV6NProRAgBQAJ94vXPH8PmKvFcW3G/eEG3y2pWgwACfQpIQ
1nxd/izmF3nOqQZrIwxHhx4=
=E/BQ
-----END PGP SIGNATURE-----

--nextPart1436303.EtGClLQ6Hs--
