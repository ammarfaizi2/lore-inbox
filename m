Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272059AbTHHWv7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 18:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272067AbTHHWv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 18:51:59 -0400
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:51948 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S272059AbTHHWvx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 18:51:53 -0400
MIME-Version: 1.0
To: torvalds@osdl.org
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Fri_Aug__8_22_51_48_UTC_2003_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20030808225149.90AAD1F1A@merlin.emma.line.org>
Date: Sat,  9 Aug 2003 00:51:49 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can pull from bk://krusty.dt.e-technik.uni-dortmund.de  (NOTE: no
trailing slash) or in cases of dire need, you can apply the patch below.

BK: Parent repository is bk://kernel.bkbits.net/torvalds/tools/

Patch description:
  Bugfix: treat change sets that contain only blank lines.
  Print each input line in $debug mode.
  16 new address mappings.

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
# shortlog |   32 +++++++++++++++++++++++++++++---
# 1 files changed, 29 insertions(+), 3 deletions(-)

##### GNUPATCH #####
# This is a BitKeeper generated patch for the following project:
# Project Name: BK kernel tools
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.71    -> 1.72   
#	            shortlog	1.45    -> 1.46   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/08/09	matthias.andree@gmx.de	1.72
# Bugfix: treat change sets that contain only blank lines.
# Print each input line in $debug mode.
# 16 new address mappings.
# --------------------------------------------
#
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Sat Aug  9 00:51:48 2003
+++ b/shortlog	Sat Aug  9 00:51:48 2003
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.153 2003/07/30 08:12:10 vita Exp $
+# $Id: lk-changelog.pl,v 0.154 2003/08/08 22:40:06 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -269,6 +269,7 @@
 'c-d.hailfinger.kernel.2002-07:gmx.net' => 'Carl-Daniel Hailfinger',
 'c-d.hailfinger.kernel.2002-q4:gmx.net' => 'Carl-Daniel Hailfinger', # himself
 'c-d.hailfinger.kernel.2003:gmx.net' => 'Carl-Daniel Hailfinger', # himself
+'calum.mackay:cdmnet.org' => 'Calum Mackay', # lbdb
 'cananian:lesser-magoo.lcs.mit.edu' => 'C. Scott Ananian',
 'cattelan:sgi.com' => 'Russell Cattelan', # google
 'ccaputo:alt.net' => 'Chris Caputo',
@@ -286,6 +287,7 @@
 'chas:cmf.nrl.navy.mil' => 'Chas Williams',
 'chas:locutus.cmf.nrl.navy.mil' => 'Chas Williams',
 'chessman:tux.org' => 'Samuel S. Chessman',
+'chip:pobox.com' => 'Chip Salzenberg', # lbdb
 'chris:qwirx.com' => 'Chris Wilson',
 'chris:wirex.com' => 'Chris Wright',
 'christer:weinigel.se' => 'Christer Weinigel', # from shortlog
@@ -340,6 +342,7 @@
 'davej:codemonkey.org.u' => 'Dave Jones',
 'davej:codemonkey.org.uk' => 'Dave Jones',
 'davej:codmonkey.org.uk' => 'Dave Jones',
+'davej:redhat.com' => 'Dave Jones', # lbdb
 'davej:suse.de' => 'Dave Jones',
 'davej:tetrachloride.(none)' => 'Dave Jones',
 'davem:hera.kernel.org' => 'David S. Miller',
@@ -397,6 +400,7 @@
 'dsaxena:com.rmk.(none)' => 'Deepak Saxena',
 'dsaxena:mvista.com' => 'Deepak Saxena',
 'dsteklof:us.ibm.com' => 'Daniel E. F. Stekloff',
+'dth:dth.net' => 'Danny ter Haar', # guessed
 'dtor_core:ameritech.net' => 'Dmitry Torokhov',
 'ducrot:poupinou.org' => 'Bruno Ducrot',
 'duncan.sands:math.u-psud.fr' => 'Duncan Sands',
