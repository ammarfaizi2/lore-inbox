Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315566AbSECGZZ>; Fri, 3 May 2002 02:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315567AbSECGZY>; Fri, 3 May 2002 02:25:24 -0400
Received: from mail.medav.de ([213.95.12.190]:5390 "HELO mail.medav.de")
	by vger.kernel.org with SMTP id <S315566AbSECGZV>;
	Fri, 3 May 2002 02:25:21 -0400
From: "Daniela Engert" <dani@ngrt.de>
To: "Mike Fedyk" <mfedyk@matchmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Fri, 03 May 2002 08:25:06 +0200 (CDT)
Reply-To: "Daniela Engert" <dani@ngrt.de>
X-Mailer: PMMail 2.00.1500 for OS/2 Warp 4.05
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="_=_=_=IMA.BOUNDARY.GVJBTU138764=_=_=_"
Subject: ATA chip list (capabilites, features and bugs)
Message-Id: <20020503051811.EBC4C6FC1@mail.medav.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--_=_=_=IMA.BOUNDARY.GVJBTU138764=_=_=_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Thu, 2 May 2002 17:48:38 -0700, Mike Fedyk wrote:

>On Sat, Apr 27, 2002 at 05:50:43PM +0200, Daniela Engert wrote:
>> I've added an additional column to my "IDE drivers capabilities,
>> features and bug list" which summarizes my tests with LBA48 DMA modes=
.
>> A "?" means "no test conducted" (usually because of lack of hardware)=
,
>> a "x" means supported, a "-" means "unsupported". and a "x!" means
>> "supported, special treatment required".
>
>Can you post this as an attachment, or is it on the web somewhere?

Unfortunately, I don't have enough time left to do both driver
development and website maintenance ;-)

Since I've added some more chips (Intel and Highpoint) to this list
compared to the last post, I've decided to both attach it compressed
and include it verbatim for rapid consumption:

 Vendor
 | Device
 | | Revision			      ATA  LBA48  ATAPI       ATA66  ATA133
 | | | south/host bridge id	    PIO DMA DMA  PIO DMA  ATA33 | ATA100|   =
Docs
 | | | | south/host bridge rev.    32bit |   |	32bit |     |	|   |	|  av=
ail
 | | | | |			     |	 |   |	  |   |     |	|   |	|    |
 v v v v v			     v	 v   v	  v   v     v	v   v	v    v

 0x8086 Intel
   0x1230 PIIX			     x	 x   ?	  x   x     -	-   -	-    x
     < 02			     x	 -   -	  x   -     -	-   -	-    x
       0x84C4 Orion
	 < 04			     x	 -   -	  x   -     -	-   -	-    x
   0x7010 PIIX3 		     x	 x   x	  x   x     -	-   -	-    x
   0x7111 PIIX4 		     x	 x   x	  x   x     x	-   -	-    x
   0x7199 PIIX4 MX		     x	 x   x	  x   x     x	-   -	-   (x)
   0x2411 ICH			     x	 x   x	  x   x     x	x   -	-    x
   0x7601 ICH			     x	 x   x	  x   x     x	x   -	-   (x)
   0x2421 ICH0			     x	 x   x	  x   x     x	-   -	-    x
   0x244B ICH2			     x	 x   x	  x   x     x	x   x  (x)   x
   0x244A ICH2 mobile		     x	 x   x	  x   x     x	x   x  (x)   x
   0x245B C-ICH 		     x	 x   x	  x   x     x	x   x  (x)   x
   0x248B ICH3			     x	 x   x	  x   x     x	x   x  (x)   x
   0x248A ICH3 mobile		     x	 x   x	  x   x     x	x   x  (x)   x
   0x24CB ICH4			     x	 x   x	  x   x     x	x   x	x   (x)

 known bugs and features:
   - PIIX3: some chips 'forget' to assert the IRQ sometimes. These chips=
 are not
	    detectable in advance.
   - ICH2+: despite the docs, the ATA/100 capable chips also can do ATA/=
133

