Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265393AbTIDU6E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 16:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265403AbTIDU6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 16:58:04 -0400
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:56475 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S265393AbTIDU5z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 16:57:55 -0400
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Thu_Sep__4_20_57_52_UTC_2003_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20030904205752.AEA4894738@merlin.emma.line.org>
Date: Thu,  4 Sep 2003 22:57:52 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can pull from bk://krusty.dt.e-technik.uni-dortmund.de  (NOTE: no
trailing slash) or in cases of dire need, you can apply the patch below.

BK: Parent repository is bk://kernel.bkbits.net/torvalds/tools/

Patch description:
  11 new addresses
  implement --mode=resolve that copies its input to the output,
  replacing the first mail address by the name if the latter is known

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
# shortlog |   51 +++++++++++++++++++++++++++++++++++++++++--
# 1 files changed, 49 insertions(+), 2 deletions(-)

##### GNUPATCH #####
# This is a BitKeeper generated patch for the following project:
# Project Name: BK kernel tools
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.83    -> 1.84   
#	            shortlog	1.56    -> 1.57   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/09/04	matthias.andree@gmx.de	1.84
# 11 new addresses
# implement --mode=resolve that copies its input to the output,
# replacing the first mail address by the name if the latter is known
# --------------------------------------------
#
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Thu Sep  4 22:57:52 2003
+++ b/shortlog	Thu Sep  4 22:57:52 2003
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.170 2003/09/03 04:31:37 vita Exp $
+# $Id: lk-changelog.pl,v 0.171 2003/09/04 20:55:38 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -158,6 +158,7 @@
 'aia21:cam.ac.uk' => 'Anton Altaparmakov',
 'aia21:cantab.net' => 'Anton Altaparmakov',
 'aia21:cus.cam.ac.uk' => 'Anton Altaparmakov',
+'aia21:drop.stormcorp.org' => 'Anton Altaparmakov', # guessed
 'ajoshi:kernel.crashing.org' => 'Ani Joshi',
 'ajoshi:shell.unixbox.com' => 'Ani Joshi',
 'ak:colin.muc.de' => 'Andi Kleen',
@@ -185,6 +186,7 @@
 'alexey:technomagesinc.com' => 'Alex Tomas',
 'alext:fc.hp.com' => 'Alex Tsariounov',
 'alfre:ibd.es' => 'Alfredo Sanjuán',
+'aliakc:web.de' => 'Ali Akcaagac', # lbdb
 'ambx1:com.rmk.(none)' => 'Adam Belay',
 'ambx1:neo.rr.com' => 'Adam Belay',
 'amir.noam:intel.com' => 'Amir Noam',
@@ -450,6 +452,7 @@
 'eric.piel:bull.net' => 'Eric Piel',
 'erik:aarg.net' => 'Erik Arneson',
 'erik_habbinga:hp.com' => 'Erik Habbinga',
+'ernstp:mac.com' => 'Ernst Persson', # lbdb
 'eyal:eyal.emu.id.au' => 'Eyal Lebedinsky', # lbdb
 'faikuygur:ttnet.net.tr' => 'Faik Uygur',
 'falk.hueffner:student.uni-tuebingen.de' => 'Falk Hüffner',
@@ -498,6 +501,7 @@
 'gibbs:scsiguy.com' => 'Justin T. Gibbs',
 'gilbertd:treblig.org' => 'Dr. David Alan Gilbert',
 'gj:pointblue.com.pl' => 'Grzegorz Jaskiewicz',
+'gkernel.adm:hostme.bitkeeper.com' => 'Jeff Garzik', # himself
 'gl:dsa-ac.de' => 'Guennadi Liakhovetski',
 'glee:gnupilgrims.org' => 'Geoffrey Lee', # lbdb
 'gnb:alphalink.com.au' => 'Greg Banks',
@@ -886,7 +890,9 @@
 'mlocke:mvista.com' => 'Montavista Software, Inc.',
 'mmagallo:debian.org' => 'Marcelo E. Magallon',
 'mmcclell:bigfoot.com' => 'Mark McClelland',
+'mochel:bambi.(none)' => 'Patrick Mochel',
 'mochel:geena.pdx.osdl.net' => 'Patrick Mochel',
+'mochel:hera.kernel.org' => 'Patrick Mochel',
 'mochel:osdl.org' => 'Patrick Mochel',
 'mochel:segfault.osdl.org' => 'Patrick Mochel',
 'mochel:segfault.osdlab.org' => 'Patrick Mochel',
@@ -953,6 +959,7 @@
 'pam.delaney:lsil.com' => 'Pamela Delaney',
 'paschal:rcsis.com' => 'David Paschal',
 'pasky:ucw.cz' => 'Petr Baudis',