@@ -519,6 +523,7 @@
 'henning:meier-geinitz.de' => 'Henning Meier-Geinitz',
 'henrique2.gobbi:cyclades.com' => 'Henrique Gobbi',
 'henrique:cyclades.com' => 'Henrique Gobbi',
+'herbert:13thfloor.at' => 'Herbert Pötzl', # lbdb
 'herbert:gondor.apana.org.au' => 'Herbert Xu',
 'hermes:gibson.dropbear.id.au' => 'David Gibson',
 'hirofumi:mail.parknet.co.jp' => 'Hirofumi Ogawa', # corrected by himself
@@ -529,6 +534,7 @@
 'hugh:veritas.com' => 'Hugh Dickins',
 'hunold:convergence.de' => 'Michael Hunold',
 'hwahl:hwahl.de' => 'Hartmut Wahl',
+'ianw:gelato.unsw.edu.au' => 'Ian Wienand', # lbdb
 'ica2_ts:csv.ica.uni-stuttgart.de' => 'Thiemo Seufer', # google
 'ilmari:ilmari.org' => 'Dagfinn Ilmari Mannsåker',
 'info:usblcd.de' => 'Adams IT Services',
@@ -661,6 +667,7 @@
 'kai.makisara:kolumbus.fi' => 'Kai Makisara',
 'kai.reichert:udo.edu' => 'Kai Reichert',
 'kai:chaos.tp1.ruhr-uni-bochum.de' => 'Kai Germaschewski',
+'kai:germaschewski.name' => 'Kai Germaschewski',
 'kai:tp1.ruhr-uni-bochum.de' => 'Kai Germaschewski',
 'kai:vaio.(none)' => 'Kai Germaschewski',
 'kai:zephyr.physics.uiowa.edu' => 'Kai Germaschewski',
@@ -681,6 +688,7 @@
 'kettenis:gnu.org' => 'Mark Kettenis',
 'key:austin.ibm.com' => 'Kent Yoder',
 'khaho:koti.soon.fi' => 'Ari Juhani Hämeenaho',
+'khali:linux-fr.org' => 'Jean Delvare', # lbdb
 'khalid:fc.hp.com' => 'Khalid Aziz',
 'khalid_aziz:hp.com' => 'Khalid Aziz',
 'khc:pm.waw.pl' => 'Krzysztof Halasa',
@@ -735,6 +743,8 @@
 'lode_leroy:hotmail.com' => 'Lode Leroy',
 'lopezp:grupocp.es' => 'Jose A. Lopez',
 'lord:jen.americas.sgi.com' => 'Stephen Lord',
+'lord:laptop.americas' => 'Stephen Lord',
+'lord:laptop.americas.sgi.com' => 'Stephen Lord',
 'lord:sgi.com' => 'Stephen Lord',
 'louis.zhuang:linux.co.intel.com' => 'Louis Zhuang',
 'louisk:cse.unsw.edu.au' => 'Louis Yu-Kiu Kwan',
@@ -758,6 +768,7 @@
 'marcel:holtmann.org' => 'Marcel Holtmann', # sent by himself
 'marcelo:conectiva.com.br' => 'Marcelo Tosatti',
 'marcelo:freak.distro.conectiva' => 'Marcelo Tosatti', # guessed
+'marcelo:logos.cnet' => 'Marcelo Tosatti', # guessed
 'marcelo:plucky.distro.conectiva' => 'Marcelo Tosatti',
 'marcus:ingate.com' => 'Marcus Sundberg',
 'marekm:amelek.gda.pl' => 'Marek Michalkiewicz',
@@ -892,6 +903,7 @@
 'paschal:rcsis.com' => 'David Paschal',
 'pasky:ucw.cz' => 'Petr Baudis',
 'patmans:us.ibm.com' => 'Patrick Mansfield',
+'patrick:dreker.de' => 'Patrick Dreker', # lbdb
 'paubert:iram.es' => 'Gabriel Paubert',
 'paul.mundt:timesys.com' => 'Paul Mundt', # google
 'paulkf:microgate.com' => 'Paul Fulghum',