------------------------------------------------------------------------=
--------
 0x1106 VIA
   0x1571 571			     x	 x   ?	  x   x     -	-   -	-    -
   0x0571 571
       0x0586
	 < 0x20  586		     x	 x   ?	  x   x     -	-   -	-    x
	 >=3D0x20  586A/B 	     x	 x   x	  x   x     x	-   -	-    x
       0x0596
	 < 0x10  596/A		     x	 x   x	  x   x     x	-   -	-    x
	 >=3D0x10  596B		     x	 x   x	  x   x     x	x   -	-    x
       0x0686
	 < 0x10  686		     x	 x   x	  x   x     x	-   -	-    -
	 < 0x40  686A		     x	 x   x	  x   x     x	x   -	-    x
	 >=3D0x40  686B		     x	 x   x	  x   x     x	x   x	-    x
       0x8231	 VT8231 	     x	 x   x	  x   x     x	x   x	-    -
       0x3074	 VT8233 	     x	 x   x	  x   x     x	x   x	-    x
       0x3109	 VT8233c	     x	 x   x	  x   x     x	x   x	-    -
       0x3147	 VT8233a	     x	 x   x	  x   x     x	x   x	x    -

 known bugs:
   - all:  no host side cable type detection.
   - all:  the busmaster 'active' bit doesn't match the actual busmaster=
 state.
   - 596B: don't touch the busmaster registers too early after interrupt=

	   don't touch taskfile registers before stopping the busmaster!
   - 686 rev 40/41 and VT8231 rev 10/11 have the PCI corruption bug!

------------------------------------------------------------------------=
--------
 0x10B9 ALi
   0x5229 M5229
     < 0x20			     x	 x   -	  x   -     -	-   -	-   (x)
     < 0xC1	 1533, 1543E/F	     x	 x   -	  x   -     x	-   -	-   (x)
     < 0xC2	 1543C		     x	 x   -	  x   xR    x	-   -	-   (x)
	 0xC3/
	 0x12	 1543C-E	     x	 x   -	  x   xR   (x)	-   -	-   (x)
     < 0xC4	 1535, 1553,	     x	 x   -	  x   x     x	x   -	-    x
		 1543C-B, 1535D
     =3D=3D0xC4	 1535D+ 	     x	 x   -	  x   x     x	x   x	-    x
     > 0xC4	 1535D+ 	     x	 x   x	  x   x     x	x   x	x    -

 known bugs:
   - 1535 and better: varying methods of host side cable type detection.=

   - up to 1543C: busmaster engine 'active' status bit is nonfunctional
		  in UltraDMA modes.
   - up to 1543C: can't do ATAPI DMA writes.
   - 1543C-E:	  UltraDMA CRC checker fails with older WDC disks.
   - 1543C-Bx:	  must stop busmaster reads with 0x00 instead of 0x08.

------------------------------------------------------------------------=
--------
 0x1039 SiS
   0x5513 5513
     < 0xD0			     x	 x   ?	  x   x     -	-   -	-    x
     >=3D0xD0			     x	 x   ?	  x   x     x	-   -	-    x
       >=3D 0x0530		     x	 x   ?	  x   x     x	x   -	-   (x)
       >  0x0630		     x	 x   ?	  x   x     x	x   x	-   (x)
       6/746 6/751		     x	 x   ?	  x   x     x	x   x	x    -

   - older SiS: don't touch the busmaster registers too early after inte=
rrupt

------------------------------------------------------------------------=
--------
 0x1095 CMD/Silicon Image
   0x0640 CMD 640		     -	 -   -	  -   -     -	-   -	-    x
     00   refuse!
   0x0643 CMD 643
     < 03			     x	 x   ?	  x   x     -	-   -	-    x
     >=3D03			     x	 x   ?	  x   x     x	-   -	-    x
   0x0646 CMD 646
     < 03			     x	 x   ?	  x   x     -	-   -	-    x
     >=3D03			     x	 x   ?	  x   x     x	-   -	-    x
   0x0648 CMD 648		     x	 x   ?	  x   x     x	x   -	-    x
   0x0649 CMD 649		     x	 x   x	  x   x     x	x   x	-   (x)
   0x0680 SiI 680		     x	 x   x	  x   x     x	x   x	x    x

 known bugs:
   - 640: the enable bit of the secondary channel is erratic. You need t=
o check
	  both settings '0' and '1' for a populated channel.
   - 640: revision 0 doesn't work reliably.
   - up to 646: both channels share internal resources. Serialization is=

	  required.

