Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265205AbSL0XBa>; Fri, 27 Dec 2002 18:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265222AbSL0XBa>; Fri, 27 Dec 2002 18:01:30 -0500
Received: from are.twiddle.net ([64.81.246.98]:31369 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S265205AbSL0XB2>;
	Fri, 27 Dec 2002 18:01:28 -0500
Date: Fri, 27 Dec 2002 15:09:34 -0800
From: Richard Henderson <rth@twiddle.net>
To: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [FB PATCH]
Message-ID: <20021227150934.A3005@twiddle.net>
Mail-Followup-To: linux-fbdev-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got link errors due to a missing fb_blank function.  The best
I can figure is that you were intending to call the fb_blank 
fbops hook.  Certainly that seems to work.

I'm not sure how no one else ran into this. 



r~



You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.957, 2002-12-27 15:04:08-08:00, rth@are.twiddle.net
  [FB] fb_blank is an fbops hook, not a standalone function.


 drivers/video/console/fbcon.c |    2 +-
 include/linux/fb.h            |    1 -
 2 files changed, 1 insertion, 2 deletions


diff -Nru a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
--- a/drivers/video/console/fbcon.c	Fri Dec 27 15:05:10 2002
+++ b/drivers/video/console/fbcon.c	Fri Dec 27 15:05:10 2002
@@ -1993,7 +1993,7 @@
 			update_screen(vc->vc_num);
 		return 0;
 	} else
-		return fb_blank(blank, info);
+		return info->fbops->fb_blank(blank, info);
 }
 
 static void fbcon_free_font(struct display *p)
diff -Nru a/include/linux/fb.h b/include/linux/fb.h
--- a/include/linux/fb.h	Fri Dec 27 15:05:10 2002
+++ b/include/linux/fb.h	Fri Dec 27 15:05:10 2002
@@ -449,7 +449,6 @@
 
 extern int fb_set_var(struct fb_var_screeninfo *var, struct fb_info *info); 
 extern int fb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info); 
-extern int fb_blank(int blank, struct fb_info *info);
 extern int soft_cursor(struct fb_info *info, struct fb_cursor *cursor);
 extern void cfb_fillrect(struct fb_info *info, struct fb_fillrect *rect); 
 extern void cfb_copyarea(struct fb_info *info, struct fb_copyarea *area); 

===================================================================


This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch2996
M'XL(`*;<##X``[55VVZ<,!!]7G^%I;RT:H"Q,==JHS3I+4JE1EOEJ:HJ`[.!
M+M@1F$TJ\?'UDC;73;9)&T`@;#,^,^><88L>=]BFD]:49(M^U)U))[)%UYQ5
M15&CJ]#8\9G6=MPK=8.>7>GM'7KF1#K<#8B=/9(F+^D2VRZ=,->_'#$_3S&=
MS-Y]./[T9D;(=$KW2ZE.\`L:.IT2H]NEK(MN5YJRULHUK51=@T:ZN6Z&RZ4#
M!^#V#%CD0Q`.+`01#3DK&)."80%<Q*$@%M;N+>"W8C#.0^X'(42#+R*(R%O*
MW"2(*'"/<8]'E`4IB!1B!^(4@*X)25]QZ@#9H_\7_#[)Z=?W>]_H//N>U5(M
M:-51J>RK/NUHJ?5BFRIMJ*2=D:J0=D>D\U[EIK)[DT/J^R*)R=%5@8GSR(,0
MD$!V-B16J;SN"_3J2O7GWCQSR^L9)H(-$"8^'T+@2584&681HI!B72WO"V9Y
MBK@/?K`*$P';"*IHJY7XO&55H+9Q<KLBOX9+``L''M@*#3P*YTD""<;9/!09
M6XOK9CP;K=,UWHA[#:(?1'$\BOO!SS8+_A^R(#^ZJFGLAKN-/#_#NG91VL1L
M71=_G1`DW+J"Q]8;(<2C-X+DIC7\-.`/68-1ASV+-0[44B_PRAS+2EY88Y3^
M2,!GZK1GXV6E?/0P%T_PQEN6)"%EY.#W<S)IT?2MHI6::V=G!+-Z7`!\,=ZW
MQ\F7KT=QW-7Z9D4\U6QK>^']9K--<47]```QC,3S1Q(/ST7\#!N]1-JKOL/B
MBO\"\UJV\D_SN^@2MQ1P-]^GT"X";MF^_*/E)>:+KF^F++:E$WE`?@&"R\7O
$0`<`````
`
end
