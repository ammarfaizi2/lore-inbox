Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269509AbTGUJCz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 05:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269510AbTGUJCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 05:02:52 -0400
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:33669 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S269509AbTGUJCl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 05:02:41 -0400
MIME-Version: 1.0
To: torvalds@osdl.org
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Mon_Jul_21_09_17_40_UTC_2003_0@merlin.emma.line.org>
Content-Type: text/plain; charset=US-ASCII
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 7BIT
Message-Id: <20030721091740.ADF022EEE@merlin.emma.line.org>
Date: Mon, 21 Jul 2003 11:17:40 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can pull from bk://krusty.dt.e-technik.uni-dortmund.de  (NOTE: no
trailing slash) or in cases of dire need, you can apply the patch below.

BK: Parent repository is bk://kernel.bkbits.net/torvalds/tools/

Patch description:
10 new addresses, one new regexp, one regexp refinement,
address hash re-sorted.

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
# shortlog |   30 +++++++++++++++++++++++++-----
# 1 files changed, 25 insertions(+), 5 deletions(-)

##### GNUPATCH #####
# This is a BitKeeper generated patch for the following project:
# Project Name: BK kernel tools
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.68    -> 1.69   
#	            shortlog	1.42    -> 1.43   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/07/21	matthias.andree@gmx.de	1.69
# Add 10 new addresses. Add davem regexp. Re-sort address/name hash.
# --------------------------------------------
#
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Mon Jul 21 11:17:40 2003
+++ b/shortlog	Mon Jul 21 11:17:40 2003
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.148 2003/07/15 12:59:09 vita Exp $
+# $Id: lk-changelog.pl,v 0.150 2003/07/21 09:07:06 vita Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -68,7 +68,8 @@
 # Perl syntax magic here, "=>" is equivalent to ","
 my @addrregexps = (
 [ 'alan@[^.]+\.swansea\.linux\.org\.uk' => 'Alan Cox', ],
-[ 'kuznet@[^.]+\.inr.ac.ru' => 'Alexey Kuznetsov', ],
+[ 'davem@[^.]+\.ninka\.net' => 'David S. Miller', ],
+[ 'kuznet@[^.]+\.inr\.ac\.ru' => 'Alexey Kuznetsov', ],
 [ 'torvalds@([^.]+\.)?transmeta\.com' => 'Linus Torvalds', ],
 [ 'torvalds@([^.]+\.)?osdl\.org' => 'Linus Torvalds', ],
 [ '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~' => '~~~~~~~~' ]);
