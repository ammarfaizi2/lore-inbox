Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbTFIKLb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 06:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbTFIKLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 06:11:31 -0400
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:51720 "EHLO
	krusty.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261292AbTFIKL0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 06:11:26 -0400
MIME-Version: 1.0
To: torvalds@transmeta.com
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Mon_Jun__9_10_24_57_UTC_2003_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20030609102458.1FF24814D3@merlin.emma.line.org>
Date: Mon,  9 Jun 2003 12:24:58 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use bk receive to patch this mail, you can pull from
bk://krusty.dt.e-technik.uni-dortmund.de  (NOTE: no trailing slash)
or you can apply the patch below.

BK: `bk parent`

Patch description:
EDITME

Matthias
##### DIFFSTAT #####
# shortlog |   50 +++++++++++++++++++++++++++++--------------
# 1 files changed, 34 insertions(+), 16 deletions(-)

##### GNUPATCH #####
# This is a BitKeeper generated patch for the following project:
# Project Name: BK kernel tools
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.55    -> 1.56   
#	            shortlog	1.29    -> 1.30   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/06/09	matthias.andree@gmx.de	1.56
# Merge with Linus' upstream additions.
# New addresses.
# Cleanup address list.
# --------------------------------------------
#
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Mon Jun  9 12:24:57 2003
+++ b/shortlog	Mon Jun  9 12:24:57 2003
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.124 2003/06/04 10:31:18 vita Exp $
+# $Id: lk-changelog.pl,v 0.128 2003/06/09 10:20:37 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -67,8 +67,9 @@
 
 # Perl syntax magic here, "=>" is equivalent to ","
 my @addrregexps = (
-[ 'alan@.*\.swansea\.linux\.org\.uk' => 'Alan Cox', ],
-[ 'torvalds@(.*\.)?transmeta\.com' => 'Linus Torvalds', ],
+[ 'alan@[^.]+\.swansea\.linux\.org\.uk' => 'Alan Cox', ],
+[ 'kuznet@[^.]+\.inr.ac.ru' => 'Alexey Kuznetsov', ],
+[ 'torvalds@([^.]+\.)?transmeta\.com' => 'Linus Torvalds', ],
 [ '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~' => '~~~~~~~~' ]);
 
 sub obfuscate(@) {
@@ -91,6 +92,9 @@
 my @addresses_handled_in_regexp = (
 'alan:hraefn.swansea.linux.org.uk' => 'Alan Cox',
 'alan:irongate.swansea.linux.org.uk' => 'Alan Cox',
+'kuznet:mops.inr.ac.ru' => 'Alexey Kuznetsov',
+'kuznet:ms2.inr.ac.ru' => 'Alexey Kuznetsov',
+'kuznet:oops.inr.ac.ru' => 'Alexey Kuznetsov',
 'torvalds:athlon.transmeta.com' => 'Linus Torvalds',
 'torvalds:home.transmeta.com' => 'Linus Torvalds',
 'torvalds:kiwi.transmeta.com' => 'Linus Torvalds',
@@ -154,8 +158,8 @@
 'alex_williamson:com.rmk.(none)' => 'Alex Williamson',
 'alex_williamson:hp.com' => 'Alex Williamson', # google
 'alexander.riesen:synopsys.com' => 'Alexander Riesen',
-'alexander.schulz:innominate.com' => 'Alexander Schulz',
 'alexander.schulz:com.rmk.(none)' => 'Alexander Schulz',
+'alexander.schulz:innominate.com' => 'Alexander Schulz',
 'alexey:technomagesinc.com' => 'Alex Tomas',
 'alfre:ibd.es' => 'Alfredo Sanjuán',
 'ambx1:neo.rr.com' => 'Adam Belay',
@@ -184,6 +188,7 @@
 'arndb:de.ibm.com' => 'Arnd Bergmann',
 'arndt:lin02384n012.mc.schoenewald.de' => 'Arndt Schoenewald',
 'arun.sharma:intel.com' => 'Arun Sharma',
+'aschultz:warp10.net' => 'Andreas Schultz',
 'asit.k.mallick:intel.com' => 'Asit K. Mallick', # by Kristian Peters
 'asl:launay.org' => 'Arnaud S. Launay',
 'atulm:lsil.com' => 'Atul Mukker',
@@ -304,7 +309,6 @@
 'dan:debian.org' => 'Daniel Jacobowitz',
 'dana.lacoste:peregrine.com' => 'Dana Lacoste',
 'danc:mvista.com' => 'Dan Cox', # some CREDITS patch found by google
-'daniel:osdl.org' => 'Daniel McNeil',
 'daniel.ritz:gmx.ch' => 'Daniel Ritz',
 'daniel:osdl.org' => 'Daniel McNeil',
 'dank:kegel.com' => 'Dan Kegel',
@@ -396,8 +400,8 @@
 'erik:aarg.net' => 'Erik Arneson',
 'erik_habbinga:hp.com' => 'Erik Habbinga',
 'eyal:eyal.emu.id.au' => 'Eyal Lebedinsky', # lbdb
-'falk.hueffner:student.uni-tuebingen.de' => 'Falk Hüffner',
 'faikuygur:ttnet.net.tr' => 'Faik Uygur',
+'falk.hueffner:student.uni-tuebingen.de' => 'Falk Hüffner',
 'fbl:conectiva.com.br' => 'Flávio Bruno Leitner', # google
 'fdavis:si.rr.com' => 'Frank Davis',
 'felipewd:terra.com.br' => 'Felipe Damasio', # by self (did not ask to include the W.)
@@ -485,6 +489,7 @@
 'hermes:gibson.dropbear.id.au' => 'David Gibson',
 'hirofumi:mail.parknet.co.jp' => 'Hirofumi Ogawa', # corrected by himself
 'hoho:binbash.net' => 'Colin Slater',
+'hollisb:us.ibm.com' => 'Hollis Blanchard',
 'hpa:transmeta.com' => 'H. Peter Anvin',
 'hpa:zytor.com' => 'H. Peter Anvin',
 'hugh:veritas.com' => 'Hugh Dickins',
@@ -554,7 +559,6 @@
 'jgrimm:death.austin.ibm.com' => 'Jon Grimm',
 'jgrimm:jgrimm.(none)' => 'Jon Grimm',
 'jgrimm:jgrimm.austin.ibm.com' => 'Jon Grimm', # google
-'jgrimm:jgrimm.(none)' => 'Jon Grimm',
 'jgrimm:touki.austin.ibm.com' => 'Jon Grimm', # google
 'jgrimm:touki.qip.austin.ibm.com' => 'Jon Grimm', # google
 'jh:sgi.com' => 'John Hesterberg',
@@ -575,6 +579,7 @@
 'joe:wavicle.org' => 'Joe Burks',
 'joel.buckley:sun.com' => 'Joel Buckley',
 'joergprante:netcologne.de' => 'Jörg Prante',
+'joern:wohnheim.fh-wedel.de' => 'Jörn Engel',
 'johan.adolfsson:axis.com' => 'Johan Adolfsson',
 'johann.deneux:it.uu.se' => 'Johann Deneux',
 'johann.deneux:laposte.net' => 'Johann Deneux',
@@ -644,10 +649,9 @@
 'kronos:kronoz.cjb.net' => 'Luca Tettamanti',
 'kuba:mareimbrium.org' => 'Kuba Ober',
 'kuebelr:email.uc.edu' => 'Robert Kuebel',
-'kumarkr:us.ibm.com' => 'Krishna Kumar', 
+'kumarkr:us.ibm.com' => 'Krishna Kumar',
 'kunihiro:ipinfusion.com' => 'Kunihiro Ishiguro',
-'kuznet:mops.inr.ac.ru' => 'Alexey Kuznetsov',
-'kuznet:ms2.inr.ac.ru' => 'Alexey Kuznetsov',
+'kurt.robideau:comtrol.com' => 'Kurt Robideau',	# wild guess
 'l.s.r:web.de' => 'René Scharfe',
 'ladis:psi.cz' => 'Ladislav Michl',
 'laforge:gnumonks.org' => 'Harald Welte',
@@ -663,15 +667,15 @@
 'lethal:linux-sh.org' => 'Paul Mundt',
 'levon:movementarian.org' => 'John Levon',
 'lfo:polyad.org' => 'Luis F. Ortiz',
+'linux-usb:gemeinhardt.info' => 'Lars Gemeinhardt',
 'linux:brodo.de' => 'Dominik Brodowski',
 'linux:de.rmk.(none)' => 'Dominik Brodowski',
 'linux:hazard.jcu.cz' => 'Jan Marek',
-'linux-usb:gemeinhardt.info' => 'Lars Gemeinhardt',
 'lionel.bouton:inet6.fr' => 'Lionel Bouton',
 'lists:mdiehl.de' => 'Martin Diehl',
 'liyang:nerv.cx' => 'Liyang Hu',
-'lkml:shemesh.biz' => 'Shachar Shemesh',
 'lkml001:vrfy.org' => 'Kay Sievers',
+'lkml:shemesh.biz' => 'Shachar Shemesh',
 'lm:bitmover.com' => 'Larry McVoy',
 'lm:work.bitmover.com' => 'Larry McVoy',
 'lopezp:grupocp.es' => 'Jose A. Lopez',
@@ -730,7 +734,7 @@
 'mec:shout.net' => 'Michael Elizabeth Chastain',
 'meissner:suse.de' => 'Marcus Meissner',
 'mgreer:mvista.com' => 'Mark A. Greer', # lbdb
-'mhoffman:lightlink.com' => 'Mark Hoffman',
+'mhoffman:lightlink.com' => 'Mark M. Hoffman',
 'mhopf:innominate.com' => 'Mark-André Hopf',
 'michaelw:foldr.org' => 'Michael Weber', # google
 'michal:harddata.com' => 'Michal Jaegermann',
@@ -786,10 +790,9 @@
 'nick.holloway:pyrites.org.uk' => 'Nick Holloway',
 'nico:cam.org' => 'Nicolas Pitre',
 'nico:org.rmk.(none)' => 'Nicolas Pitre',
-'nicolas:dupeux.net' => 'Nicolas Dupeux',
 'nicolas.aspert:epfl.ch' => 'Nicolas Aspert',
-'nicolas:dupeux.net' => 'Nicolas Dupeux',
 'nicolas.mailhot:laposte.net' => 'Nicolas Mailhot',
+'nicolas:dupeux.net' => 'Nicolas Dupeux',
 'niv:us.ibm.com' => 'Nivedita Singhvi',
 'nivedita:w-nivedita.beaverton.ibm.com' => 'Nivedita Singhvi',
 'nkbj:image.dk' => 'Niels Kristian Bech Jensen',
@@ -958,7 +961,6 @@
 'scameron:quandary.cca.cpqcorp.net' => 'Steve Cameron',
 'schlicht:uni-mannheim.de' => 'Thomas Schlichter',
 'schlicht:uni-mannheimn.de' => 'Thomas Schlichter',	# it's typo IMHO
-'shmulik.hen:intel.com' => 'Shmulik Hen',
 'schoenfr:gaaertner.de' => 'Erik Schoenfelder',
 'schwab:suse.de' => 'Andreas Schwab',
 'schwidefsky:de.ibm.com' => 'Martin Schwidefsky',
@@ -977,6 +979,7 @@
 'shemminger:osdl.org' => 'Stephen Hemminger',
 'shields:msrl.com' => 'Michael Shields',
 'shingchuang:via.com.tw' => 'Shing Chuang',
+'shmulik.hen:intel.com' => 'Shmulik Hen',
 'silicon:falcon.sch.bme.hu' => 'Szilárd Pásztor', # google
 'simonb:lipsyncpost.co.uk' => 'Simon Burley',
 'skip.ford:verizon.net' => 'Skip Ford',
@@ -991,11 +994,13 @@
 'sprite:sprite.fr.eu.org' => 'Jeremie Koenig',
 'spse:secret.org.uk' => 'Simon Evans', # by Kristian Peters
 'spyro:com.rmk.(none)' => 'Ian Molton',
+'spyro:f2s.com' => 'Ian Molton',
 'src:flint.arm.linux.org.uk' => 'Russell King',
 'sri:us.ibm.com' => 'Sridhar Samudrala',
 'sridhar:dyn9-47-18-140.beaverton.ibm.com' => 'Sridhar Samudrala',
 'sridhar:dyn9-47-18-86.beaverton.ibm.com' => 'Sridhar Samudrala',
 'sridhar:x1-6-00-10-a4-8b-06-f6.attbi.com' => 'Sridhar Samudrala',
+'srk:thekelleys.org.uk' => 'Simon Kelley',
 'srompf:isg.de' => 'Stefan Rompf',
 'stanley.wang:linux.co.intel.com' => 'Stanley Wang',
 'stefan.eletzhofer:eletztrick.de' => 'Stefan Eletzhofer',
@@ -1038,6 +1043,7 @@
 'thockin:freakshow.cobalt.com' => 'Tim Hockin',
 'thockin:sun.com' => 'Tim Hockin',
 'thomas:bender.thinknerd.de' => 'Thomas Walpuski',
+'thomas:osterried.de' => 'Thomas Osterried',
 'thunder:ngforever.de' => 'Thunder From The Hill',
 'tigran:aivazian.name' => 'Tigran Aivazian',
 'tim:physik3.uni-rostock.de' => 'Tim Schmielau',
@@ -1713,6 +1719,18 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.128  2003/06/09 10:20:37  emma
+# Merge Linus' additions in. Resort address->name hash with LANG=C sort -u.
+#
+# Revision 0.127  2003/06/09 10:10:21  emma
+# Handle Alexey Kuznetsov's addresses by regexp.
+#
+# Revision 0.126  2003/06/09 09:56:40  vita
+# added 2 names for new addresses
+#
+# Revision 0.125  2003/06/06 12:13:57  vita
+# added 6 names for new addresses
+#
 # Revision 0.124  2003/06/04 10:31:18  vita
 # added 3 names for new addresses
 #

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.56
## Wrapped with gzip_uu ##


begin 600 bkpatch9232
M'XL(`'E@Y#X``[56VV[;.!!]CKYB@!3P+AHINEB2)2#9IG';9-.T1=(^-5V`
MML:6UA)ID%3B!/[N?=J''5*^)&FWE[W8A@61<\X,9PZ'W(4/"F6^TS"MRXHI
MC_%"(CJ[<"*4SG>FS<(KS.N%$/2ZKUJ%^S.4'.O]YV?T<[L75PM1*X<,WS$]
M+N$:I<IW`B_:C.C;.>8[%R]>?7A]=.$X!P=P7#(^Q4O4<'#@:"&O65VH9W/D
MT[;BGI:,JP8U\\:B66YLEZ'OA_0-PLA/XFP99DD<+S'$.![W`S9*!RF.PRU=
M*1K\&A>Q^/T@"X,P7OIA%$3.$`(O3L"/]OUDW\\@"/,PROO)4S_,?1\>9>I9
MER%X&H#K.\_A/U['L3.&<Y13A)M*E_"ZXJWJ03M76B)K@!5%I2O!E4=V;_#&
M#$A4"NW`<8V,M_/U(-25TIYS!D':CYQWV_P[[@]^',=GOG,(7\NR*H74M9AV
M"XV#@9_VTV"PC((TBY<3S-ADG/H9\[%@H^)OTOJ`Q90J"ZA(_7@9#M)!8E6T
MMG@@HG\=SW=3W==/WP\&L=5/Y'^FG_@;^HGZX`;)_Z.@#VN]M/.":03?"\*^
M>V@>@WRCL)6X'FCJ7%PC'-6XP%LX:^\X:B6N>VJK,PH7)$YQ03*3DMT:T%%1
M`'\LQ@M4E+6-%MU#X*Q!F%0U[@'655-QIBL^A:*=U]68PE1&JUVAWX(K;Q;F
MYRY(N>L"_`/A#H,``N?4_N_"D],BAWKFCFU2B=&;UWO7-C\#,-5=U]#/0S^/
M4L"F8?""%OO$&:8^A,YI&D#D?(0>JQE_]O$W[]/3*T_=4,6077DUI71QY0DY
MO?+:60\.#J%W1(9P+!:]/?BT9Y`SF]<UMN+28V-/MFOK1[E?HS8R^6D%_/F7
MC5"NC%(ZO"TJO%\9=^C3+**85W[S1LS5M[UNS57X`];B^\B'09S:LL0#>E`N
M<4';`Z6GQF5;W^45Y\(*!+<K.UH;P:4U(IK38)!8O(7IN_R&R7G@>^1GA3%[
MCJD.H0UD&/G&\S#*,A-`GW8H$4Q8/?/*%B<33J>CTFV!7'LMKUS=XHA4BIPV
M;<?YDFSAY$]K:F+H#PQAKQ0U]=M1WM+Z1\TV[!,[#L])!:0Z69@8XF[U<6J1
MOPLZ4O,;4?(2J\:;E.X-%EAO'/[ZA^3PPNC58).^Q78/2GO#Y$Q^YO5,5JKD
MC)).\QTL,^I-8K^#2>U),:H*9&U.*"U%?0]-TW0#Z*9[>SN[=!K5!4Q;VLG$
MD<2&PVK=;6G)4VRPXF9QFFH_$2LE,JG@U7;*1I&8K`^3-+)K2/N6:-;4N2K)
M4I7>J+KKX)<E,_F"RV["H-/(PKI'KRG%9-(PGM?5M-04S6R[@'-*"IQ[=*FQ
M)A8\L*[3S/:#-`L-!Z_&HF8JIQZ$[6*KFS?=.`SMN(%GB<5EJ6'IJ;)IZXHD
M@YRTJO%>[BZ[*3A!X_8TRVRP:GXK13X)U=;PE-K"N:BU6-G9G:#D+-<ESK"N
M\5:91K+I(Y=5(SB<V1FK?;]O:ZGIQ*(ET/4-I:RPV.CFO9V`M^L)"TH#*EYH
M+GAX72EJ^ZOF]\7N9]L?V7[YO``ZJQZU>??0-OF2J7)U@3EZ\^K@&*R-VWK.
M[F//Z6//QGFP\7Q".[[^QHDTNEV=2%^@3Q[0^UD>)SFE#:XK;>B)!`L([=&D
M8"+DPW/L<[[X'E]BCOH@RFDS/^1+OL*WN1^/2QS/5-L<1"PNDK!(G+\`EOI^
%4YP+````
`
end