------------------------------------------------------------------------=
--------
 0x105A Promise
   0x4D33 PDC20246   Ultra33	     x	 x   ?	  -   -     x	-   -	-    x
   0x4D38 PDC20262   Ultra66	     x	 x   x!   -  (x)    x	x   -	-    x
   0x0D38 PDC20263   Ultra66	     x	 x   x!   -  (x)    x	x   -	-   (x)
   0x0D30 PDC20265   Ultra100	     x	 x   x!   -  (x)    x	x   x	-    x
   0x4D30 PDC20267   Ultra100	     x	 x   x!   -  (x)    x	x   x	-    x
   0x4D68 PDC20268   Ultra100 TX2    x	 x   x	  x   x     x	x   x	-   (x=
)
   0x6268 PDC20270   Ultra100 TX2    x	 x   x	  x   x     x	x   x	-   (x=
)
   0x4D69 PDC20269   Ultra133 TX2    x	 x   x	  x   x     x	x   x	x    x=

   0x6269 PDC20271   Ultra133 TX2    x	 x   x	  x   x     x	x   x	x   (x=
)
   0x1275 PDC20275   Ultra133 TX2    x	 x   x	  x   x     x	x   x	x   (x=
)
   0x5275 PDC20276   Ultra133 TX2    x	 x   x	  x   x     x	x   x	x    x=

   0x7275 PDC20277   Ultra133 TX2    x	 x   x	  x   x     x	x   x	x   (x=
)

 known bugs:
   - up to Ultra100: don't issue superfluous PIO transfer mode setups.
   - up to Ultra100: if any device is initialized to UltraDMA, you need =
to
	  reset the channel if you want to select MultiWord DMA instead.
   - Ultra66/100: a LBA48 DMA mode transfer needs an extra "kick".
   - Ultra66/100: ATAPI DMA should work according to Windows drivers, bu=
t the
	  register model is very "strange".

------------------------------------------------------------------------=
--------
 0x1078 Cyrix
   0x0102 CX5530		     x	 x   ?	  x   x     x	-   -	-    x

 known bugs:
   - all: busmaster transfers need to be 16 byte aligned instead of word=

	  aligned.
   - all: a DMA block of 64KiB comes out as 0 bytes in the DMA engine

------------------------------------------------------------------------=
--------
 0x1103 HighPoint
   0x0004 HPT 36x/37x
     <=3D01 HPT 366		     x	 x   x	  x   x     x	x   -	-    x
       02 HPT 368		     x	 x   x	  x   x     x	x   -	-    -
       03 HPT 370		     x	 x   x	  x   x     x	x   x	-    x
       04 HPT 370A		     x	 x   x	  x   x     x	x   x	-   (x)
       05 HPT 372		     x	 x   x	  x   x     x	x   x	x    x
   0x0005 HPT 372A		     x	 x   x	  x   x     x	x   x	x   (x)
   0x0006 HPT 302		     x	 x   x	  x   x     x	x   x	x   (x)
   0x0007 HPT 371		     x	 x   x	  x   x     x	x   x	x   (x)
   0x0008 HPT 36x/37x dual
       07 HPT 374		     x	 x   x	  x   x     x	x   x	x    x

 known bugs:
   - HPT366: random failures with several disks.
   - HPT366: random PCI bus lockups in case of too long bursts.
   - HPT366: IBM DTLA series drives must be set to Ultra DMA mode 5 (!!)=
 to work
	     reliably at Ultra DMA mode 4 speed.

------------------------------------------------------------------------=
--------
 0x1022 AMD
   0x7401 AMD 751		     x	 x   ?	  x   x     x	-   -	-    -
   0x7409 AMD 756		     x	 x   ?	  x   x     x	x   -	-    x
   0x7411 AMD 766  MP		     x	 x   ?	  x   x     x	x   x	-    x
   0x7441 AMD 768  MPX		     x	 x   ?	  x   x     x	x   x	-    x
   0x7469 AMD 8111		     x	 x   ?	  x   x     x	x   x	-    -

 known bugs:
   - 756: no host side cable type detection.
   - 756: SingleWord DMA doesn't work on early chip revisions.
   - 766: read/write prefetches must be disabled to defeat infinite
	  PCI bus retries.