@@ -93,6 +94,9 @@
 my @addresses_handled_in_regexp = (
 'alan:hraefn.swansea.linux.org.uk' => 'Alan Cox',
 'alan:irongate.swansea.linux.org.uk' => 'Alan Cox',
+'davem:cheetah.ninka.net' => 'David S. Miller',
+'davem:nuts.ninka.net' => 'David S. Miller',
+'davem:pizda.ninka.net' => 'David S. Miller', # guessed
 'kuznet:mops.inr.ac.ru' => 'Alexey Kuznetsov',
 'kuznet:ms2.inr.ac.ru' => 'Alexey Kuznetsov',
 'kuznet:oops.inr.ac.ru' => 'Alexey Kuznetsov',
@@ -156,6 +160,7 @@
 'akropel1:rochester.rr.com' => 'Adam Kropelin', # lbdb
 'alan:lxorguk.ukuu.org.uk' => 'Alan Cox',
 'alan:redhat.com' => 'Alan Cox',
+'albertogli:telpin.com.ar' => 'Alberto Bertogli',
 'alborchers:steinerpoint.com' => 'Al Borchers',
 'alex:ssi.bg' => 'Alexander Atanasov',
 'alex_williamson:attbi.com' => 'Alex Williamson', # lbdb
@@ -336,8 +341,6 @@
 'davej:tetrachloride.(none)' => 'Dave Jones',
 'davem:hera.kernel.org' => 'David S. Miller',
 'davem:kernel.bkbits.net' => 'David S. Miller',
-'davem:nuts.ninka.net' => 'David S. Miller',
-'davem:pizda.ninka.net' => 'David S. Miller', # guessed
 'davem:redhat.com' => 'David S. Miller',
 'david-b:pacbell.com' => 'David Brownell',
 'david-b:pacbell.net' => 'David Brownell',
@@ -471,6 +474,7 @@
 'gnb:alphalink.com.au' => 'Greg Banks',
 'go:turbolinux.co.jp' => 'Go Taniguchi',
 'gone:us.ibm.com' => 'Patricia Gaughen',
+'gorgo:thunderchild.debian.net' => 'Madarasz Gergely',
 'gotom:debian.or.jp' => 'Goto Masanori', # from shortlog
 'gphat:cafes.net' => 'Cory Watson',
 'greearb:candelatech.com' => 'Ben Greear',
@@ -537,6 +541,7 @@
 'iwi:atm.ox.ac.uk' => 'Alan Iwi',
 'j-nomura:ce.jp.nec.com' => 'Junichi Nomura',
 'j.dittmer:portrix.net' => 'Jan Dittmer',
+'ja:ssi.bg' => 'Julian Anastasov',
 'jack:suse.cz' => 'Jan Kara',
 'jack:ucw.cz' => 'Jan Kara',
 'jack_hammer:adaptec.com' => 'Jack Hammer',
@@ -554,6 +559,7 @@
 'jamie:shareable.org' => 'Jamie Lokier',
 'jani:astechnix.ro' => 'Jani Monoses',
 'jani:iv.ro' => 'Jani Monoses',
+'jasper:vs19.net' => 'Jasper Spaans',
 'javaman:katamail.com' => 'Paulo Ornati',
 'jay.estabrook:compaq.com' => 'Jay Estabrook',
 'jb:jblache.org' => 'Julien Blache',
@@ -581,6 +587,7 @@
 'jenna.s.hall:intel.com' => 'Jenna S. Hall', # google
 'jes:trained-monkey.org' => 'Jes Sorensen',
 'jes:wildopensource.com' => 'Jes Sorensen',
+'jfbeam:bluetronic.net' => 'Ricky Beam',
 'jgarzik:fokker2.devel.redhat.com' => 'Jeff Garzik',
 'jgarzik:hum.(none)' => 'Jeff Garzik',
 'jgarzik:mandrakesoft.com' => 'Jeff Garzik',
@@ -703,12 +710,14 @@
 'leigh:solinno.co.uk' => 'Leigh Brown', # lbdb
 'lenehan:twibble.org' => 'Jamie Lenehan',
 'lethal:linux-sh.org' => 'Paul Mundt',
+'lethal:unusual.internal.linux-sh.org' => 'Paul Mundt',
 'levon:movementarian.org' => 'John Levon',
 'lfo:polyad.org' => 'Luis F. Ortiz',
 'linux-usb:gemeinhardt.info' => 'Lars Gemeinhardt',
 'linux:brodo.de' => 'Dominik Brodowski',
 'linux:de.rmk.(none)' => 'Dominik Brodowski',
 'linux:hazard.jcu.cz' => 'Jan Marek',
+'linux:thorsten-knabe.de' => 'Thorsten Knabe',
 'lionel.bouton:inet6.fr' => 'Lionel Bouton',
 'lists:mdiehl.de' => 'Martin Diehl',
 'liyang:nerv.cx' => 'Liyang Hu',
@@ -782,8 +791,8 @@
 'michal:harddata.com' => 'Michal Jaegermann',
 'mikael.starvik:axis.com' => 'Mikael Starvik',
 'mikal:stillhq.com' => 'Michael Still',
-'mike:aiinc.ca' => 'Michael Hayes',
 'mike.miller:hp.com' => 'Mike Miller',
+'mike:aiinc.ca' => 'Michael Hayes',
 'mikenc:us.ibm.com' => 'Mike Christie',
 'mikep:linuxtr.net' => 'Mike Phillips',
 'mikpe:csd.uu.se' => 'Mikael Pettersson',
@@ -841,6 +850,7 @@
 'niv:us.ibm.com' => 'Nivedita Singhvi',
 'nivedita:w-nivedita.beaverton.ibm.com' => 'Nivedita Singhvi',
 'nkbj:image.dk' => 'Niels Kristian Bech Jensen',
+'nkiesel:tbdnetworks.com' => 'Norbert Kiesel',
 'nlaredo:transmeta.com' => 'Nathan Laredo',
 'nmiell:attbi.com' => 'Nicholas Miell',
 'nobita:t-online.de' => 'Andreas Busch',
@@ -1017,6 +1027,7 @@
 'schwidefsky:de.ibm.com' => 'Martin Schwidefsky',
 'scott.feldman:intel.com' => 'Scott Feldman',
 'scott_anderson:mvista.com' => 'Scott Anderson',
+'scottm:minion.yyz.somanetworks.com' => 'Scott Murray',
 'scottm:somanetworks.com' => 'Scott Murray',
 'sct:redhat.com' => 'Stephen C. Tweedie',
 'sds:epoch.ncsc.mil' => 'Stephen D. Smalley',
@@ -1101,6 +1112,7 @@
 'thockin:sun.com' => 'Tim Hockin',
 'thomas:bender.thinknerd.de' => 'Thomas Walpuski',
 'thomas:osterried.de' => 'Thomas Osterried',
+'thomr9am:ss1000.ms.mff.cuni.cz' => 'Rudo Thomas',
 'thornber:sistina.com' => 'Joe Thornber',
 'thunder:ngforever.de' => 'Thunder From The Hill',
 'tigran:aivazian.name' => 'Tigran Aivazian',
@@ -1784,6 +1796,14 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.150  2003/07/21 09:07:06  vita
+# resort address->name hash with LC_ALL=POSIX sort -u
+#
+# Revision 0.149  2003/07/21 09:03:12  vita
+# added 10 names for new addresses
+# put davem's addresses into @addrregexps
+# precise kuznet's regexp
+#
 # Revision 0.148  2003/07/15 12:59:09  vita
 # added 4 names for new addresses
 #

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.69
## Wrapped with gzip_uu ##


begin 600 bkpatch3803
M'XL(`+2O&S\``\U6[V_;-A#]'/T5!Z2`/S2B2<FR+`$.\JMHW21KD*S`@*8;
M:(FV6$N405*.'?B/WXE*XB5MMW7;A]F&;='O[OC>/9Z\#Q^-T.E>Q:TM)#>$
MJUP+X>W#N]K8=&]>K4G>7E[7-5[V36-$?R&T$F7_Y!Q??G?AV[HNC8?`*VZS
M`E9"FW2/D?!IQ6Z6(MV[?O/VX\7QM>>-QW!:<#47-\+">.S96J]XF9NCI5#S
M1BIB-5>F$I:3K*ZV3]AM0&F`3Q:$=!@EVR`91M%6!"**L@'CTW@4BRSP7O`Y
MZG@\3Q/2F$4L9,F`;2F+P]@[`T:&"="P3^-^P("QE(4IHZ]ID%(*WTX*KQGX
MU#N!_YC"J9?!<9X#HZ#$'?`<:QHC#'&K.5^)"K28B_62P+7P3:WM(ZBO>"6@
MX*8@WCD@M<"[VLGM^3_X\#S*J7>X(UC4E7C!SA18OZSG';F(C6@\B-EH&[(X
MB;8SD?!9%M.$4Y'S:?X=*9]EP?8$C";8(+H-DW`0.],\(IYYYE_OYWM^>;&?
M)[N$PW8_K5T&X0_;)8C`C_['?NG$_@"^OENW+W^-[GE4XA^8YXRA--[$O>_#
MJTF>0KGP,T</,Y)E>;`"2EA$H97Y04R:I#1.Z1!6TG)XLU["*^\L=IGP/?`^
M0<]Q.OKT*_G\^I8HJ18</X3MP?@0>F=\)7.X(7`IRU+HW@%\/FB#%LT]8AZC
MI-*WA&>W1#==V'$IUF(#YPYEZE47-TDB"+VN8)H5`GM4=!7_I.`C7C76_&WP
M4M[G_"_1L`_SINUNCKI&(Q2EQ\NIT+:>ES*UHERBG=!$A.M'6NY7.'G`8,&S
M,$Q0Q\D@#MOX>:WG=6J+1N5"9X4L<S3K5'*UV\8ES[GFYA[>"HVMVV"2281)
M,/H+3XV19#KOD.^;$B/A6'%CN5,1D=&P0YHEWG%6AB6[S._=(MPL.9X`!QZY
M37V9306OTFG9"*MK);-=R+7,%AODPZL6'].HQ9?"%KQ,&]68AI?878MW)_Q2
M2M6L?;0WDNS"KWA3PB62M2[<F;/G8*A!K8T5RE\H/A6H0A?Q\\,RG+?+K8#Q
M*')V'#EBE5R(E$NI,I+Q!\$DNER4\(YOA*,U&CA::B&%$65JISGRN:OUPK3=
MZH)^JG7;*SAWF#:*4>9$-EEM;9564LE:D<WFGIBZXE]GN&EQ2$YK[GK$&'5E
MD5BE$]33&$8I)94AU6Q&LD9)DMT_R-KD-2#5BKL-LY;<J+W_BY4T6/;AH'[S
MI+JCBE@<*7\8+O[ATW2!.VD+N#C][?CB8GSUX6;R"SBDWWC[+VH,DJ]JX&@-
MGFI@<M'-.DQN8%;KYU,/(<O&=F.O9W;K@)ZHX:B][H:A0VJ122.@FPT([W["
<33W]?<%#GRU,4XV#833C29!XOP-@2E_R.PD`````
`
end

