Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262662AbSLaIzS>; Tue, 31 Dec 2002 03:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265102AbSLaIzS>; Tue, 31 Dec 2002 03:55:18 -0500
Received: from fmr05.intel.com ([134.134.136.6]:28143 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP
	id <S262662AbSLaIzR>; Tue, 31 Dec 2002 03:55:17 -0500
Message-ID: <957BD1C2BF3CD411B6C500A0C944CA2601AA137F@pdsmsx32.pd.intel.com>
From: "Zhuang, Louis" <louis.zhuang@intel.com>
To: "'torvalds@athlon.transmeta.com'" <torvalds@athlon.transmeta.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: [Bug fix] forget to reset 'field_width' in vsscanf()
Date: Tue, 31 Dec 2002 17:01:28 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linus,
        I found the vsscanf forgets to reset field_width variable. It will
caused some strange behavior in some conditions ("%15s %s %s" for example).
The following patch fixes the bug, please apply.
Louis Zhuang
I'm only myself, not others.

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.975, 2002-12-31 15:53:28+08:00, louis@hawk.sh.intel.com
  fix bug -- forget reset 'field_width' in vsscanf()


 vsprintf.c |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/lib/vsprintf.c b/lib/vsprintf.c
--- a/lib/vsprintf.c    Tue Dec 31 15:55:16 2002
+++ b/lib/vsprintf.c    Tue Dec 31 15:55:16 2002
@@ -559,6 +559,7 @@
                }

                /* get field width */
+               field_width = -1;
                if (isdigit(*fmt))
                        field_width = skip_atoi(&fmt);


===================================================================


This BitKeeper patch contains the following changesets:
1.975
## Wrapped with gzip_uu ##


begin 664 bkpatch1507
M'XL(`&1-$3X``]6436O<,!"&S]:O&,@A+<&V1A_VVL5EV[2DH84N6W(JI6AM
M>6WBM19+N]N"?WP50Y,T'X2&7FH9'33#S#N/7G0$%U8/>="976O)$7PPUN5!
MHPZ7D6VBMG>ZBTJS\9&E,3X2-V:CXRD[9I$,ZY;XV$*YLH&]'FP>8,2O3]S/
MK<Z#Y?NSBT]OEH04!9PVJE_K+]I!41!GAKWJ*CM7KNE,'[E!]7:CG;IJ.5ZG
MCHQ2YI?$E%.9C)A0D8XE5HA*H*XH$[-$D$G4_)[T.W60<:12"D9'(9!)\@XP
MRE()E,7(8HZ`,I<\9[,3.LLIA4?*P@E"2,E;^+=#G)(2ZO8'K'9K"$.HS;#V
MK`9M_7Y<M[JKOA_:RC7'T/:PM[94??WB)?D(@LLL(XL;P"3\RX\0JBAY_<1`
M7;N*]W8[>!!U5-Z>*N/9F'#.Y%AKE;&5$J*N54*Y>HSA0\6F^TDE9VP4,D6<
M7/-GWM/6>8Y(,E35KN_4=FYLU44>_-??3;X]*!3IC#&<349BDDY&0G[/1^P_
M\]$$_3.$PV'ZO2\6=_@_PUGG,O%`2!#<:@T%A/CJYODH&UU>VMVFD"N5")9*
*\@LN%5J+G00`````
`
end
