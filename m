Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266541AbUGPMwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266541AbUGPMwf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 08:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266544AbUGPMwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 08:52:35 -0400
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:9864 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S266541AbUGPMwH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 08:52:07 -0400
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: lk-changelog.pl 0.314
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Fri_Jul_16_12_52_03_UTC_2004_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20040716125204.13E26C3DAA@merlin.emma.line.org>
Date: Fri, 16 Jul 2004 14:52:04 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a semi-automatic announcement.

lk-changelog.pl aka. shortlog version 0.314 has been released.

This script is used by Linus and Marcelo to rearrange and reformat BK
ChangeSet logs into a more human-readable format, and the official
repository is Parent repository is http://bktools.bkbits.net/bktools

As the script has grown large, this mail only contains a diff against
the last released version.

You can always download the full script and GPG signatures from
http://home.pages.de/~mandree/linux/kernel/

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
revision 0.314
date: 2004/07/16 12:51:21;  author: emma;  state: Exp;  lines: +3 -3
Bugfix: do not strip Kishore A K -> K A. Reported by vita.
----------------------------
revision 0.313
date: 2004/07/16 12:42:59;  author: emma;  state: Exp;  lines: +5 -1
Add two comments to document code.
----------------------------
revision 0.312
date: 2004/07/16 11:12:08;  author: vita;  state: Exp;  lines: +12 -1
added 11 new addresses
----------------------------
revision 0.311
date: 2004/07/12 13:36:52;  author: vita;  state: Exp;  lines: +4 -2
2 new addresses; 1 correction
----------------------------
revision 0.310
date: 2004/07/12 10:37:33;  author: emma;  state: Exp;  lines: +2 -3
Fix one address to ISO-8859-1, drop one bogus entry.
Reported by vita.
----------------------------
revision 0.309
date: 2004/07/12 09:00:05;  author: emma;  state: Exp;  lines: +25 -1
Pull in Linus' addresses.
----------------------------
revision 0.308
date: 2004/07/12 08:54:03;  author: emma;  state: Exp;  lines: +74 -31
Implement address preference logic.
Add LINUXKERNEL_BK_FMT_DEBUG environment variable to enable debug w/o code change.
Remove some trailing whitespace.
----------------------------
revision 0.307
date: 2004/07/02 08:59:44;  author: vita;  state: Exp;  lines: +6 -1
added 5 new addresses
=============================================================================
Index: lk-changelog.pl
===================================================================
RCS file: /var/CVS/lk-changelog/lk-changelog.pl,v
retrieving revision 0.307
diff -u -r0.307 lk-changelog.pl
--- lk-changelog.pl	2 Jul 2004 08:59:44 -0000	0.307
+++ lk-changelog.pl	16 Jul 2004 12:51:25 -0000
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.307 2004/07/02 08:59:44 vita Exp $
+# $Id: lk-changelog.pl,v 0.314 2004/07/16 12:51:21 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -68,6 +68,11 @@
 my $debug = 0;
 # --------------------------------------------------------------------
 