------------------------------------------------------------------------=
--------
 0x1191 AEC/Artop
   0x0005 AEC 6210		     x	 x   ?	  ?   ?     x	-   -	-    -
   0x0006 AEC 6260		     x	 x   ?	  ?   ?     x	x   -	-    -
   0x0007 AEC 6260		     x	 x   ?	  ?   ?     x	x   -	-    -
   0x0009 AEC 6280/6880 	     x	 x   ?	  ?   ?     x	x   x	x    -

 known bugs:
   - 6210 (possibly 6260): task file registers are inaccessible until bu=
smaster
		 engine is stopped.
   - possibly all: both channels share internal resources. Serialization=
 is
		 required.

------------------------------------------------------------------------=
--------
 0x1055 SMSC
   0x9130 SLC90E66		     ?	 x   ?	  ?   ?     x	x   -	-    x

------------------------------------------------------------------------=
--------
 0x1166 ServerWorks
   0x0211 OSB4			     x	 x   ?	  ?   ?     x	-   -	-    x
   0x0212 CSB5
     < 0x92			     x	 x   ?	  ?   ?     x	x   -	-    -
    >=3D 0x92			     x	 x   ?	  ?   ?     x	x   x	-    -
   0x0213 CSB6
     < 0xA0			     x	 x   ?	  ?   ?     x	3   -	-    -
    >=3D 0xA0			     x	 x   ?	  ?   ?     x	x   x	-    -

 known bugs:
   - OSB4: at least some chip revisions can't do Ultra DMA mode 1 and ab=
ove
   - OSB4: some chip revisions may get stuck in the DMA engine in Ultra =
DMA
	   with some disks
   - CSB5: no host side cable type detection (vendor specific).
   - CSB6: no host side cable type detection (vendor specific).

------------------------------------------------------------------------=
--------
 0x1045 Opti
   0xC621     n/a		     x	 -   -	  -   -     -	-   -	-    x
   0xC558     Viper		     x	 x   ?	  ?   ?     -	-   -	-    x
   0xD568			     x	 x   ?	  ?   ?     -	-   -	-    x
     < 0xC700 Viper		     x	 x   ?	  ?   ?     -	-   -	-    x
     >=3D0xC700 FireStar/Vendetta?     x	 x   ?	  x   x     x	-   -	-   =
 x
   0xD721     Vendetta? 	     x	 x   ?	  x   x     x	-   -	-    x
   0xD768     Vendetta		     x	 x   ?	  x   x     x	-   -	-    x

 known bugs:
   - C621: both channels share internal resources. Serialization is requ=
ired.
   - FireStar: Ultra DMA works reliably only at mode 0.
	       Update: not even that! Better do MWDMA2 at most.

------------------------------------------------------------------------=
--------
 0x10DE Nvidia
   0x01BC     nForce		     x	 x   ?	  x   x     x	x   x	-    -

 known bugs:
   - nForce: no host side cable type detection.

------------------------------------------------------------------------=
--------
 0x100B National Semiconductor
   0x0502 SCx200		     x	 x   ?	  x   x     x	-   -	-    -

 known bugs:
   - all: busmaster transfers need to be 16 byte aligned instead of word=

	  aligned.








~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Daniela Engert, systems engineer at MEDAV GmbH
Gr=E4fenberger Str. 34, 91080 Uttenreuth, Germany
Phone ++49-9131-583-348, Fax ++49-9131-583-11


--_=_=_=IMA.BOUNDARY.GVJBTU138764=_=_=_
Content-Type: application/octet-stream; name="ChipList.zip"
Content-Transfer-Encoding: base64

