Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263166AbSJHNrp>; Tue, 8 Oct 2002 09:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263187AbSJHNrl>; Tue, 8 Oct 2002 09:47:41 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:55444 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S263166AbSJHNpt>;
	Tue, 8 Oct 2002 09:45:49 -0400
Date: Tue, 8 Oct 2002 15:51:25 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] Fix aux detection on some notebooks [14/23]
Message-ID: <20021008155125.M18546@ucw.cz>
References: <20021008154132.C18546@ucw.cz> <20021008154246.D18546@ucw.cz> <20021008154415.E18546@ucw.cz> <20021008154549.F18546@ucw.cz> <20021008154631.G18546@ucw.cz> <20021008154733.H18546@ucw.cz> <20021008154824.I18546@ucw.cz> <20021008154904.J18546@ucw.cz> <20021008155003.K18546@ucw.cz> <20021008155045.L18546@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021008155045.L18546@ucw.cz>; from vojtech@suse.cz on Tue, Oct 08, 2002 at 03:50:45PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.573.1.47, 2002-10-01 20:41:21+02:00, vojtech@suse.cz
  Accept 0xfa as an "OK" result code for AUX TEST cmd in i8042.c.
  This makes mouse work on certain notebooks.


 i8042.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

===================================================================

diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	Tue Oct  8 15:26:07 2002
+++ b/drivers/input/serio/i8042.c	Tue Oct  8 15:26:07 2002
@@ -664,11 +664,13 @@
 /*
  * External connection test - filters out AT-soldered PS/2 i8042's
  * 0x00 - no error, 0x01-0x03 - clock/data stuck, 0xff - general error
+ * 0xfa - no error on some notebooks which ignore the spec
  * We ignore general error, since some chips report it even under normal
  * operation.
  */
 
-	if (i8042_command(&param, I8042_CMD_AUX_TEST) || (param && param != 0xff))
+	if (i8042_command(&param, I8042_CMD_AUX_TEST)
+	    || (param && param != 0xfa && param != 0xff))
 		return -1;
 
 /*

===================================================================

This BitKeeper patch contains the following changesets:
1.573.1.47
## Wrapped with gzip_uu ##


begin 664 bkpatch18096
M'XL(`._<HCT``\V4;VO;,!#&7T>?XM9":=?%ULF*E1@RVK5E*]UHZ1_8NZ+*
M2NTEMH*D--OPAY_LA!8RUK*QP61C6^?3\>B>']J&&Z=MUGLP7[Q6!=F&#\;Y
MK.<63D?J>YA?&A/F<6$J':^SXKMI7-;SA2?A_X7TJH`';5W6PRAYC/AO<YWU
M+D_>WWP\O"1D/(:C0M;W^DI[&(^)-_9!SG)W('TQ,W7DK:Q=I;V,E*F:Q]2&
M4<K"-4"1T$':8$JY:!3FB)*CSBGCPY23M;"#M>R-]4@I8JB1C!HZ$B-!C@&C
M@4@BC+@`RF*D,45@-..8,=RG+*,4-FK"/D*?DG?P=Y4?$06'2NFY!_IU(D$Z
MD#5LG9]M@=5N,?.@3*YA8BP<WGR&ZY.K:U!5#F4-Y9!R%JDH5+@N2@>5G.KP
M-$$O+(V=@JE!:>MER*V-UW?&3%U$SF`DAI1<//E!^K\Y"*&2DK>/+?++<E;>
M%SY:J&7;_MR6+1`K2.(`6&GBM=I56P1-D`U23)LDN,,:0=N.2%2:<IS0?+/Y
M+U;L+!YR1-$P/DIX!]PSBUH$_YGZGW!\L>*(<4SYD`=,AIRS#E#DFVBB^!6:
M"?3Q?T&S)6SEP3GT[;*[`S(7S]GQ!P2>IFD*2.#U2EP_(`[:VB`F8._":?7$
M/"R+,IQ(Y7UMK`9?:'!SK<AQ*C!4.&U?C/3*">QV<FY#LRI9Y[L[<VEE]09.
MN^C1I^/;L,_;=I][I`=A-`WL=CFPLP.KCU?CE9Z-P&1O[^FP5(564[>HQDF*
-(IB>DQ]F52$6AP4`````
`
end