+if (defined $ENV{LINUXKERNEL_BK_FMT_DEBUG}
+	and $ENV{LINUXKERNEL_BK_FMT_DEBUG}) {
+    $debug = 1;
+}
+
 # Perl syntax magic here, "=>" is equivalent to ","
 my @addrregexps = (
 [ 'alan@[^.]+\.swansea\.linux\.org\.uk' => 'Alan Cox', ],
@@ -139,6 +144,7 @@
 'a.othieno:bluewin.ch' => 'Arthur Othieno',
 'a.othieno:ch.rmk.(none)' => 'Arthur Othieno',
 'a.wegele:tu-bs.de' => 'Artur Wegele',
+'a1tmblwd:netscape.net' => 'Kam Leo',
 'aaron.baranoff:tsc.tdk.com' => 'Aaron Baranoff',
 'abbotti:mev.co.uk' => 'Ian Abbott',
 'abraham:2d3d.co.za' => 'Abraham van der Merwe',
@@ -187,6 +193,7 @@
 'agx:sigxcpu.org' => 'Guido Guenther',
 'ahaas:airmail.net' => 'Art Haas',
 'ahaas:neosoft.com' => 'Art Haas',
+'aherrman:de.ibm.com' => 'Andreas Herrmann',
 'ahu:ds9a.nl' => 'Bert Hubert',
 'aia21:cam.ac.uk' => 'Anton Altaparmakov',
 'aia21:cantab.net' => 'Anton Altaparmakov',
@@ -196,6 +203,7 @@
 'airlied:pdx.freedesktop.org' => 'Dave Airlie',
 'airlied:starflyer.(none)' => 'Dave Airlie',
 'aj:andaco.de' => 'Andreas Jochens',
+'aj:net-lab.net' => 'Andreas John',
 'ajgrothe:yahoo.com' => 'Aaron Grothe',
 'ajm:sgi.com' => 'Alan Mayer',
 'ajoshi:kernel.crashing.org' => 'Ani Joshi',
@@ -224,6 +232,7 @@
 'alessandro.zummo:towertech.it' => 'Alessandro Zummo',
 'alex.williamson:com.rmk.(none)' => 'Alex Williamson',
 'alex.williamson:hp.com' => 'Alex Williamson',
+'alex:alexdalton.org' => 'Alexandre d\'Alton',
 'alex:clusterfs.com' => 'Alex Tomas',
 'alex:de.rmk.(none)' => 'Alexander Schulz',
 'alex:ssi.bg' => 'Alexander Atanasov',
@@ -262,6 +271,7 @@
 'andries.brouwer:cwi.nl' => 'Andries E. Brouwer',
 'andros:citi.umich.edu' => 'Andy Adamson',
 'andyw:uk.ibm.com' => 'Andy Whitcroft',
+'aneesh.kumar:gmail.com' => 'Aneesh Kumar',
 'angus.sawyer:dsl.pipex.com' => 'Angus Sawyer',
 'ankry:green.mif.pg.gda.pl' => 'Andrzej Krzysztofowicz',
 'anton:samba.org' => 'Anton Blanchard',
@@ -319,6 +329,7 @@
 'bart:samwel.tk' => 'Bart Samwel',
 'bbosch:iphase.com' => 'Bradley A. Bosch',
 'bbuesker:qualcomm.com' => 'Brian Buesker',
+'bcasavan:sgi.com' => 'Brent Casavant',
 'bcollins:debian.org' => 'Ben Collins',
 'bcrl:bob.home.kvack.org' => 'Benjamin LaHaise',
 'bcrl:redhat.com' => 'Benjamin LaHaise',
@@ -365,6 +376,7 @@
 'boutcher:us.ibm.com' => 'Dave Boutcher',
 'braam:clusterfs.com' => 'Peter Braam',
 'brad:wasp.net.au' => 'Brad Campbell',
+'braunu:de.ibm.com' => 'Ursula Braun-Krahl',
 'brazilnut:us.ibm.com' => 'Don Fry',
 'brett:bad-sports.com' => 'Brett Pemberton',
 'brewt-linux-kernel:brewt.org' => 'Adrian Yee',
@@ -380,6 +392,7 @@
 'bunk:de.rmk.(none)' => 'Adrian Bunk', # guessed
 'bunk:fs.tum.de' => 'Adrian Bunk',
 'buytenh:gnu.org' => 'Lennert Buytenhek',
+'buytenh:wantstofly.org' => 'Lennert Buytenhek',
 'bwa:us.ibm.com' => 'Bruce Allan',
 'bwheadley:earthlink.net' => 'Bryan W. Headley',
 'bwindle:fint.org' => 'Burton N. Windle',
@@ -402,6 +415,7 @@
 'cattelan:naboo.americas.sgi.com' => 'Russell Cattelan',
 'cattelan:naboo.eagan' => 'Russell Cattelan',
 'cattelan:sgi.com' => 'Russell Cattelan', # google
+'cborntra:de.ibm.com' => 'Christian Bornträger',
 'ccaputo:alt.net' => 'Chris Caputo',
 'ccheney:cheney.cx' => 'Christopher L. Cheney',
 'cel:citi.umich.edu' => 'Chuck Lever',
@@ -419,6 +433,7 @@
 'charles.white:hp.com' => 'Charles White',
 'chessman:tux.org' => 'Samuel S. Chessman',
 'chip:pobox.com' => 'Chip Salzenberg', # lbdb
+'chris:heathens.co.nz' => 'Chris Heath',
 'chris:qwirx.com' => 'Chris Wilson',
 'chris:wirex.com' => 'Chris Wright',
 'chrisg:etnus.com' => 'Chris Gottbrath',
@@ -454,6 +469,7 @@
 'coreyed:linxtechnologies.com' => 'Corey Edwards',
 'corryk:us.ibm.com' => 'Kevin Corry',
 'cort:fsmlabs.com' => 'Cort Dougan',
+'cotte:de.ibm.com' => 'Carsten Otte',
 'coughlan:redhat.com' => 'Tom Coughlan',
 'coywolf:greatcn.org' => 'Coywolf Qi Hunt',
 'cpg:aladdin.de' => 'Christian Groessler',
@@ -577,6 +593,7 @@
 'dougg:torque.net' => 'Douglas Gilbert',
 'drb:med.co.nz' => 'Ross Boswell',
 'drepper:redhat.com' => 'Ulrich Drepper',
+'drewie:freemail.hu' => 'Andras Bali',
 'driver:huey.jpl.nasa.gov' => 'Bryan B. Whitehead', # google
 'drow:false.org' => 'Daniel Jacobowitz',
 'drow:nevyn.them.org' => 'Daniel Jacobowitz',
@@ -687,6 +704,7 @@
 'francis.wiran:hp.com' => 'Francis Wiran',
 'frank.a.uepping:t-online.de' => 'Frank A. Uepping',
 'frank.cornelis:elis.ugent.be' => 'Frank Cornelis',
+'frankie:cse.unsw.edu.au' => 'Frank Engel',
 'franz.sirl-kernel:lauterbach.com' => 'Franz Sirl',
 'franz.sirl:lauterbach.com' => 'Franz Sirl',
 'frederik.deweerdt:laposte.net' => 'Frederik Deweerdt',
@@ -699,6 +717,7 @@
 'g.liakhovetski:gmx.de' => 'Guennadi Liakhovetski',
 'gaa:ulticom.com' => 'Gary Algier', # google
 'galak:blarg.somerset.sps.mot.com' => 'Kumar Gala',
+'galak:somerset.sps.mot.com' => 'Kumar Gala',
 'ganadist:nakyup.mizi.com' => 'Cha Young-Ho',
 'gandalf:netfilter.org' => 'Martin Josefsson',
 'gandalf:winds.org' => 'Byron Stanoszek',
@@ -717,6 +736,7 @@
 'george:mvista.com' => 'George Anzinger',
 'georgn:somanetworks.com' => 'Georg Nikodym',
 'gerald.schaefer:gmx.net' => 'Gerald Schaefer',
+'geraldsc:de.ibm.com' => 'Gerald Schaefer',
 'gerg:moreton.com.au' => 'Greg Ungerer',
 'gerg:snapgear.com' => 'Greg Ungerer',
 'ghoz:sympatico.ca' => 'Ghozlane Toumi',
@@ -806,8 +826,10 @@
 'hoho:binbash.net' => 'Colin Slater',
 'hollisb:us.ibm.com' => 'Hollis Blanchard',
 'holt:sgi.com' => 'Robin Holt',
+'holzheu:de.ibm.com' => 'Michael Holzheu',
 'home:mdiehl.de' => 'Martin Diehl',
 'horms:verge.net.au' => 'Simon Horman',
+'horst.hummel:de.ibm.com' => 'Horst Hummel',
 'hpa:transmeta.com' => 'H. Peter Anvin',
 'hpa:zytor.com' => 'H. Peter Anvin',
 'huangt:star-net.cn' => 'Tao Huang',
@@ -841,6 +863,7 @@
 'j-nomura:ce.jp.nec.com' => 'Junichi Nomura',
 'j.dittmer:portrix.net' => 'Jan Dittmer',
 'ja:ssi.bg' => 'Julian Anastasov',
+'jaap.keuter:xs4all.nl' => 'Jaap Keuter',
 'jack:suse.cz' => 'Jan Kara',
 'jack:ucw.cz' => 'Jan Kara',
 'jack_hammer:adaptec.com' => 'Jack Hammer',
@@ -912,6 +935,7 @@
 'jes:trained-monkey.org' => 'Jes Sorensen',
 'jes:wildopensource.com' => 'Jes Sorensen',
 'jesse.brandeburg:intel.com' => 'Jesse Brandeburg',
+'jesse:cola.voip.idv.tw' => 'Wen-chien Jesse Sung',
 'jet:gyve.org' => 'Masatake Yamato',
 'jfbeam:bluetronic.net' => 'Ricky Beam',
 'jgarzik:fokker2.devel.redhat.com' => 'Jeff Garzik',
@@ -932,6 +956,7 @@
 'jh:sgi.com' => 'John Hesterberg',
 'jhammer:us.ibm.com' => 'Jack Hammer',
 'jhartmann:addoes.com' => 'Jeff Hartmann',
+'jheffner:psc.edu' => 'John Heffner',
 'jhf:rivenstone.net' => 'Joseph Fannin',
 'jhh:lucent.com' => 'Jorge Hernandez-Herrero',
 'jholmes:psu.edu' => 'Jason Holmes',
@@ -1135,6 +1160,7 @@
 'lfo:polyad.org' => 'Luis F. Ortiz',
 'liam.girdwood:wolfsonmicro.com' => 'Liam Girdwood',
 'linas:austin.ibm.com' => 'Linas Vepstas',
+'linas:linas.org' => 'Linas Vepstas',
 'linas:us.ibm.com' => 'Linas Vepstas',
 'linux-kernel:n-dimensional.de' => 'Hans Ulrich Niedermann',
 'linux-kernel:vortech.net' => 'Joshua Jackson',
@@ -1146,6 +1172,7 @@
 'linux:dominikbrodowski.de' => 'Dominik Brodowski',
 'linux:hazard.jcu.cz' => 'Jan Marek',
 'linux:kodeaffe.de' => 'Sebastian Henschel',
+'linux:michaelgeng.de' => 'Michael Geng',
 'linux:sandersweb.net' => 'David Sanders',
 'linux:thorsten-knabe.de' => 'Thorsten Knabe',
 'linux:youmustbejoking.demon.co.uk' => 'Darren Salt',
@@ -1249,6 +1276,7 @@
 'matthewn:snapgear.com' => 'Matthew Natalier',
 'matthias.andree:gmx.de' => 'Matthias Andree', # added by himself
 'mauelshagen:sistina.com' => 'Heinz J. Mauelshagen',
+'maxim:de.ibm.com' => 'Maxim Shchetynin',
 'maxk:qualcomm.com' => 'Maksim Krasnyanskiy',
 'maxk:viper.(none)' => 'Maksim Krasnyanskiy', # from shortlog
 'maxk:viper.qualcomm.com' => 'Maksim Krasnyanskiy',
@@ -1403,6 +1431,7 @@
 'noodles:earth.li' => 'Jonathan McDowell',
 'normalperson:yhbt.net' => 'Eric Wong',
 'not:just.any.name' => 'John Fremlin',
+'notting:redhat.com' => 'Bill Nottingham',
 'nstraz:sgi.com' => 'Nathan Straz',
 'ntfs:flatcap.org' => 'Richard Russon', # lbdb
 'numlock:freesurf.ch' => 'Joël Bourquard',
@@ -1426,6 +1455,7 @@
 'oliver:vermuden.neukum.org' => 'Oliver Neukum',
 'olof:austin.ibm.com' => 'Olof Johansson',
 'omkhar:rogers.com' => 'Omkhar Arasaratnam',
+'orange:fobie.net' => 'Örjan Persson',
 'orjan.friberg:axis.com' => 'Orjan Friberg',
 'os:emlix.com' => 'Oskar Schirmer', # sent by himself
 'ossi:kde.org' => 'Oswald Buddenhagen',
@@ -1457,6 +1487,7 @@
 'paul.clements:steeleye.com' => 'Paul Clements',
 'paul.focke:pandora.be' => 'Paul Focke',
 'paul.mundt:timesys.com' => 'Paul Mundt', # google
+'paul:allied-universal.com' => 'Paul King',
 'paul:kungfoocoder.org' => 'Paul Wagland', # lbdb
 'paul:serice.net' => 'Paul Serice',
 'paul:wagland.net' => 'Paul Wagland', # lbdb
@@ -1496,11 +1527,13 @@
 'perex:pnote.perex-int.cz' => 'Jaroslav Kysela',
 'perex:suse.cz' => 'Jaroslav Kysela',
 'perrye:linuxmail.org' => 'Perry Gilfillan', # lbdb
+'peter.oberparleiter:de.ibm.com' => 'Peter Oberparleiter',
 'peter:bergner.org' => 'Peter Bergner',
 'peter:cadcamlab.org' => 'Peter Samuelson',
 'peter:chubb.wattle.id.au' => 'Peter Chubb',
 'peterc:chubb.wattle.id.au' => 'Peter Chubb',
 'peterc:gelato.unsw.edu.au' => 'Peter Chubb',
+'peterm:redhat.com' => 'Peter Martuccelli',
 'peterm:remware.demon.co.uk' => 'Peter Milne',
 'peterm:uk.rmk.(none)' => 'Peter Milne',
 'petero2:telia.com' => 'Peter Osterlund',
@@ -1532,6 +1565,7 @@
 'plars:austin.ibm.com' => 'Paul Larson',
 'plars:linuxtestproject.org' => 'Paul Larson',
 'plcl:telefonica.net' => 'Pedro Lopez-Cabanillas',
+'pluto:pld-linux.org' => 'Pawel Sikora',
 'pmanolov:lnxw.com' => 'Petko Manolov',
 'pmarques:grupopie.com' => 'Paulo Marques',
 'pmeda:akamai.com' => 'Prasanna Meda',
@@ -1549,6 +1583,7 @@
 'proski:org.rmk' => 'Pavel Roskin',
 'proski:org.rmk.(none)' => 'Pavel Roskin',
 'psimmons:flash.net' => 'Patrick Simmons',
+'ptiedem:de.ibm.com' => 'Peter Tiedemann',
 'purna:jcom.home.ne.jp' => 'Yusuf Wilajati Purna',
 'pwaechtler:mac.com' => 'Peter Wächtler',
 'q:kampsax.dtu.dk' => 'Dennis Jørgensen',
@@ -1703,6 +1738,7 @@
 'seanlkml:rogers.com' => 'Sean Estabrooks',
 'sebastian.droege:gmx.de' => 'Sebastian Dröge',
 'sebek64:post.cz' => 'Marcel Sebek',
+'sergio.gelato:astro.su.se' => 'Sergio Gelato',
 'set:pobox.com' => 'Paul Thompson',
 'seto.hidetoshi:jp.fujitsu.com' => 'Hidetoshi Seto',
 'sezero:superonline.com' => 'Özkan Sezer',
@@ -1849,6 +1885,7 @@
 'thunder:ngforever.de' => 'Thunder From The Hill',
 'tigran:aivazian.name' => 'Tigran Aivazian',
 'tigran:veritas.com' => 'Tigran Aivazian',
+'tim.chick:conexant.com' => 'Tim Chick',
 'tim:cambrant.com' => 'Tim Cambrant', # lbdb
 'tim:physik3.uni-rostock.de' => 'Tim Schmielau',
 'timw:splhi.com' => 'Tim Wright',
@@ -1860,7 +1897,8 @@
 'tmolina:cablespeed.com' => 'Thomas Molina',
 'tmolina:cox.net' => 'Thomas Molina',
 'tol:stacken.kth.se' => 'Tomas Olsson',
-'tom.l.nguyen:intel.com' => 'Nguyen, Tom L',
+'tom.l.nguyen:intel.com' => 'Tom L. Nguyen',
+'tomd:csds.uidaho.edu' => 'Thomas DuBuisson',
 'tomita:cinet.co.jp' => 'Osamu Tomita',
 'toml:us.ibm.com' => 'Tom Lendacky',
 'tomlins:cam.org' => 'Ed Tomlinson',
@@ -1907,8 +1945,10 @@
 'umka:namesys.com' => 'Yury Umanets',
 'urban.widmark:enlight.net' => 'Urban Widmark',
 'urban:teststation.com' => 'Urban Widmark',
+'utz.bacher:de.ibm.com' => 'Utz Bacher',
 'uwe.bugla:gmx.de' => 'Uwe Bugla',
 'uwe.koziolek:gmx.net' => 'Uwe Koziolek',
+'uweigand:de.ibm.com' => 'Ulrich Weigand',
 'uzi:uzix.org' => 'Joshua Uziel',
 'vadim:cs.washington.edu' => 'Vadim Lobanov',
 'valdis.kletnieks:vt.edu' => 'Valdis Kletnieks',
@@ -1957,6 +1997,7 @@
 'weicht:in.tum.de' => 'Thomas Weich',
 'weigand:immd1.informatik.uni-erlangen.de' => 'Ulrich Weigand',
 'weihs:linux1394.org' => 'Manfred Weihs',
+'wein:de.ibm.com' => 'Stefan Weinhuber',
 'wellnhofer:aevum.de' => 'Nick Wellnhofer',
 'wensong:linux-vs.org' => 'Wensong Zhang',
 'wes:infosink.com' => 'Wes Schreiner',
@@ -2083,7 +2124,7 @@
 # * $author can be the email address or Joe N. Sixpack II <joe6@example.com>
 #   (ready formatted to print)
 # * $name is the name (Joe N. Sixpack II) or the mail address
-#   (<joe6@example.com>) 
+#   (<joe6@example.com>)
 
 sub get_name()   { return $name; }
 sub get_author() { return $author; }
@@ -2156,7 +2197,7 @@
   croak "do not call removedups() in scalar context" unless wantarray;
   my @u = grep (!$t{lc $_}++, @_);
   return map {
-    $t{lc $_} > 1 ? sprintf("%d x ", $t{lc $_}) . $_ : $_; 
+    $t{lc $_} > 1 ? sprintf("%d x ", $t{lc $_}) . $_ : $_;
   } @u;
 }
 