UEsDBBQAAgAIAC9WoSwE6ONEeAoAAJorAAAMABEAQ2hpcExpc3QudHh0VVQNAAcarM887irSPBqs
zzzFWtty2zgSfVaq8g/tvDipsSzedanNpHRJKq6NJ94ok2QfIRGyUKZIDUHK9JY/frtB8CJbti5e
zcplUqJwDkCw+3Q3IPjBQz+KX7+CexjxlZhy9fYevuEHKaKw0WiAevW/9wG+DPpOR72/uoDyuuep
k2nbGnwPMkqTeWseyQQmsfCvOQhfEV1dfIXRZV/9lx8IbdsIIxbDuMd2o2gqS7ZNfDFfnROhbU1E
AgS5b1Tv6dN9cWQrJoIa2X1xU/cNDYT8/BCIJ4Stir8CtmrgJ3XKz/riqjzC6vUrBBpZx+h4cBEm
nLoHvGBatoG3ffGr4MoakOHpA36ic6YuNhvN8giZggL8Awyrhspb5Ijm0yjqtOMMHfga49N8/apB
PM6+PEbWNsx84DasjzzbNnLEmqapsM6z2GwzttvV2Mtfu6LfZu803HKw64vh58bz0GxDx56xH7Le
qaWgRmPv27UcZ0BQa4duM9XnOrivwLCIJiLgB1G4Axg2kQQOQnfU6O3DRt9Ro7dfMvqh6t/ZpX91
VA8N0TdhdBvCJL2WwEIfZpwlacxlTxE3c8PvoQotOEznYinhdBbF1zw5hSQCJiWPE0jmHC6+/Uu1
SsSCy3P4PueyQLCYQxgl5IL48nnCpwmbBKiMITB/xcIpP9fd0TP8rYdt5FIkXBH7qIdn6h1qZAtF
EqZsqeCaPZARXgqxYd6CxPj1q+b/+KVUzTQND35c9AtNc9sm4P/uktbUSEMja1pluB1Pq1RmGQD4
cR+lbMDv70tgvzWA/RywGEO3HINJVF2v1d/HlfNRaOhgT+nRY/A6a2PwHs7DMyNoFkAnB/b3GUE+
do0c7OJHj+ONZZsN+PGdzrArQbNGYBttRxPYcMgIbNPoFgTTg0ZgOu2CgO2oJUSwJiWFerAg6AH6
Pqj8RQofnVa5bnK35FoJMDifrzUnV5+kcsFkwmM4ZdhkxU+BEhw/4jI8TWDBkulcNcRvUxbU2suE
JaWckBGimkSESaJUY6rGMb8W9EbitxFwFgd3wGb0jcDUJY7TpVatNQomb2Yo0zX0hKMocuw7Wi5F
eL3ey4keDFoV5W7gGC3HVGKrDYUumkYL4/WcrXLRuxpewDRSA8D5oTk9OZ6oGYMu9L8ILU2uZXXh
ko5V+oW68kDjnk6cimwgBw7RH0zXts/w6NgfW5+eYcmeZrEaCj/cPIjs20Z4g5B2K39jFhTNj09z
IOzpMTjqTly6E9c+20yyWViKngdnimGkWd+/r1hHv8FWxgfu/js8DT/AV4lGWeWEJ2i1PVix+I6M
GWP6PPIlRLMd3ThdUm6gbrlXczYeXouQVw5NnppK5ddCokiEszRUPCxQc0bpwZ9BEjMqlBYR5gQb
O8DQf5ro4I+1GTW+jTF5KFvrp95DxpJu+G2I6QOf3uC4ZlgjSbgVyRyiwMcLP0dD8IW8ecAwyIhi
kdIUoKOvyQjzNQPGLwMHjpeZTzOGnzvnR3RduwtjMS5c1zVtoEPNbEfG/gUXxcEtuCdSiN/fqyzC
Np7HZht8jAxahf9dwNkjsNdqOx4dXXMXeM0V6AnnDx5n8sXR4mhPuuvC8HLUGotATDEkXCzYNS+y
SQ+zFvwS8KxvvlnVt83n62S0V8Bbm6WSn1R8tuarmZJ9kCHZ+5qR6t7T3Xv/n+47uvvOrmZcB3c1
uLtrClnVz5j7GmiFF5grGLsWctT1RkFHY+gpC+ahEmsSWlQkuiI5mpCP+o4iyMKQB6TAaMEsEdNz
+HeUQsi5TyKrRFLlQJMI5U1ibMCYgFWgcaqCxal5Cpj7AINltEwDzL38gvO8Po5Yr6qBUSZxt1F8
g9cDgaO7W5d2fPC9vEPNJUHOqYxUjoYBAnEySuMplZpjHgsWiP8wlSoJqUYb879SEXP/mNrr9uEq
jhZCFn7ojDBrvxoNLcNCC9bhxrYf2VBzY8pT2hDSdDSNZxU0nrduDyc5R74M8IQt1njs/XlqZjmi
tbucyC2IsBLfzpQ9urOSqP0yIq+8tU6NCL7/svb0Oc8qqdrGy6hwVN1iVN2SCm1iF6qsfn+eVTK1
zUOYqkGZVtstqNyXUbk1Ku9F99euMbUPHtRG2csVpHiKRTwXUqaoe+mSx7MgjTDvpCV4bBPKGQZw
Si9J3NLlgySz4hEzFLw7zHZpr4D0UoQiUcKTK2WRW57BXaWfWouQWeluqbYz1eiWhZRpYMcBZtBw
mQaJ+BnFvkpidRJZDEc7b0uNhen9iCIzrm6E+qWVPOAZXoM3N2J682YjR5Uuy3mUBn6ux2yKZaev
atgIforQj24l+DEm7LE8w3lW96HvKs+G1ABUAME2d/BG0liu+ZtjKm8bA/RdLEqhMw0Lhr/crXnn
utg+vWRR5XzFxMoyIk44mB5M7hKObcV1iFdr+T5Ooq+mR3+3trTB1HRPgmh6Q209559igGX+gmNx
hTPLJEZHIibbUvZCzfOy6ZhLmjZ8FtfzqwiDazGhhuHA56vvYHtZy26XGzHvDVNf9g5Z27M0uLMz
uLYyZefgtnHIypxTgPv7JmUK7mq4tU9SVsxkCe7vtTZfwL0cblgHodu6c/MgdKduBOCnLKjmpGB2
XpyoIg8aFOaImFBGC1WP0xZEXlBLjrKCCd9aQf4AQatl6LJAjoUKTt4zZZKrbBcrtSBCOZuksUwe
EVwMLmH0/QtqICaRXCudzIv8iYoIpbRXYuvC25OTd/QFSabe1igzWWDJQ4ADcsmPm4taFvQvR0V0
ddBP8SNsLYY3bE0guKvB3t7lT5t2HRWYtsYvr3at5GsETkHQIYJfBzB4+fg7pmnujH5qVQwnobf7
ArZqPcboGfAyjq+VO1ig5OsGtHdVFkWlWbaVUWMoaaklLFhiXc4TrMEqk0Q/oAGoUORz2q5Dc59R
LpKH5cIXYp6QRR/R5swuPqmPw1Y/TqJlXe7wIniWuSEWf4D8/wnTU2qXo70t6Gwjuv0idFejO0bL
62AhvpViy4oqzQG8XUZSCtIFGta7nto+gAf7B3lpi7kXV205pGEiarsaaj1Ur59ioqX2Garcouwh
z10OL5sbf0/Z7ML4cjzU8941sSQcfxl2jY9lUvFh61PLjmjWqFw4Nxh10IVvZGEeFgrb1/HAaexs
1VkFxex0PHBrq7Jdq7GnheZLqzvhsgeWbZk29V9bS8v6xhYee3P/W3E7SCrNYo+iZMAZiWrx04JK
Dqs1/QeBNN82Y5NoxdfINnEs2B1cc1qrTzHdfpRQl7sLdC2P4Xm+QVQq2dA90JPbIQTA25X6QRmF
+qmYiem784rAO5TgaE7ouPB1mRR7fkOUKvUAwxZ7/AOp5vM/kBq6bkd9+0Ngdf2ceWyEj1yqB/ZD
6R25tmEc1Gm+w6Hgn1DtxgmLW/RzQJ4k7MOeq8Wjtp66iqCxN4XXWaN4cRFLz/PwSFCPAoqumKRe
zR8pnZFV0huFeear3NQ4L5JigD+XPks42X8CmMqTG7LkBAZqk5Fc/PIn0lk5VibHtPnRR/hjJXzB
ymWDwTC3+k8RzsSLc8WcZrd08Wg3aQzgD5bvouKDXdBekZ9OE/VL1/wnPliGj4eZZRj7lAZ/01oJ
/f0XUEsBAhcGFAACAAgAL1ahLATo40R4CgAAmisAAAwACQAAAAAAAQAgALaBAAAAAENoaXBMaXN0
LnR4dFVUBQAHGqzPPFBLBQYAAAAAAQABAEMAAACzCgAAAAA=

--_=_=_=IMA.BOUNDARY.GVJBTU138764=_=_=_--