+'patch:luckynet.dynu.com' => '"Lightweight Patch Manager"', # lbdb
 'patmans:us.ibm.com' => 'Patrick Mansfield',
 'patrick:dreker.de' => 'Patrick Dreker', # lbdb
 'paubert:iram.es' => 'Gabriel Paubert',
@@ -964,6 +971,7 @@
 'paulus:cargo.(none)' => 'Paul Mackerras',
 'paulus:nanango.paulus.ozlabs.org' => 'Paul Mackerras',
 'paulus:quango.ozlabs.ibm.com' => 'Paul Mackerras',
+'paulus:quango.(none)' => 'Paul Mackerras', # lk, Alan Cox 20030904
 'paulus:samba.org' => 'Paul Mackerras',
 'paulus:tango.paulus.ozlabs.org' => 'Paul Mackerras',
 'pavel:janik.cz' => 'Pavel Janík',
@@ -1109,6 +1117,7 @@
 'schoenfr:gaaertner.de' => 'Erik Schoenfelder',
 'schwab:suse.de' => 'Andreas Schwab',
 'schwidefsky:de.ibm.com' => 'Martin Schwidefsky',
+'scole:zianet.com' => 'Steven Cole', # lk, Alan Cox 20030904
 'scott.feldman:intel.com' => 'Scott Feldman',
 'scott_anderson:mvista.com' => 'Scott Anderson',
 'scottm:minion.yyz.somanetworks.com' => 'Scott Murray',
@@ -1193,6 +1202,7 @@
 'tao:acc.umu.se' => 'David Weinehall', # by himself
 'tao:kernel.org' => 'David Weinehall', # by himself
 'tapio:iptime.fi' => 'Tapio Laxström',
+'taral:taral.net' => 'Jean-Philippe Sugarbroad', # Muli Ben-Yehuda on lk
 'tausq:debian.org' => 'Randolph Chung',
 'tcallawa:redhat.com' => "Tom 'spot' Callaway",
 'tetapi:utu.fi' => 'Tero Pirkkanen', # by Kristian Peters
@@ -1233,6 +1243,7 @@
 'tvignaud:mandrakesoft.com' => 'Thierry Vignaud',
 'tvrtko:net4u.hr' => 'Tvrtko A. Ursulin',
 'twaugh:redhat.com' => 'Tim Waugh',
+'typhoon.adm:hostme.bitkeeper.com' => 'Dave Dillow', # himself on lk
 'tytso:mit.edu' => "Theodore Y. T'so", # web.mit.edu/tytso/www/home.html
 'tytso:snap.thunk.org' => "Theodore Y. T'so",
 'tytso:think.thunk.org' => "Theodore Y. T'so", # guessed
@@ -1389,7 +1400,10 @@
 		  'parse' => \&parse_file },
    'fixup'   => { 'index' => sub { },
 		  'print' => sub { },
-		  'parse' => \&fixup_file }
+		  'parse' => \&fixup_file },
+   'resolve' => { 'index' => sub { },
+		  'print' => sub { },
+		  'parse' => \&resolve }
   );
 
 # temp store
@@ -1669,6 +1683,29 @@
   return ();
 }
 
