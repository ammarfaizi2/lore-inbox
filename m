Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266682AbUAXAX0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 19:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266806AbUAXAX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 19:23:26 -0500
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:31692 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S266682AbUAXAWm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 19:22:42 -0500
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: lk-changelog.pl 0.221
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Sat_Jan_24_00_22_35_UTC_2004_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20040124002236.D4B27A1C02@merlin.emma.line.org>
Date: Sat, 24 Jan 2004 01:22:36 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a semi-automatic announcement.

lk-changelog.pl aka. shortlog version 0.221 has been released.

This script is used by Linus and Marcelo to rearrange and reformat BK
ChangeSet logs into a more human-readable format, and the official
repository is Parent repository is http://bktools.bkbits.net/bktools

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
revision 0.221
date: 2004/01/23 10:24:51;  author: vita;  state: Exp;  lines: +5 -1
4 new addresses
----------------------------
revision 0.220
date: 2004/01/21 12:56:00;  author: emma;  state: Exp;  lines: +2 -1
BK -> CVS: merge Raj's address obelix123 at toughguy.net
CVS -> BK: three new addresses (vita)
----------------------------
revision 0.219
date: 2004/01/21 12:46:26;  author: vita;  state: Exp;  lines: +15 -1
merge Linus' additions
3 new addresses
----------------------------
revision 0.218
date: 2004/01/20 15:19:16;  author: vita;  state: Exp;  lines: +8 -1
7 new addresses
----------------------------
revision 0.217
date: 2004/01/19 12:15:23;  author: vita;  state: Exp;  lines: +9 -5
3 new addresses; move Chas Williams' addresses into @addrregexps
----------------------------
revision 0.216
date: 2004/01/16 14:37:56;  author: emma;  state: Exp;  lines: +2 -1
One new address.
----------------------------
revision 0.215
date: 2004/01/12 12:24:48;  author: vita;  state: Exp;  lines: +4 -1
3 new addresses
----------------------------
revision 0.214
date: 2004/01/07 11:32:57;  author: emma;  state: Exp;  lines: +1 -714
Kill $History$ from this file.
----------------------------
revision 0.213
date: 2004/01/07 09:45:46;  author: vita;  state: Exp;  lines: +9 -6
resort address->name hash with LC_ALL=POSIX sort -u
=============================================================================
Index: lk-changelog.pl
===================================================================
RCS file: /var/CVS/lk-changelog/lk-changelog.pl,v
retrieving revision 0.213
diff -u -r0.213 lk-changelog.pl
--- lk-changelog.pl	7 Jan 2004 09:45:46 -0000	0.213
+++ lk-changelog.pl	24 Jan 2004 00:15:04 -0000
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.213 2004/01/07 09:45:46 vita Exp $
+# $Id: lk-changelog.pl,v 0.221 2004/01/23 10:24:51 vita Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -72,6 +72,7 @@
 my @addrregexps = (
 [ 'alan@[^.]+\.swansea\.linux\.org\.uk' => 'Alan Cox', ],
 [ 'bos@([^.]+\.)?serpentine\.com' => 'Bryan O\'Sullivan', ],
+[ 'chas@([^.]+\.)*nrl\.navy\.mil' => 'Chas Williams', ],
 [ 'davem@[^.]+\.ninka\.net' => 'David S. Miller', ],
 [ 'kuznet@[^.]+\.inr\.ac\.ru' => 'Alexey Kuznetsov', ],
 [ 'torvalds@([^.]+\.)?transmeta\.com' => 'Linus Torvalds', ],
@@ -100,6 +101,11 @@
 'alan:irongate.swansea.linux.org.uk' => 'Alan Cox',
 'bos:camp4.serpentine.com' => 'Bryan O\'Sullivan',
 'bos:serpentine.com' => 'Bryan O\'Sullivan',
+'chas:cmd.nrl.navy.mil' => 'Chas Williams',
+'chas:cmf.nrl.navy.mil' => 'Chas Williams',
+'chas:locutus.cmf.nrl.navy.mil' => 'Chas Williams',
+'chas:nrl.navy.mil' => 'Chas Williams',
+'chas:relax.cmf.nrl.navy.mil' => 'Chas Williams',
 'davem:cheetah.ninka.net' => 'David S. Miller',
 'davem:nuts.ninka.net' => 'David S. Miller',
 'davem:pizda.ninka.net' => 'David S. Miller', # guessed
@@ -148,6 +154,7 @@
 'adam:yggdrasil.com' => 'Adam J. Richter',
 'adaplas:pol.net' => 'Antonino Daplas',
 'aderesch:fs.tum.de' => 'Andreas Deresch',
+'adi:drcomp.erfurt.thur.de' => 'Adrian Knoth',
 'adilger:clusterfs.com' => 'Andreas Dilger',
 'adobriyan:mail.ru' => 'Alexey Dobriyan',
 'adsharma:unix-os.sc.intel.com' => 'Arun Sharma',
@@ -201,6 +208,7 @@
 'ambx1:com.rmk.(none)' => 'Adam Belay',
 'ambx1:neo.rr.com' => 'Adam Belay',
 'amir.noam:intel.com' => 'Amir Noam',
+'amitg:edu.rmk.(none)' => 'Amit Gurdasani',
 'amn3s1a:ono.com' => 'Miguel A. Fosas',
 'amunoz:vmware.com' => 'Alberto Munoz',
 'andersen:codepoet.org' => 'Erik Andersen',
@@ -209,6 +217,7 @@
 'andre.breiler:null-mx.org' => 'André Breiler',
 'andrea:suse.de' => 'Andrea Arcangeli',
 'andrew.grover:intel.com' => 'Andy Grover', # "Andy" to match former entries
+'andrew.vasquez:qlogic.com' => 'Andrew Vasquez',
 'andrew.wood:ivarch.com' => 'Andrew Wood',
 'andrew:com.rmk.(none)' => 'Andrew Victor', # double-check
 'andries.brouwer:cwi.nl' => 'Andries E. Brouwer',
@@ -218,6 +227,7 @@
 'anton:samba.org' => 'Anton Blanchard',
 'anton:superego.(none)' => 'Anton Blanchard',
 'anton:superego.ozlabs.ibm.com' => 'Anton Blanchard',
+'ap:cipherica.com' => 'Alex Pankratov',
 'apolkosnik:directvinternet.com' => 'Adam Polkosnik',
 'arashi:yomerashi.yi.org' => 'Matt Reppert',
 'arekm:pld-linux.org' => 'Arkadiusz Miskiewicz', # lbdb
@@ -231,6 +241,7 @@
 'arnd:bergmann-dalldorf.de' => 'Arnd Bergmann',
 'arndb:de.ibm.com' => 'Arnd Bergmann',
 'arndt:lin02384n012.mc.schoenewald.de' => 'Arndt Schoenewald',
+'arubin:atl.lmco.com' => 'Aron Rubin',
 'arun.sharma:intel.com' => 'Arun Sharma',
 'arvidjaar:mail.ru' => 'Andrey Borzenkov',
 'arzie:dds.nl' => 'Robert Zwerus',
@@ -241,6 +252,7 @@
 'atul.mukker:lsil.com' => 'Atul Mukker',
 'atulm:lsil.com' => 'Atul Mukker',
 'aviro:parcelfarce.linux.theplanet.co.uk' => 'Alexander Viro',
+'awagger:web.de' => 'Axel Waggershauser',
 'axboe:burns.home.kernel.dk' => 'Jens Axboe', # guessed
 'axboe:hera.kernel.org' => 'Jens Axboe',
 'axboe:suse.de' => 'Jens Axboe',
@@ -332,10 +344,6 @@
 'chan:aleph1.co.uk' => 'Tak-Shing Chan',
 'char:cmf.nrl.navy.mil' => 'Chas Williams', # typo ???
 'charles.white:hp.com' => 'Charles White',
-'chas:cmd.nrl.navy.mil' => 'Chas Williams',
-'chas:cmf.nrl.navy.mil' => 'Chas Williams',
-'chas:locutus.cmf.nrl.navy.mil' => 'Chas Williams',
-'chas:nrl.navy.mil' => 'Chas Williams',
 'chessman:tux.org' => 'Samuel S. Chessman',
 'chip:pobox.com' => 'Chip Salzenberg', # lbdb
 'chris:qwirx.com' => 'Chris Wilson',
@@ -411,6 +419,7 @@
 'davem:hera.kernel.org' => 'David S. Miller',
 'davem:kernel.bkbits.net' => 'David S. Miller',
 'davem:redhat.com' => 'David S. Miller',
+'david-b:net.rmk.(none)' => 'David Brownell',
 'david-b:pacbell.com' => 'David Brownell',
 'david-b:pacbell.net' => 'David Brownell',
 'david-b:packbell.net' => 'David Brownell',
@@ -460,8 +469,10 @@
 'dlstevens:us.ibm.com' => 'David Stevens',
 'dmccr:us.ibm.com' => 'Dave McCracken',
 'dmo:osdl.org' => 'Dave Olien',
+'doj:cubic.org' => 'Dirk Jagdmann',
 'dok:directfb.org' => 'Denis Oliver Kropp',
 'dougg:torque.net' => 'Douglas Gilbert',
+'drb:med.co.nz' => 'Ross Boswell',
 'drepper:redhat.com' => 'Ulrich Drepper',
 'driver:huey.jpl.nasa.gov' => 'Bryan B. Whitehead', # google
 'drow:false.org' => 'Daniel Jacobowitz',
@@ -481,6 +492,7 @@
 'ebiederm:xmission.com' => 'Eric W. Biederman',
 'ebrower:resilience.com' => 'Eric Brower',
 'ebrower:usa.net' => 'Eric Brower',
+'ebs:ebshome.net' => 'Eugene Surovegin',
 'ecd:skynet.be' => 'Eddie C. Dost',
 'eddie.williams:steeleye.com' => 'Eddie Williams',
 'edv:macrolink.com' => 'Ed Vance',
@@ -495,6 +507,8 @@
 'eli.carter:com.rmk.(none)' => 'Eli Carter',
 'eli.kupermann:intel.com' => 'Eli Kupermann',
 'emann:mrv.com' => 'Eran Mann',
+'emcnabb:cs.byu.edu' => 'Evan N. McNabb',
+'emoore:lsil.com' => 'Eric Dean Moore',
 'engebret:au1.ibm.com' => 'David Engebretsen',
 'engebret:brule.rchland.ibm.com' => 'David Engebretsen',
 'engebret:us.ibm.com' => 'David Engebretsen',
@@ -510,13 +524,16 @@
 'erlend-a:us.his.no' => 'Erlend Aasland',
 'erlend-a:ux.his.no' => 'Erlend Aasland',
 'ernstp:mac.com' => 'Ernst Persson', # lbdb
+'eugeneteo:eugeneteo.net' => 'Eugene Teo',
 'eyal:eyal.emu.id.au' => 'Eyal Lebedinsky', # lbdb
 'faikuygur:ttnet.net.tr' => 'Faik Uygur',
 'falk.hueffner:student.uni-tuebingen.de' => 'Falk Hüffner',
+'fb.arm:net.rmk.(none)' => 'Frank Becker',
 'fbecker:com.rmk.(none)' => 'Frank Becker',
 'fbl:conectiva.com.br' => 'Flávio Bruno Leitner', # google
 'fcusack:fcusack.com' => 'Frank Cusack',
 'fdavis:si.rr.com' => 'Frank Davis',
+'felipe_alfaro:linuxmail.org' => 'Felipe Alfaro Solana',
 'felipewd:terra.com.br' => 'Felipe Damasio', # by self (did not ask to include the W.)
 'fello:libero.it' => 'Fabrizio Fellini',
 'fenghua.yu:intel.com' => 'Fenghua Yu', # google
@@ -563,6 +580,7 @@
 'gkernel.adm:hostme.bitkeeper.com' => 'Jeff Garzik', # himself
 'gl:dsa-ac.de' => 'Guennadi Liakhovetski',
 'glee:gnupilgrims.org' => 'Geoffrey Lee', # lbdb
+'glenn:aoi-industries.com' => 'Glenn Burkhardt',
 'gnb:alphalink.com.au' => 'Greg Banks',
 'go:turbolinux.co.jp' => 'Go Taniguchi',
 'gone:us.ibm.com' => 'Patricia Gaughen',
@@ -703,6 +721,7 @@
 'jenna.s.hall:intel.com' => 'Jenna S. Hall', # google
 'jes:trained-monkey.org' => 'Jes Sorensen',
 'jes:wildopensource.com' => 'Jes Sorensen',
+'jet:gyve.org' => 'Masatake Yamato',
 'jfbeam:bluetronic.net' => 'Ricky Beam',
 'jgarzik:fokker2.devel.redhat.com' => 'Jeff Garzik',
 'jgarzik:hum.(none)' => 'Jeff Garzik',
@@ -918,6 +937,7 @@
 'marcelo:freak.distro.conectiva' => 'Marcelo Tosatti', # guessed
 'marcelo:logos.cnet' => 'Marcelo Tosatti', # guessed
 'marcelo:plucky.distro.conectiva' => 'Marcelo Tosatti',
+'marchand:kde.org' => 'Mickael Marchand',
 'marcus:ingate.com' => 'Marcus Sundberg',
 'marekm:amelek.gda.pl' => 'Marek Michalkiewicz',
 'margitsw:t-online.de' => 'Margit Schubert-While',
@@ -1011,6 +1031,7 @@
 'mochel:segfault.osdlab.org' => 'Patrick Mochel',
 'moilanen:austin.ibm.com' => 'Jake Moilanen',
 'moilanen:us.ibm.com' => 'Jake Moilanen',
+'mort:bork.org' => 'Martin Hicks',
 'mort:green.i.bork.org' => 'Martin Hicks',
 'mort:wildopensource.com' => 'Martin Hicks',
 'mostrows:speakeasy.net' => 'Michal Ostrowski',
@@ -1047,6 +1068,7 @@
 'nicolas:dupeux.net' => 'Nicolas Dupeux',
 'nikai:nikai.net' => 'Nicolas Kaiser',
 'nikkne:hotpop.com' => 'Nikola Knezevic',
+'nitin.a.kamble:intel.com' => 'Nitin A. Kamble',
 'niv:us.ibm.com' => 'Nivedita Singhvi',
 'nivedita:w-nivedita.beaverton.ibm.com' => 'Nivedita Singhvi',
 'nkbj:image.dk' => 'Niels Kristian Bech Jensen',
@@ -1055,9 +1077,11 @@
 'nmiell:attbi.com' => 'Nicholas Miell',
 'noah:caltech.edu' => 'Noah J. Misch',
 'nobita:t-online.de' => 'Andreas Busch',
+'normalperson:yhbt.net' => 'Eric Wong',
 'nstraz:sgi.com' => 'Nathan Straz',
 'ntfs:flatcap.org' => 'Richard Russon', # lbdb
 'nuno:itsari.org' => 'Nuno Monteiro',
+'obelix123:toughguy.net' => 'Raj',		# Hmm..
 'okir:suse.de' => 'Olaf Kirch', # lbdb
 'okurth:gmx.net' => 'Oliver Kurth',
 'olaf.dietsche#list.linux-kernel:t-online.de' => 'Olaf Dietsche',
@@ -1085,6 +1109,7 @@
 'paschal:rcsis.com' => 'David Paschal',
 'pasky:ucw.cz' => 'Petr Baudis',
 'patch:luckynet.dynu.com' => '"Lightweight Patch Manager"', # lbdb
+'patmans:ibm.com' => 'Patrick Mansfield',
 'patmans:us.ibm.com' => 'Patrick Mansfield',
 'patrick:dreker.de' => 'Patrick Dreker', # lbdb
 'paubert:iram.es' => 'Gabriel Paubert',
@@ -1108,6 +1133,7 @@
 'pbadari:us.ibm.com' => 'Badari Pulavarty',
 'pdelaney:lsil.com' => 'Pam Delaney',
 'pe1rxq:amsat.org' => 'Jeroen Vreeken',
+'pebl:math.ku.dk' => 'Peter Berg Larsen',
 'pee:erkkila.org' => 'Paul E. Erkkila',
 'pekon:informatics.muni.cz' => 'Petr Konecny',
 'per.winkvist:telia.com' => 'Per Winkvist',
@@ -1148,6 +1174,7 @@
 'plars:linuxtestproject.org' => 'Paul Larson',
 'plcl:telefonica.net' => 'Pedro Lopez-Cabanillas',
 'pmanolov:lnxw.com' => 'Petko Manolov',
+'pmarques:grupopie.com' => 'Paulo Marques',
 'pmeda:akamai.com' => 'Prasanna Meda',
 'pmenage:ensim.com' => 'Paul Menage',
 'porter:cox.net' => 'Matt Porter',
@@ -1187,6 +1214,7 @@
 'reeja.john:amd.com' => 'Reeja John',
 'reiser:namesys.com' => 'Hans Reiser',
 'rem:osdl.org' => 'Bob Miller',
+'rene.herman:nl.rmk.(none)' => 'Rene Herman',
 'rgcrettol:datacomm.ch' => 'Roger Crettol',
 'rgooch:atnf.csiro.au' => 'Richard Gooch',
 'rgooch:ras.ucalgary.ca' => 'Richard Gooch',
@@ -1206,12 +1234,14 @@
 'rmk:arm.linux.org.uk' => 'Russell King',
 'rmk:flint.arm.linux.org.uk' => 'Russell King',
 'rml:tech9.net' => 'Robert Love',
+'rnp:paradise.net.nz' => 'Richard Procter',
 'rob:landley.net' => 'Rob Landley',
 'rob:osinvestor.com' => 'Rob Radez',
 'robert.olsson:data.slu.se' => 'Robert Olsson',
 'robin.farine:ch.rmk.(none)' => 'Robin Farine',
 'robn:verdi.et.tudelft.nl' => 'Rob van Nieuwkerk',
 'roehrich:sgi.com' => 'Dean Roehrich',
+'rohde:duff.dk' => 'Rasmus Rohde',
 'rohit.seth:intel.com' => 'Seth Rohit',
 'rol:as2917.net' => 'Paul Rolland',
 'roland:frob.com' => 'Roland McGrath',
@@ -1275,8 +1305,10 @@
 'sean.mcgoogan:superh.com' => 'Sean McGoogan',
 'seanlkml:rogers.com' => 'Sean Estabrooks',
 'sebastian.droege:gmx.de' => 'Sebastian Dröge',
+'sebek64:post.cz' => 'Marcel Sebek',
 'set:pobox.com' => 'Paul Thompson',
 'sfbest:us.ibm.com' => 'Steve Best',
+'sfr:au1.ibm.com' => 'Stephen Rothwell',
 'sfr:canb.auug.org.au' => 'Stephen Rothwell',
 'sfrost:snowman.net' => 'Stephen Frost',
 'shaggy:austin.ibm.com' => 'Dave Kleikamp',
@@ -1375,6 +1407,7 @@
 'thomas:bender.thinknerd.de' => 'Thomas Walpuski',
 'thomas:habets.pp.se' => 'Thomas Habets',
 'thomas:osterried.de' => 'Thomas Osterried',
+'thomas:stewarts.org.uk' => 'Thomas Stewart',
 'thomas:winischhofer.net' => 'Thomas Winischhofer', # whois
 'thomr9am:ss1000.ms.mff.cuni.cz' => 'Rudo Thomas',
 'thornber:sistina.com' => 'Joe Thornber',
@@ -1395,6 +1428,7 @@
 'tommy:home.tig-grr.com' => 'Tom Marshall',
 'tony.luck:intel.com' => 'Tony Luck',
 'tony:cantech.net.au' => 'Anthony J. Breeds-Taurima',
+'tony:com.rmk.(none)' => 'Tony Lindgren',
 'tonyb:cybernetics.com' => 'Tony Battersby',
 'torben.mathiasen:hp.com' => 'Torben Mathiasen',
 'torvalds:linux.local' => 'Linus Torvalds',
@@ -2197,722 +2231,6 @@
 }
 
 __END__