@@ -970,7 +982,7 @@
 'reeja.john:amd.com' => 'Reeja John',
 'reiser:namesys.com' => 'Hans Reiser',
 'rem:osdl.org' => 'Bob Miller',
-'rgcrettol@datacomm.ch' => 'Roger Crettol',
+'rgcrettol:datacomm.ch' => 'Roger Crettol',
 'rgooch:atnf.csiro.au' => 'Richard Gooch',
 'rgooch:ras.ucalgary.ca' => 'Richard Gooch',
 'rgs:linalco.com' => 'Roberto Gordo Saez',
@@ -990,6 +1002,7 @@
 'rml:tech9.net' => 'Robert Love',
 'rob:osinvestor.com' => 'Rob Radez',
 'robert.olsson:data.slu.se' => 'Robert Olsson',
+'robn:verdi.et.tudelft.nl' => 'Rob van Nieuwkerk',
 'roehrich:sgi.com' => 'Dean Roehrich',
 'rohit.seth:intel.com' => 'Seth Rohit',
 'rol:as2917.net' => 'Paul Rolland',
@@ -1026,6 +1039,7 @@
 'sam:ravnborg.org' => 'Sam Ravnborg',
 'samel:mail.cz' => 'Vitezslav Samel',
 'samuel.thibault:ens-lyon.fr' => 'Samuel Thibault',
+'samuel.thibault:fnac.net' => 'Samuel Thibault', # lbdb
 'sandeen:sgi.com' => 'Eric Sandeen',
 'santiago:newphoenix.net' => 'Santiago A. Nullo', # sent by self
 'sarolaht:cs.helsinki.fi' => 'Pasi Sarolahti',
@@ -1064,6 +1078,7 @@
 'snailtalk:linux-mandrake.com' => 'Geoffrey Lee', # by himself
 'sneakums:zork.net' => 'Sean Neakums',
 'solar:openwall.com' => 'Solar Designer',
+'solca:guug.org' => 'Otto Solares',
 'solt:dns.toxicfilms.tv' => 'Maciej Soltysiak',
 'soruk:eridani.co.uk' => 'Michael McConnell',
 'sparker:sun.com' => 'Steven Parker', # by Duncan Laurie
@@ -1212,6 +1227,7 @@
 'yokota:netlab.is.tsukuba.ac.jp' => 'Yokota Hiroshi',
 'yoshfuji:linux-ipv6.org' => 'Hideaki Yoshifuji', # lbdb
 'yoshfuji:nuts.ninka.net' => 'Hideaki Yoshifuji',
+'ysato:users.sourceforge.jp' => 'Yoshinori Sato', # lbdb
 'yuri:acronis.com' => 'Yuri Per', # lbdb
 'zaitcev:redhat.com' => 'Pete Zaitcev',
 'zinx:epicsol.org' => 'Zinx Verituse',
@@ -1323,7 +1339,9 @@
 
   # strip trailing blank lines
   my $t;
-  while (($t = pop(@cur)) eq '') { };
+  do {
+      $t = pop(@cur);
+  } while (defined $t and $t eq '');
   push @cur, $t;
 
   # store the array
@@ -1548,6 +1566,9 @@
     # expand all tabs but the first
     $_ = expand($_);
     s/^        /\t/;
