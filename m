Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272825AbTG3Iki (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 04:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272821AbTG3Ikh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 04:40:37 -0400
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:2945 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S272825AbTG3Iju convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 04:39:50 -0400
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo@conectiva.com.br
Subject: lk-changelog.pl 0.153
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Wed_Jul_30_08_39_47_UTC_2003_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20030730083947.DBE33CA94@merlin.emma.line.org>
Date: Wed, 30 Jul 2003 10:39:47 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a semi-automatic announcement.

lk-changelog.pl aka. shortlog version 0.153 has been released.

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
revision 0.153
date: 2003/07/30 08:12:10;  author: vita;  state: Exp;  lines: +7 -1
3 new addresses
----------------------------
revision 0.152
date: 2003/07/28 06:47:23;  author: vita;  state: Exp;  lines: +13 -1
added 9 names for new addresses
----------------------------
revision 0.151
date: 2003/07/25 12:39:21;  author: vita;  state: Exp;  lines: +5 -1
add 1 address
----------------------------
revision 0.150
date: 2003/07/21 09:07:06;  author: vita;  state: Exp;  lines: +7 -2
resort address->name hash with LC_ALL=POSIX sort -u
----------------------------
revision 0.149
date: 2003/07/21 09:03:12;  author: vita;  state: Exp;  lines: +19 -4
added 10 names for new addresses
put davem's addresses into @addrregexps
precise kuznet's regexp
----------------------------
revision 0.148
date: 2003/07/15 12:59:09;  author: vita;  state: Exp;  lines: +8 -1
added 4 names for new addresses
----------------------------
revision 0.147
date: 2003/07/14 15:31:34;  author: vita;  state: Exp;  lines: +6 -1
added 2 names for new addresses
----------------------------
revision 0.146
date: 2003/07/13 09:25:39;  author: emma;  state: Exp;  lines: +5 -1
add 1 address
----------------------------
revision 0.145
date: 2003/07/11 08:37:05;  author: vita;  state: Exp;  lines: +9 -2
add 4 names for new addresses; resort address->name hash
=============================================================================
Index: lk-changelog.pl
===================================================================
RCS file: /var/CVS/lk-changelog/lk-changelog.pl,v
retrieving revision 0.145
retrieving revision 0.153
diff -u -r0.145 -r0.153
--- lk-changelog.pl	11 Jul 2003 08:37:05 -0000	0.145
+++ lk-changelog.pl	30 Jul 2003 08:12:10 -0000	0.153
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.145 2003/07/11 08:37:05 vita Exp $
+# $Id: lk-changelog.pl,v 0.153 2003/07/30 08:12:10 vita Exp $
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
@@ -119,6 +123,7 @@
 'ac9410:attbi.com' => 'Albert Cranford',
 'ac9410:bellsouth.net' => 'Albert Cranford',
 'acher:in.tum.de' => 'Georg Acher',
+'achirica:telefonica.net' => 'Javier Achirica',
 'achirica:ttd.net' => 'Javier Achirica',
 'acme:brinquedo.oo.ps' => 'Arnaldo Carvalho de Melo',
 'acme:conectiva.com.br' => 'Arnaldo Carvalho de Melo',
@@ -156,6 +161,7 @@
 'akropel1:rochester.rr.com' => 'Adam Kropelin', # lbdb
 'alan:lxorguk.ukuu.org.uk' => 'Alan Cox',
 'alan:redhat.com' => 'Alan Cox',
+'albertogli:telpin.com.ar' => 'Alberto Bertogli',
 'alborchers:steinerpoint.com' => 'Al Borchers',
 'alex:ssi.bg' => 'Alexander Atanasov',
 'alex_williamson:attbi.com' => 'Alex Williamson', # lbdb
@@ -193,6 +199,7 @@
 'arndb:de.ibm.com' => 'Arnd Bergmann',
 'arndt:lin02384n012.mc.schoenewald.de' => 'Arndt Schoenewald',
 'arun.sharma:intel.com' => 'Arun Sharma',
+'arzie:dds.nl' => 'Robert Zwerus',
 'aschultz:warp10.net' => 'Andreas Schultz',
 'asit.k.mallick:intel.com' => 'Asit K. Mallick', # by Kristian Peters
 'asl:launay.org' => 'Arnaud S. Launay',
@@ -235,6 +242,7 @@
 'bhavesh:avaya.com' => 'Bhavesh P. Davda',
 'bheilbrun:paypal.com' => 'Brad Heilbrun', # by himself
 'bjorn.andersson:erc.ericsson.se' => 'Björn Andersson', # google, guessed ö
+'bjorn.helgaas:hp.com' => 'Bjorn Helgaas',
 'bjorn.wesen:axis.com' => 'Bjorn Wesen',
 'bjorn_helgaas:hp.com' => 'Bjorn Helgaas',
 'bk:suse.de' => 'Bernhard Kaindl',
@@ -249,6 +257,7 @@
 'brm:murphy.dk' => 'Brian Murphy',
 'brownfld:irridia.com' => 'Ken Brownfield',
 'bryder:paradise.net.nz' => 'Bill Ryder',
+'buffer:antifork.org' => "Angelo Dell'Aera",
 'bunk:fs.tum.de' => 'Adrian Bunk',
 'buytenh:gnu.org' => 'Lennert Buytenhek',
 'bwa:us.ibm.com' => 'Bruce Allan',
@@ -282,6 +291,7 @@
 'christer:weinigel.se' => 'Christer Weinigel', # from shortlog
 'christopher.leech:intel.com' => 'Christopher Leech',
 'christopher:intel.com' => 'Christopher Goldfarb',
+'chyang:clusterfs.com' => 'Chen Yang',
 'cip307:cip.physik.uni-wuerzburg.de' => 'Jochen Karrer', # from shortlog
 'ckulesa:as.arizona.edu' => 'Craig Kulesa',
 'clemens:ladisch.de' => 'Clemens Ladisch',
@@ -334,8 +344,6 @@
 'davej:tetrachloride.(none)' => 'Dave Jones',
 'davem:hera.kernel.org' => 'David S. Miller',
 'davem:kernel.bkbits.net' => 'David S. Miller',
-'davem:nuts.ninka.net' => 'David S. Miller',
-'davem:pizda.ninka.net' => 'David S. Miller', # guessed
 'davem:redhat.com' => 'David S. Miller',
 'david-b:pacbell.com' => 'David Brownell',
 'david-b:pacbell.net' => 'David Brownell',
@@ -469,6 +477,7 @@
 'gnb:alphalink.com.au' => 'Greg Banks',
 'go:turbolinux.co.jp' => 'Go Taniguchi',
 'gone:us.ibm.com' => 'Patricia Gaughen',
+'gorgo:thunderchild.debian.net' => 'Madarasz Gergely',
 'gotom:debian.or.jp' => 'Goto Masanori', # from shortlog
 'gphat:cafes.net' => 'Cory Watson',
 'greearb:candelatech.com' => 'Ben Greear',
@@ -535,7 +544,9 @@
 'iwi:atm.ox.ac.uk' => 'Alan Iwi',
 'j-nomura:ce.jp.nec.com' => 'Junichi Nomura',
 'j.dittmer:portrix.net' => 'Jan Dittmer',
+'ja:ssi.bg' => 'Julian Anastasov',
 'jack:suse.cz' => 'Jan Kara',
+'jack:ucw.cz' => 'Jan Kara',
 'jack_hammer:adaptec.com' => 'Jack Hammer',
 'jackson:realtek.com.tw' => 'Ian Jackson',
 'jaharkes:cs.cmu.edu' => 'Jan Harkes',
@@ -549,8 +560,10 @@
 'jamey.hicks:hp.com' => 'Jamey Hicks',
 'jamey:crl.dec.com' => 'Jamey Hicks',
 'jamie:shareable.org' => 'Jamie Lokier',
+'jan:zuchhold.com' => 'Jan Zuchhold',
 'jani:astechnix.ro' => 'Jani Monoses',
 'jani:iv.ro' => 'Jani Monoses',
+'jasper:vs19.net' => 'Jasper Spaans',
 'javaman:katamail.com' => 'Paulo Ornati',
 'jay.estabrook:compaq.com' => 'Jay Estabrook',
 'jb:jblache.org' => 'Julien Blache',
@@ -558,6 +571,7 @@
 'jbglaw:lug-owl.de' => 'Jan-Benedict Glaw',
 'jblack:linuxguru.net' => 'James Blackwell',
 'jbm:joshisanerd.com' => 'Josh Myer',
+'jbourne:hardrock.org' => 'James Bourne',
 'jcdutton:users.sourceforge.net' => 'James Courtier-Dutton',
 'jdavid:farfalle.com' => 'David Ruggiero',
 'jdike:jdike.wstearns.org' => 'Jeff Dike',
@@ -577,6 +591,7 @@
 'jenna.s.hall:intel.com' => 'Jenna S. Hall', # google
 'jes:trained-monkey.org' => 'Jes Sorensen',
 'jes:wildopensource.com' => 'Jes Sorensen',
+'jfbeam:bluetronic.net' => 'Ricky Beam',
 'jgarzik:fokker2.devel.redhat.com' => 'Jeff Garzik',
 'jgarzik:hum.(none)' => 'Jeff Garzik',
 'jgarzik:mandrakesoft.com' => 'Jeff Garzik',
@@ -594,6 +609,7 @@
 'jh:sgi.com' => 'John Hesterberg',
 'jhammer:us.ibm.com' => 'Jack Hammer',
 'jhartmann:addoes.com' => 'Jeff Hartmann',
+'jiho:c-zone.net' => 'Jim Howard',
 'jim.houston:attbi.com' => 'Jim Houston',
 'jkenisto:us.ibm.com' => 'James Keniston',
 'jkt:helius.com' => 'Jack Thomasson',
@@ -620,6 +636,7 @@
 'johnf:whitsunday.net.au' => 'John W. Fort',
 'johnpol:2ka.mipt.ru' => 'Evgeniy Polyakov',
 'johnstul:us.ibm.com' => 'John Stultz',
+'jones:ingate.com' => 'Jones Desougi',
 'josh:joshisanerd.com' => 'Josh Myer',
 'jsiemes:web.de' => 'Josef Siemes',
 'jsimmons:heisenberg.transvirtual.com' => 'James Simmons',
@@ -648,6 +665,7 @@
 'kai:vaio.(none)' => 'Kai Germaschewski',
 'kai:zephyr.physics.uiowa.edu' => 'Kai Germaschewski',
 'kala:pinerecords.com' => 'Tomas Szepe',
+'kambo77:hotmail.com' => 'Kambo Lohan',
 'kanoj:vger.kernel.org' => 'Kanoj Sarcar', # sent by Arnaldo Carvalho de Melo
 'kanojsarcar:yahoo.com' => 'Kanoj Sarcar',
 'kaos:ocs.com.au' => 'Keith Owens',
@@ -699,12 +717,14 @@
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
@@ -744,9 +764,11 @@
 'margitsw:t-online.de' => 'Margit Schubert-While',
 'marijnk:gmx.co.uk' => 'Marijn Kruisselbrink',
 'marius:citi.umich.edu' => 'Marius Aamodt Eriksen',
+'mark.fasheh:oracle.com' => 'Mark Fasheh',
 'mark:alpha.dyndns.org' => 'Mark W. McClelland',
 'mark:hal9000.dyndns.org' => 'Mark W. McClelland',
 'markh:osdl.org' => 'Mark Haverkamp',
+'martin.bene:icomedias.com' => 'Martin Bene',
 'martin.bligh:us.ibm.com' => 'Martin J. Bligh',
 'martin.schwidefsky:debitel.net' => 'Martin Schwidefsky',
 'martin:bruli.net' => 'Martin Brulisauer',
@@ -754,6 +776,7 @@
 'martin:meltin.net' => 'Martin Schwenke',
 'mashirle:us.ibm.com' => 'Shirley Ma',
 'mason:suse.com' => 'Chris Mason',
+'mathieu:newview.com' => 'Mathieu Chouquet-Stringer',
 'matt_domsch:dell.com' => 'Matt Domsch', # sent by himself
 'matthew:wil.cx' => 'Matthew Wilcox',
 'matthias.andree:gmx.de' => 'Matthias Andree', # added by himself
@@ -778,6 +801,7 @@
 'michal:harddata.com' => 'Michal Jaegermann',
 'mikael.starvik:axis.com' => 'Mikael Starvik',
 'mikal:stillhq.com' => 'Michael Still',
+'mike.miller:hp.com' => 'Mike Miller',
 'mike:aiinc.ca' => 'Michael Hayes',
 'mikenc:us.ibm.com' => 'Mike Christie',
 'mikep:linuxtr.net' => 'Mike Phillips',
@@ -836,6 +860,7 @@
 'niv:us.ibm.com' => 'Nivedita Singhvi',
 'nivedita:w-nivedita.beaverton.ibm.com' => 'Nivedita Singhvi',
 'nkbj:image.dk' => 'Niels Kristian Bech Jensen',
+'nkiesel:tbdnetworks.com' => 'Norbert Kiesel',
 'nlaredo:transmeta.com' => 'Nathan Laredo',
 'nmiell:attbi.com' => 'Nicholas Miell',
 'nobita:t-online.de' => 'Andreas Busch',
@@ -917,6 +942,7 @@
 'pmanolov:lnxw.com' => 'Petko Manolov',
 'pmenage:ensim.com' => 'Paul Menage',
 'porter:cox.net' => 'Matt Porter',
+'pp:netppl.fi' => 'Pekka Pietikäinen',
 'ppc64:brule.rchland.ibm.com' => 'Peter Bergner',
 'prom:berlin.ccc.de' => 'Ingo Albrecht',
 'proski:gnu.org' => 'Pavel Roskin',
@@ -1012,6 +1038,7 @@
 'schwidefsky:de.ibm.com' => 'Martin Schwidefsky',
 'scott.feldman:intel.com' => 'Scott Feldman',
 'scott_anderson:mvista.com' => 'Scott Anderson',
+'scottm:minion.yyz.somanetworks.com' => 'Scott Murray',
 'scottm:somanetworks.com' => 'Scott Murray',
 'sct:redhat.com' => 'Stephen C. Tweedie',
 'sds:epoch.ncsc.mil' => 'Stephen D. Smalley',
@@ -1035,6 +1062,7 @@
 'smb:smbnet.de' => 'Stefan M. Brandl',
 'smurf:osdl.org' => 'Nathan Dabney',
 'snailtalk:linux-mandrake.com' => 'Geoffrey Lee', # by himself
+'sneakums:zork.net' => 'Sean Neakums',
 'solar:openwall.com' => 'Solar Designer',
 'solt:dns.toxicfilms.tv' => 'Maciej Soltysiak',
 'soruk:eridani.co.uk' => 'Michael McConnell',
@@ -1096,6 +1124,7 @@
 'thockin:sun.com' => 'Tim Hockin',
 'thomas:bender.thinknerd.de' => 'Thomas Walpuski',
 'thomas:osterried.de' => 'Thomas Osterried',
+'thomr9am:ss1000.ms.mff.cuni.cz' => 'Rudo Thomas',
 'thornber:sistina.com' => 'Joe Thornber',
 'thunder:ngforever.de' => 'Thunder From The Hill',
 'tigran:aivazian.name' => 'Tigran Aivazian',
@@ -1133,6 +1162,7 @@
 'varenet:parisc-linux.org' => 'Thibaut Varene',
 'vberon:mecano.gme.usherb.ca' => 'Vincent Béron',
 'venkatesh.pallipadi:intel.com' => 'Venkatesh Pallipadi',
+'vherva:niksula.hut.fi' => 'Ville Herva',
 'vinay-rc:naturesoft.net' => 'Vinay K. Nallamothu',
 'viro:math.psu.edu' => 'Alexander Viro',
 'viro:parcelfarce.linux.theplanet.co.uk' => 'Alexander Viro',
@@ -1153,6 +1183,7 @@
 'wayne:stallion.oz.au' => 'Wayne Piekarski',
 'wd:denx.de' => 'Wolfgang Denk',
 'weigand:immd1.informatik.uni-erlangen.de' => 'Ulrich Weigand',
+'wensong:linux-vs.org' => 'Wensong Zhang',
 'wes:infosink.com' => 'Wes Schreiner',
 'wesolows:foobazco.org' => 'Keith M. Wesolowski',
 'wg:malloc.de' => 'Wolfram Gloger', # lbdb
@@ -1177,6 +1208,7 @@
 'xavier.bru:bull.net' => 'Xavier Bru',
 'xkaspa06:stud.fee.vutbr.cz' => 'Tomas Kasparek',
 'ya:slamail.org' => 'Yaacov Akiba Slama',
+'yinah:couragetech.com.cn' => 'Yin Aihua',
 'yokota:netlab.is.tsukuba.ac.jp' => 'Yokota Hiroshi',
 'yoshfuji:linux-ipv6.org' => 'Hideaki Yoshifuji', # lbdb
 'yoshfuji:nuts.ninka.net' => 'Hideaki Yoshifuji',
@@ -1777,6 +1809,32 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.153  2003/07/30 08:12:10  vita
+# 3 new addresses
+#
+# Revision 0.152  2003/07/28 06:47:23  vita
+# added 9 names for new addresses
+#
+# Revision 0.151  2003/07/25 12:39:21  vita
+# add 1 address
+#
+# Revision 0.150  2003/07/21 09:07:06  vita
+# resort address->name hash with LC_ALL=POSIX sort -u
+#
+# Revision 0.149  2003/07/21 09:03:12  vita
+# added 10 names for new addresses
+# put davem's addresses into @addrregexps
+# precise kuznet's regexp
+#
+# Revision 0.148  2003/07/15 12:59:09  vita
+# added 4 names for new addresses
+#
+# Revision 0.147  2003/07/14 15:31:34  vita
+# added 2 names for new addresses
+#
+# Revision 0.146  2003/07/13 09:25:39  emma
+# add 1 address
+#
 # Revision 0.145  2003/07/11 08:37:05  vita
 # add 4 names for new addresses; resort address->name hash
 #