-# --------------------------------------------------------------------
-# $Log: lk-changelog.pl,v $
-# Revision 0.213  2004/01/07 09:45:46  vita
-# resort address->name hash with LC_ALL=POSIX sort -u
-#
-# Revision 0.212  2004/01/07 08:38:47  vita
-# 34 new addresses
-#
-# Revision 0.211  2004/01/05 01:07:20  emma
-# Pull in two addresses from Linus' tree.
-#
-# Revision 0.210  2003/12/30 02:11:39  emma
-# 4 new addresses.
-#
-# Revision 0.209  2003/12/30 02:07:39  emma
-# Bugfix, --noobfuscate wasn't complete.
-#
-# Revision 0.208  2003/12/22 01:17:09  emma
-# Only print ignoremerge warning if ignoremerge is really enabled.
-#
-# Revision 0.207  2003/12/21 03:10:50  emma
-# Mark --ignoremerge deprecated, point towards bk changes -d'$unless(:MERGE:)' instead.
-#
-# Revision 0.206  2003/12/20 23:32:45  emma
-# Resolve conflict with Linus' version.
-#
-# Revision 0.205  2003/12/11 14:08:38  vita
-# new translations to cover 2.4.24-pre1
-#
-# Revision 0.204  2003/12/07 18:30:25  emma
-# Fix Kai Mäkisara's name. Patch by Marcus Alanen.
-#
-# Revision 0.203  2003/12/06 16:40:13  emma
-# Add two addresses, three still nknown since 2.4.23.
-#
-# Revision 0.202  2003/12/06 16:34:30  emma
-# Support bk changes {-L|-R} output format (with +17 -0 after address).
-#
-# Revision 0.201  2003/11/27 10:59:51  vita
-# 3 new addresses (1 new and 2 old from `bk changes` since 2.5.0)
-#
-# Revision 0.200  2003/11/25 10:45:02  emma
-# Merge Linus' additions.
-#
-# Revision 0.199  2003/11/25 03:20:04  emma
-# New address for Arkadiusz Miskiewicz.
-#
-# Revision 0.198  2003/11/22 14:59:50  emma
-# Add Andreas Beckmann's address.
-#
-# Revision 0.197  2003/11/21 21:13:59  emma
-# Re-add Steffen Klassert's typoed address, bug report by Vita.
-#
-# Revision 0.196  2003/11/20 23:30:18  emma
-# Fix Steffen Klassert's address.
-#
-# Revision 0.195  2003/11/19 16:08:02  emma
-# Add 2nd address of Atul Mukker of LSI Logic.
-#
-# Revision 0.194  2003/11/11 09:21:00  vita
-# 10 new addresses
-#
-# Revision 0.193  2003/10/27 12:04:27  emma
-# Merge upstream changes.
-#
-# Revision 0.192  2003/10/24 08:13:10  vita
-# 5 new addresses
-#
-# Revision 0.191  2003/10/21 12:20:32  vita
-# 2 new addresses
-#
-# Revision 0.190  2003/10/16 12:33:28  vita
-# 3 new addresses
-#
-# Revision 0.189  2003/10/13 09:14:23  vita
-# 6 new addresses
-#
-# Revision 0.188  2003/10/10 08:49:34  vita
-# 2 new addresses
-#
-# Revision 0.187  2003/10/08 21:56:22  emma
-# Merge Linus' changes.
-#
-# Revision 0.186  2003/10/08 11:11:02  vita
-# 9 new addresses
-#
-# Revision 0.185  2003/10/02 12:22:33  vita
-# 7 new addresses
-#
-# Revision 0.184  2003/09/30 10:10:31  vita
-# 4 new addresses
-#
-# Revision 0.183  2003/09/29 12:26:43  vita
-# Merge Linus' changes
-#
-# Revision 0.182  2003/09/24 11:08:03  vita
-# 1 new address
-#
-# Revision 0.181  2003/09/23 13:09:36  vita
-# 2 new addresses
-#
-# Revision 0.180  2003/09/22 14:13:31  vita
-# 8 new addresses
-#
-# Revision 0.179  2003/09/19 09:40:52  vita
-# 6 new addresses
-#
-# Revision 0.178  2003/09/18 10:55:48  vita
-# 4 new addresses
-#
-# Revision 0.177  2003/09/15 13:04:41  vita
-# 8 new addresses
-#
-# Revision 0.176  2003/09/11 09:11:48  vita
-# 4 new addresses
-#
-# Revision 0.175  2003/09/08 05:31:21  vita
-# 4 new addresses
-#
-# Revision 0.174  2003/09/05 05:30:36  vita
-# 6 new addresses (from `bk changes` since 2.5.0)
-#
-# Revision 0.173  2003/09/05 02:10:40  emma
-# 13 new addresses, courtesy of Alan Cox
-#
-# Revision 0.172  2003/09/04 21:08:20  emma
-# 2 new addresses
-#
-# Revision 0.171  2003/09/04 20:55:38  emma
-# 11 new addresses.
-# add --mode=resolve
-#
-# Revision 0.170  2003/09/03 04:31:37  vita
-# 4 new addresses
-#
-# Revision 0.169  2003/09/02 05:28:25  vita
-# 3 new addresses
-#
-# Revision 0.168  2003/09/01 09:35:59  vita
-# 7 new addresses
-#
-# Revision 0.167  2003/08/31 14:08:56  emma
-# ADD: --selftest now checks for non-obfuscated addresses
-# FIX: 1 address (wasn't obfuscated)
-# REMOVE: 1 address (didn't contain domain part)
-#
-# Revision 0.166  2003/08/31 14:05:04  emma
-# SECURITY: fix obfuscation of unknown addresses in terse/oneline modes
-# ADD: Add 9 new addresses.
-# ADD: Implement --mode=fixup to postprocess this script's output,
-#      replacing addresses by names (useful after updates of this script)
-# DOC: add empty line before =head1 NAME to fix pod2html output.
-# DOC: document --mode options in man page.
-#
-# Revision 0.165  2003/08/29 11:56:43  vita
-# 1 new address
-#
-# Revision 0.164  2003/08/27 13:34:29  vita
-# 1 new address
-#
-# Revision 0.163  2003/08/26 10:09:13  vita
-# 4 new addresses; fix Bryan O'Sullivan's regexp
-#
-# Revision 0.162  2003/08/26 00:01:23  emma
-# Fix typo in @addresses_handled_in_regexp, Bryan O'Sullivan's address got hosed.
-#
-# Revision 0.161  2003/08/25 23:56:43  emma
-# Bryan O'Sullivan sent a notice about the other addresses he might be using.
-#
-# Revision 0.160  2003/08/24 10:47:13  emma
-# Merge one mapping from Linus.
-#
-# Revision 0.159  2003/08/22 08:11:41  vita
-# 8 new addresses
-#
-# Revision 0.158  2003/08/19 12:51:54  vita
-# 8 new addresses
-#
-# Revision 0.157  2003/08/18 13:23:53  vita
-# 7 new addresses
-#
-# Revision 0.156  2003/08/18 11:25:11  vita
-# Merge Linus' additions
-#
-# Revision 0.155  2003/08/09 22:30:17  emma
-# Merge Linus' changes.
-#
-# Revision 0.154  2003/08/09 22:29:38  emma
-# Bugfix: treat change sets that contain only blank lines.
-# Print each input line in $debug mode.
-# 16 new address mappings.
-#
-# Revision 0.153  2003/07/30 08:12:10  vita
-# 3 new addresses
-#
-# Revision 0.152  2003/07/28 06:47:23  vita
-# added 9 names for new addresses
-#
-# Revision 0.151  2003/07/25 12:39:21  vita
-# add 1 address
-#
-# Revision 0.150  2003/07/21 09:07:06  vita
-# resort address->name hash with LC_ALL=POSIX sort -u
-#
-# Revision 0.149  2003/07/21 09:03:12  vita
-# added 10 names for new addresses
-# put davem's addresses into @addrregexps
-# precise kuznet's regexp
-#
-# Revision 0.148  2003/07/15 12:59:09  vita
-# added 4 names for new addresses
-#
-# Revision 0.147  2003/07/14 15:31:34  vita
-# added 2 names for new addresses
-#
-# Revision 0.146  2003/07/13 09:25:39  emma
-# add 1 address
-#
-# Revision 0.145  2003/07/11 08:37:05  vita
-# add 4 names for new addresses; resort address->name hash
-#
-# Revision 0.144  2003/07/10 12:27:51  vita
-# 2 new addresses
-#
-# Revision 0.143  2003/07/08 10:05:55  vita
-# 2 new addresses
-#
-# Revision 0.142  2003/07/03 12:29:27  vita
-# 3 new addresses
-#
-# Revision 0.141  2003/07/01 09:11:52  vita
-# 2 new addresses
-#
-# Revision 0.140  2003/06/30 08:22:08  vita
-# 3 new addresses
-#
-# Revision 0.139  2003/06/27 08:22:15  vita
-# 10 new addresses
-#
-# Revision 0.138  2003/06/25 08:55:55  vita
-# 2 new addresses
-#
-# Revision 0.137  2003/06/24 08:59:08  vita
-# 3 new addresses
-#
-# Revision 0.136  2003/06/23 09:13:06  vita
-# merge Linus' additions
-#
-# Revision 0.135  2003/06/21 00:56:01  emma
-# 3 new addresses.
-#
-# Revision 0.134  2003/06/20 09:15:01  vita
-# add 5 names for new addresses
-#
-# Revision 0.133  2003/06/18 05:59:12  vita
-# add 2 names for new addresses
-#
-# Revision 0.132  2003/06/17 14:53:29  emma
-# Rearrange Peter Milne's addresses.
-#
-# Revision 0.131  2003/06/16 10:49:57  vita
-# add 5 names for new addresses
-#
-# Revision 0.130  2003/06/12 15:27:32  vita
-# add 5 names for new addresses
-#
-# Revision 0.129  2003/06/10 16:10:48  vita
-# add 3 names for new addresses
-#
-# Revision 0.128  2003/06/09 10:20:37  emma
-# Merge Linus' additions in. Resort address->name hash with LANG=C sort -u.
-#
-# Revision 0.127  2003/06/09 10:10:21  emma
-# Handle Alexey Kuznetsov's addresses by regexp.
-#
-# Revision 0.126  2003/06/09 09:56:40  vita
-# added 2 names for new addresses
-#
-# Revision 0.125  2003/06/06 12:13:57  vita
-# added 6 names for new addresses
-#
-# Revision 0.124  2003/06/04 10:31:18  vita
-# added 3 names for new addresses
-#
-# Revision 0.123  2003/06/03 05:49:53  vita
-# added 2 names for new addresses
-#
-# Revision 0.122  2003/06/02 09:11:21  emma
-# Fix umlaut in Moritz Mühlenhoff's name.
-#
-# Revision 0.121  2003/06/02 08:56:16  vita
-# added 5 names for new addresses
-#
-# Revision 0.120  2003/05/29 11:11:22  vita
-# added 2 names for new addresses
-#
-# Revision 0.119  2003/05/26 13:45:55  vita
-# added 2 names for new addresses
-#
-# Revision 0.118  2003/05/23 11:07:37  vita
-# added 5 names for new addresses
-#
-# Revision 0.117  2003/05/23 09:31:17  emma
-# Add Bernhard Kaindl's address.
-#
-# Revision 0.116  2003/05/15 08:52:06  vita
-# added 4 names for new addresses
-#
-# Revision 0.115  2003/05/12 10:16:48  vita
-# added 3 names for new addresses
-#
-# Revision 0.114  2003/05/08 10:35:41  vita
-# added 5 names for new addresses
-#
-# Revision 0.113  2003/05/07 09:30:03  vita
-# added 3 names for new addresses
-#
-# Revision 0.112  2003/05/06 15:46:15  vita
-# added 3 names for new addresses
-#
-# Revision 0.111  2003/05/05 08:55:16  vita
-# added 3 names for new addresses
-#
-# Revision 0.110  2003/05/02 14:53:22  vita
-# added 6 names for new addresses
-#
-# Revision 0.109  2003/04/29 10:20:09  vita
-# added 8 names for new addresses
-#
-# Revision 0.108  2003/04/28 23:26:08  emma
-# Add explanation why we define an array just to undefine it right away.
-#
-# Revision 0.107  2003/04/28 23:18:37  emma
-# Report status of selftest.
-#
-# Revision 0.106  2003/04/28 23:00:49  emma
-# Correct Vincent Legoll's name (was confused with somebody else).
-#
-# Revision 0.105  2003/04/28 12:20:56  vita
-# added 5 names for new addresses
-#
-# Revision 0.104  2003/04/27 13:18:46  emma
-# Add two more addresses.
-#
-# Revision 0.103  2003/04/24 09:20:31  vita
-# added 2 names for new addresses
-#
-# Revision 0.102  2003/04/23 12:39:05  vita
-# added 9 names for new addresses
-#
-# Revision 0.101  2003/04/18 11:43:22  vita
-# added 8 names for new addresses
-#
-# Revision 0.100  2003/04/17 10:25:19  vita
-# added 3 names for new addresses
-#
-# Revision 0.99  2003/04/16 08:17:49  vita
-# added 9 names for new addresses
-#
-# Revision 0.98  2003/04/14 15:47:56  emma
-# Doing Zack Brown a favor and archiving addresses that are now handled by regexps
-# in a separate list.
-#
-# Revision 0.97  2003/04/13 11:33:27  emma
-# Correct Patricia Gaughen's name (was Gua...). Found by Geoffrey Lee.
-#
-# Revision 0.96  2003/04/13 10:46:57  emma
-# 100 (one hundred) new addresses and 17 corrections by Zack Brown.
-#
-# Revision 0.95  2003/04/10 13:06:17  vita
-# added 6 names for new addresses
-#
-# Revision 0.94  2003/04/10 09:59:04  emma
-# Add Carl-Daniel's new 2003 address.
-#
-# Revision 0.93  2003/04/03 10:48:46  vita
-# added 9 names for new addresses
-#
-# Revision 0.92  2003/04/03 10:33:20  vita
-# move multiple linus' entries into regexp one
-#
-# Revision 0.91  2003/04/03 10:31:42  vita
-# change ignoremerge regexp to cover hostnames with ();
-# hide lonely standing "Merge" with --ignoremerge
-#
-# Revision 0.90  2003/03/31 11:24:32  emma
-# Obfuscate addresses, in script as well as in output. Output address
-# obfuscation can be switched off with --noobfuscate.
-# Suggested by Solar Designer.
-#
-# Omit addresses when a name is known. (Switch this off with
-# --noomitaddresses). This fixes the "distinct changelog per address
-# rather than per person" problem Sam Ravnborg reported.
-#
-# Revision 0.89  2003/03/28 10:55:39  emma
-# * Add one address.
-# * Strip $0 down to POSIX portable file name character set and untaint it
-#   to suppress warnings with Perl 5.8.0 and --man.
-# * Reset $ENV{PATH} to /bin:/usr/bin:/usr/local/bin for the same reason.
-# * In usage information, path-strip $0 in addition to that (and store in
-#   $myname).
-# * Add --ignoremerge switch to suppress the "Merge ... into ..." log
-#   entries.
-#
-# Revision 0.88  2003/03/26 21:12:23  emma
-# Add selftest mode check:
-# * check all addresses against all regexps to find addresses shadowing
-#   regular expressions.
-#
-# Revision 0.87  2003/03/26 21:02:53  emma
-# Fix broken regexp for Alan's swansea.linux.org.uk addresses. Add some comments.
-#
-# Revision 0.86  2003/03/26 20:57:49  emma
-# Support regexp queries (but try hash lookups first for efficiency).
-# Requested by Linus Torvalds.
-#
-# Revision 0.85  2003/03/26 08:22:11  vita
-# Added 6 names for new addresses.
-#
-# Revision 0.84  2003/03/24 08:45:20  vita
-# Added 12 names for new addresses from current 2.5 BK tree.
-#
-# Revision 0.83  2003/03/19 08:19:48  vita
-# Added 4 new names for addresses from current linux-2.5 BK tree.
-#
-# Revision 0.82  2003/03/17 08:26:30  vita
-# Added 2 new names.
-#
-# Revision 0.81  2003/03/10 15:38:27  vita
-# Added 4 new names for addresses from current linux-2.5 BK tree.
-#
-# Revision 0.80  2003/03/07 13:31:57  vita
-# Added 7 new names for addresses from current linux-2.5 BK tree.
-#
-# Revision 0.79  2003/03/04 16:59:15  vita
-# Added 5 new names for addresses from both current BK trees.
-#
-# Revision 0.78  2003/02/27 12:01:54  emma
-# Credit Vita in AUTHOR section of POD.
-#
-# Revision 0.77  2003/02/27 10:52:59  vita
-# Added 7 new names for addresses from both current BK trees.
-#
-# Revision 0.76  2003/02/24 20:04:23  vita
-# Added 7 new names for addresses from current linux-2.5 BK tree.
-#
-# Revision 0.75  2003/02/21 12:41:18  vita
-# Added 5 new names for addresses from current linux-2.4 BK tree.
-#
-# Revision 0.74  2003/02/19 11:15:14  vita
-# Added 7 new addresses found by Google.
-#
-# Revision 0.73  2003/02/14 10:45:45  vita
-# Added 5 new addresses found by Google.
-#
-# Revision 0.72  2003/02/06 16:10:23  vita
-# Added 6 new addresses found by Google.
-#
-# Revision 0.71  2003/02/05 11:22:06  emma
-# New addresses Vita pulled out.
-#
-# Revision 0.70  2003/02/03 14:58:04  emma
-# Vita dug out more addresses.
-#
-# Revision 0.69  2003/01/28 23:30:02  emma
-# Another four addresses by Vita.
-#
-# Revision 0.68  2003/01/20 10:22:08  emma
-# Add new address for Rolf Eike Beer.
-#
-# Revision 0.67  2003/01/19 14:32:55  emma
-# Further addresses figured out by Vita.
-#
-# Revision 0.66  2003/01/18 12:44:33  emma
-# New addresses found out by Vita.
-#
-# Revision 0.65  2003/01/13 14:12:09  emma
-# New addresses dug out by Vita.
-#
-# Revision 0.64  2003/01/08 14:48:50  emma
-# New addresses by Vita.
-#
-# Revision 0.63  2003/01/08 14:47:37  emma
-# New addresses by Vita.
-#
-# Revision 0.62  2002/12/27 16:59:28  emma
-# Another ten addresses sent by Vitezslav Samel.
-#
-# Revision 0.61  2002/12/14 14:28:49  emma
-# Bjorn Helgaas only uses the transscribed version of his name himself.
-#
-# Revision 0.60  2002/12/13 14:51:35  emma
-# Next dozen of addresses digged out by Vita.
-#
-# Revision 0.59  2002/12/11 12:11:51  emma
-# Workaround: strip trailing [tag] from mail addresses, reported by Marcel
-#     Holtmann.
-# Add some new addresses.
-#
-# Revision 0.58  2002/12/07 15:14:57  emma
-# More addresses figured by Vitezslav Samel.
-#
-# Revision 0.57  2002/12/07 15:08:34  emma
-# 3 more addresses.
-#
-# Revision 0.56  2002/11/28 02:32:11  emma
-# List David Weinehall.
-#
-# Revision 0.55  2002/11/27 04:44:54  emma
-# Add kaos@sgi.com for Keith Owens as per his own request.
-#
-# Revision 0.54  2002/11/26 23:27:11  emma
-# Merge changes from Linus' version.
-#
-# Revision 0.53  2002/11/25 17:12:08  emma
-# Add Lee Nash's address
-#
-# Revision 0.52  2002/11/14 14:50:21  emma
-# Bugfix --by-surname for some modes. Add two addresses. Fix Carl-Daniel Hailfinger's address to lower case.
-#
-# Revision 0.51  2002/11/14 14:31:10  emma
-# Add Carl-Daniel Hailfinger's new address. Add TODO item to see if regexp/wildcard match in address list is possible.
-#
-# Revision 0.50  2002/11/09 14:24:21  emma
-# Add comment to Richard Hitt's address.
-#
-# Revision 0.49  2002/11/04 17:13:21  emma
-# Add 4 addresses sent by Duncan Laurie.
-#
-# Revision 0.48  2002/11/04 12:37:38  emma
-# Another four dozen addresses, courtesy of Vitezslav Samel.
-#
-# Revision 0.47  2002/11/04 12:19:17  emma
-# Vitezslav Samel: Merge bugfix to treat addresses with upper-case characters in ChangeSet.
-#
-# Revision 0.46  2002/11/04 11:37:33  emma
-# 7 new addresses.
-#
-# Revision 0.45  2002/11/04 11:26:41  emma
-# 18 new addresses.
-#
-# Revision 0.44  2002/10/04 03:37:51  emma
-# Track BK-kernel-tools changes to Jes Sorensen's name.
-#
-# Revision 0.43  2002/10/04 03:33:47  emma
-# 4 new addresses.
-#
-# Revision 0.42  2002/10/01 20:20:33  emma
-# Another 25 addresses for ChangeLog 2.5.3?, from google and lbdb.
-#
-# Revision 0.41  2002/10/01 19:45:20  emma
-# Some detective work on google found another 19 addresses.
-#
-# Revision 0.40  2002/09/30 01:44:51  emma
-# Drop bogus geert@linux-m68k.org.com address.
-#
-# Revision 0.39  2002/09/26 23:07:13  emma
-# 46 new addresses from lbdb
-#
-# Revision 0.38  2002/09/26 22:37:29  emma
-# 23 new addresses
-#
-# Revision 0.37  2002/09/26 22:27:37  emma
-# Fix --multi mode.
-#
-# Revision 0.36  2002/08/29 09:13:40  emma
-# Correct Vojtech Pavlik's addresses after mail from him.
-#
-# Revision 0.35  2002/08/21 13:49:46  emma
-# Many new addresses and one correction by Vitezslav 'Vita' Samel <samel@mail.cz>
-#
-# Revision 0.34  2002/08/21 13:45:53  emma
-# 2 new names
-#
-# Revision 0.33  2002/08/20 01:29:34  emma
-# The usual set of new addresses.
-#
-# Revision 0.32  2002/08/20 01:14:40  emma
-# Add Marcel Holtmann, who sent a patch.
-#
-# Revision 0.31  2002/08/12 22:34:41  emma
-# Patch by Marcus Alanen <maalanen@ra.abo.fi>:
-# Hi, patch to sort by developer surname, and a couple of more
-# developers. Use if you want to.
-#
-# Revision 0.30  2002/07/20 17:18:28  emma
-# Add one new address
-#
-# Revision 0.29  2002/07/17 23:10:13  emma
-# 23 new addresses.
-#
-# Revision 0.28  2002/06/25 09:46:57  emma
-# New mail addresses.
-#
-# Revision 0.27  2002/06/14 17:05:23  emma
-# three new addresses
-#
-# Revision 0.26  2002/06/06 10:26:51  emma
-# Get rid of global %log, pass it to sub functions by reference.
-# Move IO::Handle/IO::File treatment back into main program.
-# Prepare for integrating Bitkeeper.
-#
-# Revision 0.25  2002/06/04 00:01:23  emma
-# Recognize "bk changes" output format (that is: "ChangeSet@1.234.5.6,
-# date, programmer" tag line and body indented by two spaces). Reported
-# by Marcelo Tosatti <marcelo@conectiva.com.br>. Former versions would
-# only recognize the BK-kernel-tools/changelog format (see
-# http://gkernel.bkbits.net:8080/BK-kernel-tools/anno/changelog@1.5?nav=index.html|src/).
-#
-# Revision 0.24  2002/06/03 13:33:00  emma
-# * Fix 'grouped', 'terse', 'oneline' modes (change to parse_file()). We
-#   now take the first paragraph instead of the first line as log
-#   entry. We also guess where the paragraph ends, it ends at a line with
-#   trailing dot or colon, or if the next line is empty or starts with a
-#   "bullet" (that is -, *, o or #).
-# * New option --abbreviate-names.
-# * Fix 'full' mode indentation, broken in v0.21 by expanding the tabs.
-#   Now, the first tab is unexpanded again.
-# * Enhance 'online' mode: if the log is truncated, append an ellipsis ("...").
-# * Add more mail addresses.
-# * Fix Brian Beattie's name (was "Michael Beattie").
-#
-# Revision 0.23  2002/06/03 12:36:01  emma
-# More e-mail addresses.
-#
-# Revision 0.22  2002/05/29 20:28:20  emma
-# Mail addresses added.
-#
-# Revision 0.21  2002/05/29 11:45:48  emma
-# * Implement --mode=oneline.
-# * Expand tabs in input lines (tab stops are spaced 8 columns away from each other).
-# * Bugfix --multi mode: all append_item to flush @cur before printing.
-# * Restore prolog detection in --multi mode for efficiency.
-# * Undo the "unexpand()" that Text::Wrap does, it breaks our line width
-#   calculation. In the long run, a replacement for Text::Wrap must be
-#   found that does not unexpand().
-#
-# Revision 0.20  2002/05/29 10:44:35  emma
-# New --multi option that states multiple changelogs are in the same file.
-#
-# Revision 0.19  2002/05/29 10:27:21  emma
-# New option: --[no]warn: Warn about unknown addresses. By default
-# enabled, use --nowarn to suppress.
-#
-# Revision 0.18  2002/05/29 10:17:00  emma
-# New addresses.
-#
-# Revision 0.17  2002/05/25 23:32:49  emma
-# Four new addresses.
-#
-# Revision 0.16  2002/05/22 15:52:26  emma
-# Fix deliberate typo in use Pod::Usage that was left over from debugging.
-#
-# Revision 0.15  2002/05/22 14:05:13  emma
-# Sort addresses/names case insensitively (not locale aware).
-# Heed quotes when parsing $ENV{LINUXKERNEL_BK_FMT}. As I don't
-# currently have Perl 5.004 to test the older Text::ParseWords
-# implementation, script now requires Perl 5.005.
-# Do not require Pod::Usage, but warn if it's missing.
-#
-# Revision 0.14  2002/05/22 12:39:59  emma
-# Fold the print function dispatcher into %table.
-# Parse files on command line individually, but allow to treat them as
-# one with a new --merge option.
-# Make @cur local to the parse function.
-# Die on read errors on input files. Use IO::Handle to read files.
-#
-# Revision 0.13  2002/05/21 12:42:46  emma
-# Add 3 mail addresses.
-# Add commentary to the code.
-# Check for write errors on STDOUT and die if one happens.
-#
-# Revision 0.12  2002/05/18 16:54:50  emma
-# Make --compress work in terse mode.
-# New feature: --swap in terse mode swaps address and log entry.
-#
-# Revision 0.11  2002/05/18 16:43:30  emma
-# Support 'terse' mode.
-#
-# Revision 0.10  2002/05/18 16:15:10  emma
-# Another set of addresses.
-#
-# Revision 0.9  2002/05/18 16:06:43  emma
-# Dozens of new addresses.
-#
-# Revision 0.8  2002/05/18 15:46:01  emma
-# 21 new addresses.
-#
-# Revision 0.7  2002/05/16 13:57:37  emma
-# Add some documentation.
-#
-# Revision 0.6  2002/05/16 13:55:24  emma
-# Fix shift ambiguity in printtag().
-#
-# Revision 0.5  2002/05/16 13:51:43  emma
-# Implement grouped and full modes.
-#
-# Revision 0.4  2002/05/16 12:07:17  emma
-# Add some POD.
-# Do options and environment parsing.
-# Prepare multiple output modes (only grouped supported at the moment.)
-#
-# Revision 0.3  2002/05/13 16:11:34  emma
-# Compress identical ChangeLog lines (they need not be subsequent, note
-# this feature has O(n^2) behaviour, where n is the number of stored
-# ChangeLog lines per respective author):
-#   Soft-fp fix:
-#   Soft-fp fix:
-# becomes:
-#   2 x Soft-fp fix:
-#
-# Revision 0.2  2002/05/13 10:40:32  emma
-# Only consider e-mail addresses that are left-justified.
-# Suggested by Greg Kroah-Hartman <greg@kroah.com>.
-#
-
 =head1 NAME
 
 lk-changelog.pl - Reformat BitKeeper ChangeLog for Linux Kernel

