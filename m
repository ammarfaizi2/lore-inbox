Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbTFIKop (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 06:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262763AbTFIKop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 06:44:45 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:2825 "EHLO
	krusty.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262547AbTFIKok convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 06:44:40 -0400
MIME-Version: 1.0
To: torvalds@transmeta.com, marcelo@conectiva.com.br
Subject: lk-changelog.pl 0.128
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Mon_Jun__9_10_58_16_UTC_2003_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20030609105817.170AC84064@merlin.emma.line.org>
Date: Mon,  9 Jun 2003 12:58:17 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a semi-automatic announcement.

lk-changelog.pl aka. shortlog version 0.128 has been released.

This script is used by Linus and Marcelo to rearrange and reformat BK
ChangeSet logs into a more human-readable format, and the official
repository is bk://kernel.bkbits.net/torvalds/tools/

As the script has grown large, this mail only contains a diff against
the last released version.

You can always download the full script and GPG signatures from
http://mandree.home.pages.de/linux/kernel/

My thanks go to Vitezslav Samel who has spent a lot of time on digging
out the real names for addresses sending in BK ChangeSets.

Note that your mailer must be MIME-capable to save this mail properly,
because it is in the "quoted-printable" encoding.

= <- if you see just an equality sign, but no "3D", your mailer is fine.
= <- if you see 3D on this line, then upgrade your mailer or pipe this mail
= <- into metamail.

-- 
A sh script on behalf of Matthias Andree
-------------------------------------------------------------------------
Changes since last release:

----------------------------
revision 0.128
date: 2003/06/09 10:20:37;  author: emma;  state: Exp;  lines: +11 -8
Merge Linus' additions in. Resort address->name hash with LANG=C sort -u.
----------------------------
revision 0.127
date: 2003/06/09 10:10:21;  author: emma;  state: Exp;  lines: +10 -6
Handle Alexey Kuznetsov's addresses by regexp.
----------------------------
revision 0.126
date: 2003/06/09 09:56:40;  author: vita;  state: Exp;  lines: +6 -1
added 2 names for new addresses
----------------------------
revision 0.125
date: 2003/06/06 12:13:57;  author: vita;  state: Exp;  lines: +10 -1
added 6 names for new addresses
----------------------------
revision 0.124
date: 2003/06/04 10:31:18;  author: vita;  state: Exp;  lines: +7 -1
added 3 names for new addresses
=============================================================================
-------------------------------------------------------------------------
Index: lk-changelog.pl
===================================================================
RCS file: /var/CVS/lk-changelog/lk-changelog.pl,v
retrieving revision 0.124
retrieving revision 0.128
diff -u -r0.124 -r0.128
--- lk-changelog.pl	4 Jun 2003 10:31:18 -0000	0.124
+++ lk-changelog.pl	9 Jun 2003 10:20:37 -0000	0.128
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
@@ -395,8 +400,8 @@
 'erik:aarg.net' => 'Erik Arneson',
 'erik_habbinga:hp.com' => 'Erik Habbinga',
 'eyal:eyal.emu.id.au' => 'Eyal Lebedinsky', # lbdb
-'falk.hueffner:student.uni-tuebingen.de' => 'Falk Hüffner',
 'faikuygur:ttnet.net.tr' => 'Faik Uygur',
+'falk.hueffner:student.uni-tuebingen.de' => 'Falk Hüffner',
 'fbl:conectiva.com.br' => 'Flávio Bruno Leitner', # google
 'fdavis:si.rr.com' => 'Frank Davis',
 'felipewd:terra.com.br' => 'Felipe Damasio', # by self (did not ask to include the W.)
@@ -484,6 +489,7 @@
 'hermes:gibson.dropbear.id.au' => 'David Gibson',
 'hirofumi:mail.parknet.co.jp' => 'Hirofumi Ogawa', # corrected by himself
 'hoho:binbash.net' => 'Colin Slater',
+'hollisb:us.ibm.com' => 'Hollis Blanchard',
 'hpa:transmeta.com' => 'H. Peter Anvin',
 'hpa:zytor.com' => 'H. Peter Anvin',
 'hugh:veritas.com' => 'Hugh Dickins',
@@ -573,6 +579,7 @@
 'joe:wavicle.org' => 'Joe Burks',
 'joel.buckley:sun.com' => 'Joel Buckley',
 'joergprante:netcologne.de' => 'Jörg Prante',
+'joern:wohnheim.fh-wedel.de' => 'Jörn Engel',
 'johan.adolfsson:axis.com' => 'Johan Adolfsson',
 'johann.deneux:it.uu.se' => 'Johann Deneux',
 'johann.deneux:laposte.net' => 'Johann Deneux',
@@ -644,8 +651,7 @@
 'kuebelr:email.uc.edu' => 'Robert Kuebel',
 'kumarkr:us.ibm.com' => 'Krishna Kumar',
 'kunihiro:ipinfusion.com' => 'Kunihiro Ishiguro',
-'kuznet:mops.inr.ac.ru' => 'Alexey Kuznetsov',
-'kuznet:ms2.inr.ac.ru' => 'Alexey Kuznetsov',
+'kurt.robideau:comtrol.com' => 'Kurt Robideau',	# wild guess
 'l.s.r:web.de' => 'René Scharfe',
 'ladis:psi.cz' => 'Ladislav Michl',
 'laforge:gnumonks.org' => 'Harald Welte',
@@ -661,15 +667,15 @@
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
@@ -785,8 +791,8 @@
 'nico:cam.org' => 'Nicolas Pitre',
 'nico:org.rmk.(none)' => 'Nicolas Pitre',
 'nicolas.aspert:epfl.ch' => 'Nicolas Aspert',
-'nicolas:dupeux.net' => 'Nicolas Dupeux',
 'nicolas.mailhot:laposte.net' => 'Nicolas Mailhot',
+'nicolas:dupeux.net' => 'Nicolas Dupeux',
 'niv:us.ibm.com' => 'Nivedita Singhvi',
 'nivedita:w-nivedita.beaverton.ibm.com' => 'Nivedita Singhvi',
 'nkbj:image.dk' => 'Niels Kristian Bech Jensen',
@@ -955,7 +961,6 @@
 'scameron:quandary.cca.cpqcorp.net' => 'Steve Cameron',
 'schlicht:uni-mannheim.de' => 'Thomas Schlichter',
 'schlicht:uni-mannheimn.de' => 'Thomas Schlichter',	# it's typo IMHO
-'shmulik.hen:intel.com' => 'Shmulik Hen',
 'schoenfr:gaaertner.de' => 'Erik Schoenfelder',
 'schwab:suse.de' => 'Andreas Schwab',
 'schwidefsky:de.ibm.com' => 'Martin Schwidefsky',
@@ -974,6 +979,7 @@
 'shemminger:osdl.org' => 'Stephen Hemminger',
 'shields:msrl.com' => 'Michael Shields',
 'shingchuang:via.com.tw' => 'Shing Chuang',
+'shmulik.hen:intel.com' => 'Shmulik Hen',
 'silicon:falcon.sch.bme.hu' => 'Szilárd Pásztor', # google
 'simonb:lipsyncpost.co.uk' => 'Simon Burley',
 'skip.ford:verizon.net' => 'Skip Ford',
@@ -988,11 +994,13 @@
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
@@ -1035,6 +1043,7 @@
 'thockin:freakshow.cobalt.com' => 'Tim Hockin',
 'thockin:sun.com' => 'Tim Hockin',
 'thomas:bender.thinknerd.de' => 'Thomas Walpuski',
+'thomas:osterried.de' => 'Thomas Osterried',
 'thunder:ngforever.de' => 'Thunder From The Hill',
 'tigran:aivazian.name' => 'Tigran Aivazian',
 'tim:physik3.uni-rostock.de' => 'Tim Schmielau',
@@ -1710,6 +1719,18 @@
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