+sub resolve(\%$$ ) {
+# arguments: %log hash
+#            file name
+#            file handle (IO::Handle or IO::File)
+  croak unless wantarray;
+  my $log = shift;
+  my $fn = shift;
+  my $fh = shift;
+  # assume the TLD is all-alphabetic for now.
+  my $mre = '[a-zA-Z0-9.-]+\@[a-zA-Z0-9.()-]+\.[a-zA-Z]+';
+
+  while ($_ = $fh -> getline) {
+      chomp;
+      if (/($mre)/) {
+	  my $r = rmap_address($1);
+	  s/$mre/$r/;
+      }
+      print "$_\n";
+  }
+
+  return ();
+}
+
 # Read a file and parse it into the %log hash.
 sub parse_file(\%$$ ) {
 # arguments: %log hash
@@ -1970,6 +2007,10 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.171  2003/09/04 20:55:38  emma
+# 11 new addresses.
+# add --mode=resolve
+#
 # Revision 0.170  2003/09/03 04:31:37  vita
 # 4 new addresses
 #
@@ -2619,6 +2660,12 @@
 to postprocess this script's output after new addresses have been added.
 Besides addresses that are replaced by names, the output is the verbatim
 input. No ordering or grouping takes place.
+
+=item resolve - another special mode (since 0.171)
+
+This mode is a quick mode that will try to map all mail addresses to
+names, up to one per input line. You can run this mode on bk changes
+output directly.
 
 =back
 

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.84
## Wrapped with gzip_uu ##


M'XL( %"G5S\  ^56;7/:.!#^'/^*G80>9!(;VV# SM!IVO3:7-MIIB\?>I=.
M1M@":Y E5Y(AM,E_OY4-"4G3N^G=?3M>;+32/E[M/GJ6/?BHJ4IV"F),SHCV
MB,@4I<X>O)3:)#NSXM++[/"=E#CLZDK3[IPJ07GWZ2O\N,W -5)R[>#",V+2
M'!94Z60G\'HW%K,J:;+S[OF+CZ^/WSG.> S/<B)F]#TU,!X[1JH%X9E^4E(Q
MJYCPC")"%]00+Y7%U<W:J]#W0WP'8<\?1/%5& ^BZ(J&-(K2?D FP]&0IJ%S
M;S]/FGW<A>GYL=\+>[TP&%TA7A X)Q!XHS[XO:X?=_T^A&$2#9)H=."'B>_#
MPZ!P$(#K.T_A/][",R>%( !!ET R?)[65*.)%26G!14&7+>0&1WCC.0+"B8G
M!E)9,JJ!&?R*LC(8%$Y0D)7!T2'Z*UIRDC(QJ^U3IK3!C3&^>0A,5O6,( 4%
M-JU_<]PX5< TS(5<"N<5!*$_=,YN2^BX/_ER')_XSN/;I.6RH/<RIG.I#)>S
M)F%1,/*'_2$6JQ<,X^AJ2F,R38=^3'R:D4GV@_+<0;$E[R/4($*4$#=1$W&S
MX@X/_W4\/^+@_7@V%.P/_6%84S :_C0%^S&XX?^,@TT!WX*KEI?VXUXB(S?9
M_0>$/,&=!LYI?=V#UFF6 )^[:9TR1/1*?K@ WPN& =C2;0KD)U&4]$9 BX+ 
M\\L26H@Q\!&D31@)@R13LO0T5J9(I2H]J69M&#^&]K$P4L Q-Z0DJB!SN6@?
MPA[,*IOF#$%&PQJ$,S)/DR6=8*77GIS!\3PE9$;2VH=/LHESVH]"ZX""K$V9
M%"2U-6\\GEL;G*$J:RFV7"*_#G36J+A'LB+)4?B1^A-FYI265-V"_$:G4WA!
MU%<VKR%R5FC*I\[I:#2R*(5,<\J3"2DFS.L(*>A^XX@=0+%T#F_J!>U#ZQ%O
M>>14$6\=PDUZOG>*H\@ZE;:?)+Q*YRM!C9>M1'4;X^YK-LO-DMKKNO.\(8+,
MJ-K=VG8\&#1(%:]T\J7"$LM[$5<<'5,,2A'=>,X/L5A$P#-Y"1LML72I"=/6
MJ>0T^<J(C>DFG/>&+JAUX?2O0>)Z:X8HPI/ZZB'.)NU$N&<YXZPL*;RO9D1-
ME"19#?BF0BX\I<+]1/,J(X",XG,$#'L-X*K,I11_4]@3@F?WA'$NE]N%78.=
M!+TXK$^&O?>=G1T 3)W2#1O/?YFRRZJ\F#).X?K0 9Q=ZT$]_PW:3&3TLA[H
M:H(&7-6 *";,0_8M\(VT7-M398]>S[&+U^;.^:-6"_;A&YY8HF:5%26=P".K
MYCG1.9JW7G6(5E0>,.,QS_#6.7V;)"^;WU*!'?V*T_NXK123/H=*<*M02R*P
M3(JLCG"F6$&K[A\H/VQJ-J:I^,Z2;ULP9*TQY%K?/KP^L>)&.'<)+W,RH8:E
M,,484.Z\M7^A* *T_R#NUV/W=]^-/??SP?F3K7%GWUJ\M>7S0?O(.4?G96[W
MV&E=H+N-PGT,,VHX0\)C[IHTI-CRRJ/U %6WT^W8!^YW[9*=)@"%_JA5Y<5:
MJ3NM8/_(3NJN7=MMJ>X&X7I]KXL,NZV+<[%KYZ[K@!0UE1+006]K. WBH>46
M_M&D"Z89,J]1V@>EMM9:7'N_-7F6!5EVKRLY>\YI. @#&."#QLS08L,><($(
MB=E7H$N:,L+!.D)',Y'2)H)]=/J08V7J&5LA^%)97:K'=<-;XLD!HU:VT6%N
M; WOM#-LAD8ZEG?Z$*K2+D.E@=*VL[I!VCIX\$E6D*(TJ$H@[N:)F(G)')HN
EI)VFAT+&%$T-7WFW_[A1)-,YLFG<[\5T,)T&SI]&( 9-W L     
 

