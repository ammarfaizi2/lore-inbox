Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316408AbSG3UPg>; Tue, 30 Jul 2002 16:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316430AbSG3UPg>; Tue, 30 Jul 2002 16:15:36 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:34514 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S316408AbSG3UPd>;
	Tue, 30 Jul 2002 16:15:33 -0400
Date: Tue, 30 Jul 2002 22:18:52 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linuxconsole-dev@lists.sourceforge.net
Subject: [patch] Remove superfluous code that snuck back in PPC merge
Message-ID: <20020730221852.B22761@ucw.cz>
References: <20020730122638.A11153@ucw.cz> <20020730122918.A11248@ucw.cz> <20020730152255.A20071@ucw.cz> <20020730152342.B20071@ucw.cz> <20020730221722.A22761@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020730221722.A22761@ucw.cz>; from vojtech@suse.cz on Tue, Jul 30, 2002 at 10:17:22PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.531, 2002-07-30 22:04:17+02:00, Franz.Sirl@lauterbach.com
  Hi Vojtech,
  some superflous keyboard stuff came back with the last PPC merge
  to Linus. This patch fixes that. Please apply.

 lopec_setup.c |   13 -------------
 1 files changed, 13 deletions(-)

diff -Nru a/arch/ppc/platforms/lopec_setup.c b/arch/ppc/platforms/lopec_setup.c
--- a/arch/ppc/platforms/lopec_setup.c	Tue Jul 30 22:17:44 2002
+++ b/arch/ppc/platforms/lopec_setup.c	Tue Jul 30 22:17:44 2002
@@ -34,14 +34,9 @@
 #include <asm/mpc10x.h>
 #include <asm/hw_irq.h>
 #include <asm/prep_nvram.h>
-#include <asm/keyboard.h>
 
 extern char saved_command_line[];
 extern void lopec_find_bridges(void);
-extern int pckbd_translate(unsigned char scancode, unsigned char *keycode,
-		char raw_mode);
-extern char pckbd_unexpected_up(unsigned char keycode);
-extern unsigned char pckbd_sysrq_xlate[128];
 
 /*
  * Define all of the IRQ senses and polarities.  Taken from the
@@ -384,14 +379,6 @@
 	ppc_md.find_end_of_memory = lopec_find_end_of_memory;
 	ppc_md.setup_io_mappings = lopec_map_io;
 
-#ifdef CONFIG_VT
-	ppc_md.kbd_translate = pckbd_translate;
-	ppc_md.kbd_unexpected_up = pckbd_unexpected_up;
-#ifdef CONFIG_MAGIC_SYSRQ
-	ppc_md.ppc_kbd_sysrq_xlate = pckbd_sysrq_xlate;
-#endif /* CONFIG_MAGIC_SYSRQ */
-#endif /* CONFIG_VT */
- 
 	ppc_md.time_init = todc_time_init;
 	ppc_md.set_rtc_time = todc_set_rtc_time;
 	ppc_md.get_rtc_time = todc_get_rtc_time;

===================================================================

This BitKeeper patch contains the following changesets:
1.531
## Wrapped with gzip_uu ##


begin 664 bkpatch22903
M'XL(`&CT1CT``]5486_3,!#]7/^*D_9Q-/'%3M)6*BILP"0F476,K\AQW"74
MJ2/;Z=8J/QZOA56`T#:$D$@BV3[[WEW>>\D)7#ME)X.W5JQWT55M-3F!"^/\
M9*!%YY4MA*PB:9H07A@3PG%E&A5OS!>O9!47J[A>MYTG87\NO*Q@HZR;##!B
M#Q&_;=5DL'CS[OKRU8*0Z13.*K&^45?*PW1*O+$;H4LW$[[29AWYT(IKE!?W
M9?N'HWU":1+N%'-&TZS'C/*\EU@B"HZJI`D?99RT8J/TS'5.17+W<W;(Q'&:
M4-:S/,M3<@X8I0R!)C'-8T8A22:43S`_I6%"X<C*[$<VX!1A2,EK^+O-GQ$)
M%S5\.I#[(JQ<(!M<URJ[U*9SL%+;P@A;@O/=<@E2A.W0U`IN:Q^8KA1HX3S,
MYV?0*'NC`H0W<%FO.Q?!QZIVT.XU6=9WRH7SPD<PUTHX!:)M]38B[X&-^"@G
M\Z-*9/C,BQ`J*'D9:G6Z<S,?<$QT6$1FIT41!GO3"QL<U+8R;K7P2V,;%VO3
M*OG9*=^UD?S&&E+$!%/L&4MPW)>295B6DLNDR)*4_UZE)Q8(DH21(^\SRCC?
M._2QS'OC_I.W^U[%B:80S\#-DXR.$%G`33,VWEL=?W4Z?]SI%(;(_@.K'XT>
MP)YH]8/@'V!H;_=/L.[\4>W_X',X9SD@.><(/,Q'.8R./TQ9*;ER73,MTIR/
-QV-)O@+`_N;.E04`````
`
end

-- 
Vojtech Pavlik
SuSE Labs
