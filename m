Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319577AbSIMJLM>; Fri, 13 Sep 2002 05:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319579AbSIMJLM>; Fri, 13 Sep 2002 05:11:12 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:59793 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S319577AbSIMJLI>;
	Fri, 13 Sep 2002 05:11:08 -0400
Date: Fri, 13 Sep 2002 11:15:23 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Minor input fixes [7/7]
Message-ID: <20020913111523.A28504@ucw.cz>
References: <20020913110453.A28145@ucw.cz> <20020913110600.B28378@ucw.cz> <20020913110641.C28378@ucw.cz> <20020913111014.A28426@ucw.cz> <20020913111051.A28479@ucw.cz> <20020913111130.A28494@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020913111130.A28494@ucw.cz>; from vojtech@suse.cz on Fri, Sep 13, 2002 at 11:11:30AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.596, 2002-09-12 23:16:06+02:00, Franz.Sirl-kernel@lauterbach.com
  I needed this small patch if i8042.c is built as a module. Franz.
  Exporting kbd_pt_regs in keyboard.c.


 Makefile   |    2 +-
 keyboard.c |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

===================================================================

diff -Nru a/drivers/char/Makefile b/drivers/char/Makefile
--- a/drivers/char/Makefile	Thu Sep 12 23:39:22 2002
+++ b/drivers/char/Makefile	Thu Sep 12 23:39:22 2002
@@ -13,7 +13,7 @@
 # This list comes from 'grep -l EXPORT_SYMBOL *.[hc]'.
 
 export-objs     :=	busmouse.o console.o generic_serial.o ip2main.o \
-			ite_gpio.o misc.o nvram.o random.o rtc.o \
+			ite_gpio.o keyboard.o misc.o nvram.o random.o rtc.o \
 			selection.o sonypi.o sysrq.o tty_io.o tty_ioctl.o
 
 obj-$(CONFIG_VT) += vt.o vc_screen.o consolemap.o consolemap_deftbl.o selection.o keyboard.o
diff -Nru a/drivers/char/keyboard.c b/drivers/char/keyboard.c
--- a/drivers/char/keyboard.c	Thu Sep 12 23:39:22 2002
+++ b/drivers/char/keyboard.c	Thu Sep 12 23:39:22 2002
@@ -66,6 +66,7 @@
 #endif
 
 struct pt_regs *kbd_pt_regs;
+EXPORT_SYMBOL(kbd_pt_regs);
 void compute_shiftstate(void);
 
 /*

===================================================================

This BitKeeper patch contains the following changesets:
1.596
## Wrapped with gzip_uu ##


begin 664 bkpatch25401
M'XL(`(H)@3T``\U5:V_3,!3]7/\*2_L"FNK83N(D145E#V!BTZJ.22`A54[B
M-J%)7-E.85-^/$Z8EL&FCFX@X3P</W1U?.\Y)WOP4@LU&FSD5R.2#.S!]U*;
MT4#76J#DVHYG4MJQD\E2.#>[G'CEY-6Z-L"N3[E),K@12H\&!+FW,^9J+4:#
MV?&[R],W,P#&8WB8\6HI+H2!XS$P4FUXD>H)-UDA*V04KW0I#$>)+)O;K0W%
MF-K+)X&+?=80AKV@24A*"/>(2#'U0N:!../*QHKSY5I6*:J$0;S^/4I$*`X\
MSP\:/PP\!HX@07[$(*8.CAQ"(75'A(TPV\=TA#%\:R%=HXM<%<.54)4H)@6O
MC5`Q3[(6)=RG<(C!`?R[9SD$"3R!E1"I2*')<@UUR8L"KKNTY@N8A]BC*(%V
M):[SPD"N(8>E3.M"H!O4-L;Q][54)J^6<!6G\[69*['4,*_@2ES%TN8+)0A\
M@(RX(0'3OCI@N&,#`',,7C^2AE3E+4F<Q);*Z2'<28J'L=?X?D2B1GA)B@6+
M:;H0BX7+'JW%]O"V\I38=+L-]B+L[8;UC*_$(B_$/:2,4=(D@<O](**A;<QE
MZ8Y(?PW>XV2V"SK5/+C]<04]XPA`\W*B^*:*I5HB^VR'3(B5%`T;A@F-.E&Y
M]S7E_K&F"!R2_U13K5C:LIS#H?K6W9;\TX<K]`05'1$&"3CIWH/!(#=BOESG
M$LE>L1*6N4YL5VT4+VUO@:6R^S#M])?[E.FUL"-I=M4H2/E&E).J-AI5>;7B
MK0UO#QG2UI,980VFOD\Z\I#@>>3Y-X;\TTSO.FE+A\Y,MK&A/_`3^'#"0LN$
LXT_3\]G'^<7GLX/STQ=W`+Q\U?]^DTPD*UV7XSA86(N+*?@!INML2=D'````
`
end

-- 
Vojtech Pavlik
SuSE Labs