@@ -2274,7 +2315,7 @@
 		   compress(map { $_->[0]; } @{$log->{$_}})), "\n"
 		     or write_error();
       } else {
-	print join("\n", map { "$indent1$_ ($a)" } 
+	print join("\n", map { "$indent1$_ ($a)" }
 		   compress(map { $_->[0]; } @{$log->{$_}})), "\n"
 		     or write_error();
       }
@@ -2425,11 +2466,15 @@
     }
 
     if ($havename) {
-	if ($$name =~ /([^,]+),\s*([^(\s]*)\s*(\(.*\))?/) {
+	# Last, First (optional comment)
+	# -> First Last (optional comment)
+	if ($$name =~ /^([^,]+),\s*([^(\s]*)\s*(\(.*\))?/) {
 	    $$name = "$2 $1";
 	    if (defined $3) { $$name .= " " . $3; }
 	}
-	if ($$name =~ /([A-Z]+)\s+([^(\s]*)\s*(\(.*\))?/) {
+	# LAST First (optional comment)
+	# -> First Last (optional comment)
+	if ($$name =~ /^([A-Z]+)\s+([^(\s]*)\s*(\(.*\))?/) {
 	    my ($u, $f) = ($2, $1);
 	    my ($ul) = lc $2;
 	    $ul =~ s/^.//;
@@ -2454,6 +2499,28 @@
     return $author;
 }
 
+# Treat address
+# INPUT: Tuple of Name, Address scalars
+# OUTPUT: Tuple of Name, Address, Author scalars in an array
+sub treat_address($$) {
+    my $n = shift;
+    my $a = lc shift;
+    my $au;
+    my $tmp;
+
+    if (($tmp = rmap_address($a, 0)) eq $a) {
+	if ($n =~ /\s+/) {
+	    # not found, but only add if two words or more in name.
+	    $address_found_in_from{$a} = sprintf "'%s' => '%s',",
+	    obfuscate $a, $n; # FIXME: has this any effect?
+	}
+    } else {
+	$n = $tmp;
+    }
+    $au = treat_addr_name($a, $n);
+    return ($n, $a, $au);
+}
+
 # Read a file and parse it into the %log hash.
 sub parse_file(\%$$ ) {
 # arguments: %log hash
@@ -2470,8 +2537,18 @@
   my @cur = ();
   my $first = 0;
   my $firstpar = 0;
+  my $namepref = 0; # where address is from
+  # 0 - BK; 1 - Signed-off-by; 2 - From
   undef $address;
 
+  ###############################################################
+  # Linus' intended logic is:
+  # - preference is given to From: (namepref 2)
+  # - lacking From:, use the first Signed-off-by: we encounter
+  #   (namepref 1)
+  # - lacking that information, use BK user info (namepref 0)
+  ###############################################################
+
   # now go!
 
   # NOTE: the first @cur item can consist of multiple lines in the
@@ -2507,41 +2584,30 @@
       $address =~ s/\[[^]]+\]$//;
       $name = rmap_address($address, 1);
       $author = treat_addr_name($address, $name);
-      print STDERR "AUTHOR $author\n" if $debug;
       $first = 1;
       $firstpar = 1;
+      print STDERR " BK-CHANGESET $author\n" if $debug;
+      $namepref = 0;
     } elsif (/^\s+From:?\s*"?([^"]*)"?\s+\<(.*)\>\s*$/) {
-      my $tmp;
-      $name = $1;
-      $address = lc $2;
-      if (($tmp = rmap_address($address, 0)) eq $address) {
-	if ($name =~ /\s+/) {
-	  # not found, but only add if two words or more in name.
-	  $address_found_in_from{$address} = sprintf "'%s' => '%s',",
-	  obfuscate $address, $name;
-	}
+      my @nameauthor = treat_address($1, $2);
+      if ($namepref < 2) {
+	  ($name, $address, $author) = @nameauthor;
+	  $namepref = 2;
+	  print STDERR " FROM  $author\n" if $debug;
       } else {
-	$name = $tmp;
+	  print STDERR " SKIPPED FROM  $author\n" if $debug;
       }
-      $author = treat_addr_name($address, $name);
-      print STDERR " FROM  $author\n" if $debug;
     } elsif (/^\s+Signed-off-by:\s*"?([^"]*)"?\s+\<(.*)\>\s*$/i) {
-      my $tmp;
-      $name = $1;
-      $address = lc $2;
-      if (($tmp = rmap_address($address, 0)) eq $address) {
-	if ($name =~ /\s+/) {
-	  # not found, but only add if two words or more in name.
-	  $address_found_in_from{$address} = sprintf "'%s' => '%s',",
-	  obfuscate $address, $name;
-	}
+      my @nameauthor = treat_address($1, $2);
+      if ($namepref < 1) {
+	  ($name, $address, $author) = @nameauthor;
+	  $namepref = 1;
+	  print STDERR " SIGNED-OFF-BY  $author\n" if $debug;
       } else {
-	$name = $tmp;
+	  print STDERR " SKIPPED SIGNED-OFF-BY  $author\n" if $debug;
       }
-      $author = treat_addr_name($address, $name);
-      print STDERR " SIGNED-OFF-BY  $author\n" if $debug;
     } elsif ($first) {
-      # we have a "first" line after an address, take it, 
+      # we have a "first" line after an address, take it,
       # strip common redundant tags
 
       # kill "PATCH" tag
@@ -2575,7 +2641,7 @@
       # store header before a changelog
       push @prolog, $_;
     }
-  }
+  } # while more lines in file
 
   if ($fh -> error) {
     die "Error while reading from \"$fn\": $!";
@@ -2838,6 +2904,18 @@
 
 Summarizes or reformats BitKeeper ChangeLogs for Linux Kernel 2.X.
 
+Addresses of patch authors are determined with the following precedence:
+
+=over
+
+=item 1. From: line
+
+=item 2. Signed-off-by
+
+=item 3. BK user/host
+
+=back
+
 --mode options are:
 
 =over
@@ -2877,6 +2955,11 @@
 --swap here and --noswap on your command line, --noswap takes
 precedence.
 
+=item LINUXKERNEL_BK_FMT_DEBUG
+
+If this evaluates to "true" when used as Perl expression, i. e. it is a
+nonempty string or a number other than 0, enable debugging.
+
 =back
 
 