+      if ($debug) {
+	  print "line: $_\n";
+      }
 
     if (defined $address and $opt{multi}
 	and m{^[^<[:space:]]} and not m{^ChangeSet@}) {
@@ -1809,6 +1830,11 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.154  2003/08/08 22:40:06  emma
+# Bugfix: treat change sets that contain only blank lines.
+# Print each input line in $debug mode.
+# 16 new address mappings.
+#
 # Revision 0.153  2003/07/30 08:12:10  vita
 # 3 new addresses
 #

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.72
## Wrapped with gzip_uu ##


begin 600 bkpatch17944
M'XL(`(0I-#\``]U6;6_;-A#^'/V*0QW`+5HKE&2]L4C1-2E:-^T:)"V&`0,&
M6J(EU12IDI3M=.[?WN>=I*1VN@;;NGV:+)L6><\=^=S#$T?PWG!-#VIF;5DQ
MXS*9:\Z=$;Q4QM*#HMZX>?=XH10^'IG6\*,EUY*+HV=G>$^&AXE52A@'#<^9
MS4I8<6WH@><&7WKL5</IP<7S%^]?_W#A.,?'<%(R6?!+;N'XV+%*KYC(S=.&
MRZ*MI&LUDZ;FEKF9JK=?;+<^(3Y^/#\@49AN_30*PRWW>1AF4X_-XR3FF;]S
M5ZJ:N\KDPE6ZN.TF(`GQ2!!&8;0E7IP0YQ0\-_:!!$<D.2(I$$)#0H/T(?$I
M(?`524\'<N"A!Q/B/(/_>`DG3@;/VF)1;2A8S9F%K/<`AEL#MNPZE+2LDJ"D
MN(*Y8'()HI+<N`@]UY6TP!E27\FFM?T(_H7#G,_;`FJ5\\[.BT#R-;`<EV0,
MKK%I*EF@BS/PXJGOG._RY$S^X>4XA!'G"=S.QFU:3*FT%:H86`F]A,33V$NV
M@1>GX7;!4[;(8I(RPG,VS^_(P2TO75X3WP])D&Q#/TR#7FTW%K?$]J_G<Y?0
MOI[/C<Z"J4^FO<ZFT9]TEOR%SOP4)L'_46A#EM["1*\WW3W9H.QN*/P.U9UZ
M'GC.K/\=P>$LIR"6DV%5Z-%MQ*,5$-<+I]#EI\]"`KY/IX22"'A=,WB^:>#0
MF?EQYV2<,='6;LVR);NB65Y+;KL\C^'X"8Q/ND%XTP^.'\$(Q#R?(S1)>FA9
M-;11<[7ILG.-P#ZX9.(3EW..;G8@%$@'RMF*?Z":Y\C^#G:*O?!*(?'[B#3M
M$;:D^'5Q9C?&4EZ!Y1I>,J9[0-$B\SQW9J'?KZKD&L-;Z@6V7`BEM,NNP2^'
M$3C_W7X2>\'"H`=63*XI<LFL<EMIUB[/6Y>U`W;&)/Q4<8GJW4-&4=`AEZQ"
MH*Z9R4J^-LO*E:SF`_",5?!B?VS\"'')@"N9J"A*J]U,%GK'_2N.T4ZY6#'-
M]Z+%00R^,Q9*YU2PQJK&Q3"ZRI@9<)>6-R67\!HM,,PW+5U35#OROT+,XHAT
M$ZN9SE!4%'6EC)M]H?_-T`_OE,'M7-WF/TFG';9A%@,M*>X(?(WB'A^@YT,W
MG/;=NU6=IG''Q6QHQKK(-+=6"9HSRW">M9N5@X<+A1S#R3#<339->UEI-9<4
MW\UYY:*`;9MSL;"N%#>H.:R0SA\KWJXQ\K)#>L3O96Q8W7+A8F&:LU98NI`L
MVXGMLA^%=]>C>YGP2!3U>"4R1HNV+7;)>XO3@TLE,'>FC^5[/2]72)FB>-30
MF`/5(I$+Q'#W0S/@?E:FK*32%>XAJ_8(\@(_ZG=^UP8.0*[@-VRZZQ#/&="H
MYO[3K-4/'F/O9UB7E>!P/^<+K%EY9X*B[1K^$<9C-)IY84AZ3]U5+>#^4-4>
MH-L#@*:O??>ZBD?A\-=?Y+W'UZ:?$9I@`0J[LQ-?5:92\KKD?+/F]$4';;^[
D$(_^9B$>W5V(1[OS&V[`;&G:^MB/DWR!LW;^`)`/@,<J"@``
`
end

