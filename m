Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264267AbTLVBS5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 20:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264272AbTLVBS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 20:18:57 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:19131 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S264267AbTLVBSy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 20:18:54 -0500
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Mon_Dec_22_01_18_51_UTC_2003_0@merlin.emma.line.org>
Content-Type: text/plain; charset=US-ASCII
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 7BIT
Message-Id: <20031222011851.88A5A97558@merlin.emma.line.org>
Date: Mon, 22 Dec 2003 02:18:51 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:
ChangeSet@1.108, 2003-12-22 02:17:46+01:00, matthias.andree@gmx.de
  Only print ignoremerge warning if ignoremerge is really enabled.

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
# shortlog |   13 +++++++++----
# 1 files changed, 9 insertions(+), 4 deletions(-)

##### GNUPATCH #####
# This is a BitKeeper generated patch for the following project:
# Project Name: BK kernel tools
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.107   -> 1.108  
#	            shortlog	1.80    -> 1.81   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/12/22	matthias.andree@gmx.de	1.108
# Only print ignoremerge warning if ignoremerge is really enabled.
# --------------------------------------------
#
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Mon Dec 22 02:18:51 2003
+++ b/shortlog	Mon Dec 22 02:18:51 2003
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.207 2003/12/21 03:10:50 emma Exp $
+# $Id: lk-changelog.pl,v 0.208 2003/12/22 01:17:09 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -2062,9 +2062,11 @@
 if ($opt{count}) { $opt{compress} = 1; }
 
 # --ignoremerge is deprecated
-print STDERR "--ignoremerge is deprecated and will be removed. Replacement:\n"
-   . 'bk changes -d\'$unless(:MERGE:){<:P:@:HOST:>\n $each(:C:){\t(:C:)\n}\n\''
-   . "\n";
+if ($opt{ignoremerge}) {
+    print STDERR "--ignoremerge is deprecated. Replacement:\n"
+    . 'bk changes -d\'$unless(:MERGE:){<:P:@:HOST:>\n $each(:C:){\t(:C:)\n}\n\''
+    . "\n";
+}
 
 # Set the sort function
 $namesortfunc = \&caseicmp;
@@ -2154,6 +2156,9 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.208  2003/12/22 01:17:09  emma
+# Only print ignoremerge warning if ignoremerge is really enabled.
+#
 # Revision 0.207  2003/12/21 03:10:50  emma
 # Mark --ignoremerge deprecated, point towards bk changes -d'$unless(:MERGE:)' instead.
 #

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.108
## Wrapped with gzip_uu ##


M'XL( 'M&YC\  \V474_;,!2&K^M?<40K 6));2=I6F]%#%H!8A,HP%UOW.2T
MC9HX49R6(L)_G]ORL7:@:6,7<RQ;MH^/_+Q^XSK<:BQ$+95E.8FEMJ6*"D12
MA[-,EZ(V3A=VM!P&66:&33W3V)QBH3!I'E^8:JT'5IEEB28F\$J6X03F6&A1
M8[;S,E/>YRAJ0?_T]MO7@)!N%TXF4HWQ&DOH=DF9%7.91/HH1S6>Q<HN"ZET
MBJ6TPRRM7F(K3BDW'^,.;7F=BG=:GE<A1\\+72:'?MO'D),MGJ,UQV8:AW'.
MEJWG5R8?9:0'S&:T#=1I,M[D'"@7S!=NZX R02F\G14.&%B4',,_9C@A(5RJ
MY![R(E8EQ&.5%9AB,4:XDX6*U1CBT<9TK*% F9@MJ.0PP<@F%\ XX^3J56UB
M_6$AA$I*#E_Q)EF*6VQZDA5EDHW7:!YK4]_U6;MRF-_QJA%VY"CT:4=2C.0P
M>D?(C2S+VS$2,=_U*L]Q_?;*,\\1&Y;Y\'G>L\OV>=9N:56NXU-WY98V^\4L
MWF_,T@'+_6_-LE;Z$JSB;K&LUL)8YUF&OW!.CS%@Y'S5UJ%Q'@E(IE:X@C,9
M[3SY- =J<_/3+35^5I(ME:0=P#25T%_DT" ];O#!(>>F]\$CAF:OD>7EPT],
MC_OP0,"4M0C7-[U^$,".96UQ1Y@7&,K2,$. >2)#LZ9*,5 [J^TV[ ZGL#ZE
M!BL:[#9F*D&M]\3W?G#:%_L/7\25.!)GE]<WXG"@H($RG.R)$[,R*%?]0#T.
MU&!W]RGACLG]F3R:XS.O!<MG,<!YK.-,/>&_R;\2P,1^^&;KKT]S.,%PJF=I
0=]0><4-.R0_^=4\9!08     
 

