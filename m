Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264659AbSLZXhj>; Thu, 26 Dec 2002 18:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264673AbSLZXhj>; Thu, 26 Dec 2002 18:37:39 -0500
Received: from are.twiddle.net ([64.81.246.98]:51848 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S264659AbSLZXhi>;
	Thu, 26 Dec 2002 18:37:38 -0500
Date: Thu, 26 Dec 2002 15:45:42 -0800
From: Richard Henderson <rth@twiddle.net>
To: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [FB PATCH] fix up readq/writeq usage
Message-ID: <20021226154542.A21454@twiddle.net>
Mail-Followup-To: linux-fbdev-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm in the process of getting tgafb to compile again on Alpha.
I ran into these little buglets in the process.  Please apply.


r~



You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.955, 2002-12-26 15:27:03-08:00, rth@are.twiddle.net
  [FB] Fix minor typos wrt readq/writeq support on 64-bit targets.


 drivers/video/cfbcopyarea.c |    2 +-
 include/linux/fb.h          |    2 ++
 2 files changed, 3 insertions, 1 deletion


diff -Nru a/drivers/video/cfbcopyarea.c b/drivers/video/cfbcopyarea.c
--- a/drivers/video/cfbcopyarea.c	Thu Dec 26 15:31:03 2002
+++ b/drivers/video/cfbcopyarea.c	Thu Dec 26 15:31:03 2002
@@ -38,7 +38,7 @@
 #define BYTES_PER_LONG 4
 #else
 #define FB_WRITEL fb_writeq
-#define FB_READL  fb_readq(x)
+#define FB_READL  fb_readq
 #define SHIFT_PER_LONG 6
 #define BYTES_PER_LONG 8
 #endif
diff -Nru a/include/linux/fb.h b/include/linux/fb.h
--- a/include/linux/fb.h	Thu Dec 26 15:31:03 2002
+++ b/include/linux/fb.h	Thu Dec 26 15:31:03 2002
@@ -424,9 +424,11 @@
 #define fb_readb __raw_readb
 #define fb_readw __raw_readw
 #define fb_readl __raw_readl
+#define fb_readq __raw_readq
 #define fb_writeb __raw_writeb
 #define fb_writew __raw_writew
 #define fb_writel __raw_writel
+#define fb_writeq __raw_writeq
 #define fb_memset memset_io
 
 #else

===================================================================


This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch21401
M'XL(`#>1"SX``[U5R6[;,!`]FU]!()<6A21N6@$'CK.T00(T<)%341B42%MJ
M+-&A:#LI]/&EY,#.UK@)FFH#-!H.W\R;-]J#E[7424^;'.S!+ZHV28]KZ9I5
M(<1,NI4TUCY2RMJ]7)72LY[>\,PS4^X0UP?VZP4W60Z74M=)#[MT8S&W<YGT
M1L>?+\\/1@#T^_`PY]54?I,&]OO`*+WD,U$/N,EGJG*-YE5=2L/=3)7-QK4A
M"!%[^CBDR`\:'"`6-AD6&'.&I4"$10$#95%-U4#.C'3SQ:/5F!!F0U!"&AKZ
ME($CB-W8]R$B'B8>"2#V$Q(FB#HH2A""-L?!HRK`3P0Z"`SAOX5]"#+X_63X
M`YX4-]#FH'1;-E7#E3902RZNO94NC+R&]6(^5]:H*A@P)RT,-%Q/I:E=<`9I
M2$@$+K8%!LXK#P`01V!_1WI%E<T60GJSHEK<>)/4S>_G&3/<H""FI`D0B5,A
M4IF&4C+.GJOHGX)9M@++%;7E0@A%+:B?=5&6JJH'N2QJ6:523]?`EH4V"S[K
ML`E=M#WH+0LAE9=-TDS-;^V>%OD:I(\9CDCLDX;@(`B:<()$2L.,3&3$)'T6
MXZZ@]\!2&J&H:_,7%K6-_U^RV>YRI7Z5ROU0J4I^_(M\[.W3`,<-90C%G50P
M>:@4FK#P):5@Z.!W44HKDI/A>'1\<'0.G7TX2<>=1CK-=#KH./@*';WJ+MO7
M%R_1\0:9'#$,,3CMGGM"3HI*;C%M$'5]\+3!=\^]MRH,"+Z4Y:!:V(%0%=45
MWR$QW$9DM/'CV%\/1!*]CN5WFX<'0FSJ:#&/[P;@NM8UG-@9:9O9J>=<9RWI
M=D0\8OQIVF\@^I2UA=APO.FU\5CSU1W+UB=^Z','=NVT?MG^([-<9E?UHNRS
/B8A)QD+P&R+@>RV`!P``
`
end
