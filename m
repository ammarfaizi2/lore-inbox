Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263389AbUC3BSp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 20:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263399AbUC3BSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 20:18:44 -0500
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:34752 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S263389AbUC3BS1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 20:18:27 -0500
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: lk-changelog.pl 0.255
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Tue_Mar_30_01_18_23_UTC_2004_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20040330011823.70A4DA3783@merlin.emma.line.org>
Date: Tue, 30 Mar 2004 03:18:23 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a semi-automatic announcement.

lk-changelog.pl aka. shortlog version 0.255 has been released.

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
revision 0.255
date: 2004/03/30 01:16:17;  author: emma;  state: Exp;  lines: +37 -21
Parse From: Firstname Lastname <email@address.invalid> to
credit (or blame) the right person.
Add Alain Knaff's address.
----------------------------
revision 0.254
date: 2004/03/27 13:47:02;  author: vita;  state: Exp;  lines: +4 -1
3 new addresses
----------------------------
revision 0.253
date: 2004/03/26 02:40:45;  author: emma;  state: Exp;  lines: +2 -1
Add address mapping for Mark Goodwin (SGI).
----------------------------
revision 0.252
date: 2004/03/23 09:55:23;  author: vita;  state: Exp;  lines: +6 -1
5 new addresses
----------------------------
revision 0.251
date: 2004/03/22 11:14:06;  author: emma;  state: Exp;  lines: +2 -2
Restore codmonkey.org.uk (with typo, missing "e") domain for Dave Jones
to the regular hash. Problem reported by Vitezslav Samel.
----------------------------
revision 0.250
date: 2004/03/20 12:10:33;  author: emma;  state: Exp;  lines: +5 -1
Four addresses for 2.4.
----------------------------
revision 0.249
date: 2004/03/20 12:00:52;  author: emma;  state: Exp;  lines: +10 -2
Some new addresses and one correction.
----------------------------
revision 0.248
date: 2004/03/19 00:17:54;  author: emma;  state: Exp;  lines: +2 -1
Another mapping.
----------------------------
revision 0.247
date: 2004/03/19 00:16:19;  author: emma;  state: Exp;  lines: +21 -8
Move Dave Jones' addresses to regexp section.
Add several more mappings.
Re-sort with LANG=POSIX.
----------------------------
revision 0.246
date: 2004/03/16 19:36:07;  author: emma;  state: Exp;  lines: +13 -1
Several new addresses.
----------------------------
revision 0.245
date: 2004/03/15 17:12:08;  author: emma;  state: Exp;  lines: +3 -1
Add two new mappings.
=============================================================================
Index: lk-changelog.pl
===================================================================
RCS file: /var/CVS/lk-changelog/lk-changelog.pl,v
retrieving revision 0.245
diff -u -r0.245 lk-changelog.pl
--- lk-changelog.pl	15 Mar 2004 17:12:08 -0000	0.245
+++ lk-changelog.pl	30 Mar 2004 01:16:38 -0000
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.245 2004/03/15 17:12:08 emma Exp $
+# $Id: lk-changelog.pl,v 0.255 2004/03/30 01:16:17 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -73,6 +73,7 @@
 [ 'alan@[^.]+\.swansea\.linux\.org\.uk' => 'Alan Cox', ],
 [ 'bos@([^.]+\.)?serpentine\.com' => 'Bryan O\'Sullivan', ],
 [ 'chas@([^.]+\.)*nrl\.navy\.mil' => 'Chas Williams', ],
+[ 'davej@(.*\.)?codemonkey\W' => 'Dave Jones', ],
 [ 'davem@[^.]+\.ninka\.net' => 'David S. Miller', ],
 [ 'kuznet@[^.]+\.inr\.ac\.ru' => 'Alexey Kuznetsov', ],
 [ 'torvalds@([^.]+\.)?transmeta\.com' => 'Linus Torvalds', ],
@@ -106,6 +107,11 @@
 'chas:locutus.cmf.nrl.navy.mil' => 'Chas Williams',
 'chas:nrl.navy.mil' => 'Chas Williams',
 'chas:relax.cmf.nrl.navy.mil' => 'Chas Williams',
+'davej:codemonkey.or' => 'Dave Jones',
+'davej:codemonkey.org.u' => 'Dave Jones',
+'davej:codemonkey.org.uk' => 'Dave Jones',
+'davej:delerium.codemonkey.org.uk' => 'Dave Jones',
+'davej:wopr.codemonkey.org.uk' => 'Dave Jones',
 'davem:cheetah.ninka.net' => 'David S. Miller',
 'davem:nuts.ninka.net' => 'David S. Miller',
 'davem:pizda.ninka.net' => 'David S. Miller', # guessed
@@ -129,6 +135,8 @@
 
 my %addresses = (
 '_nessuno_:katamail.com' => 'Davide Andrian',
+'a.kasparas:gmc.lt' => 'Aidas Kasparas',
+'a.othieno:ch.rmk.(none)' => 'Arthur Othieno',
 'a.wegele:tu-bs.de' => 'Artur Wegele',
 'aaron.baranoff:tsc.tdk.com' => 'Aaron Baranoff',
 'abbotti:mev.co.uk' => 'Ian Abbott',
@@ -184,6 +192,7 @@
 'akpm:reardensteel.com' => 'Andrew Morton',
 'akpm:zip.com.au' => 'Andrew Morton',
 'akropel1:rochester.rr.com' => 'Adam Kropelin', # lbdb
+'alain:linux.lu' => 'Alain Knaff',
 'alan:lxorguk.ukuu.org.uk' => 'Alan Cox',
 'alan:redhat.com' => 'Alan Cox',
 'albert.cahalan:ccur.com' => 'Albert Cahalan',
@@ -213,6 +222,7 @@
 'amunoz:vmware.com' => 'Alberto Munoz',
 'andersen:codepoet.org' => 'Erik Andersen',
 'andersg:0x63.nu' => 'Anders Gustafsson',
+'andikies:t-online.de' => 'Andreas Kies',
 'andmike:us.ibm.com' => 'Mike Anderson', # lbdb
 'andre.breiler:null-mx.org' => 'André Breiler',
 'andrea:suse.de' => 'Andrea Arcangeli',
@@ -253,6 +263,7 @@
 'aspicht:arkeia.com' => 'Arnaud Spicht',
 'atul.mukker:lsil.com' => 'Atul Mukker',
 'atulm:lsil.com' => 'Atul Mukker',
+'aurelien:aurel32.net' => 'Aurelien Jarno', # lbdb
 'aviro:parcelfarce.linux.theplanet.co.uk' => 'Alexander Viro',
 'awagger:web.de' => 'Axel Waggershauser',
 'axboe:burns.home.kernel.dk' => 'Jens Axboe', # guessed
@@ -315,11 +326,13 @@
 'brett:bad-sports.com' => 'Brett Pemberton',
 'brian:rentec.com' => 'Brian Childs',
 'brihall:pcisys.net' => 'Brian Hall', # google
+'brill:fs.math.uni-frankfurt.de' => 'Björn Brill',
 'brking:us.ibm.com' => 'Brian King',
 'brm:murphy.dk' => 'Brian Murphy',
 'brownfld:irridia.com' => 'Ken Brownfield',
 'bryder:paradise.net.nz' => 'Bill Ryder',
 'buffer:antifork.org' => 'Angelo Dell\'Aera',
+'bunk:de.rmk.(none)' => 'Adrian Bunk', # guessed
 'bunk:fs.tum.de' => 'Adrian Bunk',
 'buytenh:gnu.org' => 'Lennert Buytenhek',
 'bwa:us.ibm.com' => 'Bruce Allan',
@@ -364,10 +377,12 @@
 'chrisw:osdl.org' => 'Chris Wright',
 'chyang:clusterfs.com' => 'Chen Yang',
 'ciaranm:gentoo.org' => 'Ciaran McCreesh',
+'cieciwa:alpha.zarz.agh.edu.pl' => 'Wojciech Cieciwa',
 'cip307:cip.physik.uni-wuerzburg.de' => 'Jochen Karrer', # from shortlog
 'ckulesa:as.arizona.edu' => 'Craig Kulesa',
 'clemens-dated-1061728015.bf63:endorphin.org' => 'Fruhwirth Clemens',
 'clemens:ladisch.de' => 'Clemens Ladisch',
+'clemy:clemy.org' => 'Bernhard C. Schrenk',
 'cloos:jhcloos.com' => 'James H. Cloos Jr.',
 'cloos:lugabout.jhcloos.org' => 'James H. Cloos Jr.',
 'cmayor:ca.rmk.(none)' => 'Cam Mayor',
@@ -375,6 +390,7 @@
 'cniehaus:handhelds.org' => 'Carsten Niehaus',
 'cobra:compuserve.com' => 'Kevin Brosius',
 'colin:gibbs.dhs.org' => 'Colin Gibbs',
+'colin:gibbsonline.net' => 'Colin Gibbs', # whois
 'colpatch:us.ibm.com' => 'Matthew Dobson',
 'corbet:lwn.net' => 'Jonathan Corbet',
 'corryk:us.ibm.com' => 'Kevin Corry',
@@ -404,6 +420,7 @@
 'damien.morange:hp.com' => 'Damien Morange',
 'dan.zink:hp.com' => 'Dan Zink',
 'dan:debian.org' => 'Daniel Jacobowitz',
+'dan:geefour.netx4.com' => 'Dan Malek',
 'dan:reactivated.net' => 'Daniel Drake',
 'dana.lacoste:peregrine.com' => 'Dana Lacoste',
 'danc:mvista.com' => 'Dan Cox', # some CREDITS patch found by google
@@ -416,12 +433,10 @@
 'dank:kegel.com' => 'Dan Kegel',
 'dario:emc.com' => 'Dario Ballabio', # Alan Cox
 'dave.jiang:com.rmk.(none)' => 'Dave Jiang',
+'dave.jiang:intel.com' => 'Dave Jiang', # lbdb
 'dave:qix.net' => 'Dave Maietta',
 'dave:thedillows.org' => 'David Dillow',
-'davej:codemonkey.or' => 'Dave Jones',
-'davej:codemonkey.org.u' => 'Dave Jones',
-'davej:codemonkey.org.uk' => 'Dave Jones',
-'davej:codmonkey.org.uk' => 'Dave Jones',
+'davej:codmonkey.org.uk' => 'Dave Jones', # not matched by regexp above
 'davej:hardwired.(none)' => 'Dave Jones',
 'davej:redhat.com' => 'Dave Jones', # lbdb
 'davej:suse.de' => 'Dave Jones',
@@ -474,6 +489,7 @@
 'dirk.uffmann:nokia.com' => 'Dirk Uffmann',
 'dkuhlen:fhm.edu' => 'Dominik Kuhlen',
 'dledford:aladin.rdu.redhat.com' => 'Doug Ledford',
+'dledford:build-base.perf.redhat.com' => 'Doug Ledford', # guessed
 'dledford:compaq.xsintricity.com' => 'Doug Ledford',
 'dledford:dledford.theledfords.org' => 'Doug Ledford',
 'dledford:flossy.devel.redhat.com' => 'Doug Ledford',
@@ -515,6 +531,7 @@
 'eddie.williams:steeleye.com' => 'Eddie Williams',
 'edv:macrolink.com' => 'Ed Vance',
 'edward_peng:dlink.com.tw' => 'Edward Peng',
+'edwardsg:sgi.com' => 'Greg Edwards', # google
 'efocht:ess.nec.de' => 'Erich Focht',
 'ehabkost:conectiva.com.br' => 'Eduardo Pereira Habkost',
 'eike-hotplug:sf-tec.de' => 'Rolf Eike Beer',
@@ -566,6 +583,7 @@
 'flo:rfc822.org' => 'Florian Lohoff',
 'florian.thiel:gmx.net' => 'Florian Thiel', # from shortlog
 'florin:iucha.net' => 'Florin Iucha',
+'floroiu:fokus.fraunhofer.de' => 'John Williams Floroiu',
 'fnm:fusion.ukrsat.com' => 'Nick Fedchik',
 'focht:ess.nec.de' => 'Erich Focht',
 'fokkensr:fokkensr.vertis.nl' => 'Rolf Fokkens',
@@ -655,6 +673,7 @@
 'helgaas:hp.com' => 'Bjorn Helgaas', # guessed
 'henk:god.dyndns.org' => 'Henk Vergonet',
 'henning:meier-geinitz.de' => 'Henning Meier-Geinitz',
+'henning:wh9.tu-dresden.de' => 'Henning Schild',
 'henrique2.gobbi:cyclades.com' => 'Henrique Gobbi',
 'henrique:cyclades.com' => 'Henrique Gobbi',
 'herbert:13thfloor.at' => 'Herbert Pötzl', # lbdb
@@ -664,6 +683,7 @@
 'hjm:redhat.com' => 'Heinz Mauelshagen', # lbdb
 'hoho:binbash.net' => 'Colin Slater',
 'hollisb:us.ibm.com' => 'Hollis Blanchard',
+'home:mdiehl.de' => 'Martin Diehl',
 'horms:verge.net.au' => 'Simon Horman',
 'hpa:transmeta.com' => 'H. Peter Anvin',
 'hpa:zytor.com' => 'H. Peter Anvin',
@@ -706,6 +726,7 @@
 'james:superbug.demon.co.uk' => 'James Courtier-Dutton',
 'james_mcmechan:hotmail.com' => 'James McMechan',
 'jamesclv:us.ibm.com' => 'James Cleverdon',
+'jamesl:appliedminds.com' => 'James Lamanna',
 'jamey.hicks:hp.com' => 'Jamey Hicks',
 'jamey:crl.dec.com' => 'Jamey Hicks',
 'jamie:shareable.org' => 'Jamie Lokier',
@@ -740,6 +761,7 @@
 'jeb.j.cramer:intel.com' => 'Jeb J. Cramer',
 'jef:linuxbe.org' => 'Jean-Francois Dive',
 'jeff.wiedemeier:hp.com' => 'Jeff Wiedemeier',
+'jeffm:suse.com' => 'Jeff Mahoney',
 'jeffs:accelent.com' => 'Jeff Sutherland', # lbdb
 'jejb:fuzzy.(none)' => 'James Bottomley',
 'jejb:jet.(none)' => 'James Bottomley', # wild guess
@@ -796,6 +818,7 @@
 'johann.deneux:laposte.net' => 'Johann Deneux',
 'johannes:erdfelt.com' => 'Johannes Erdfelt',
 'john:deater.net' => 'John Clemens',
+'john:fremlin.de' => 'John Fremlin',
 'john:grabjohn.com' => 'John Bradford',
 'john:larvalstage.com' => 'John Kim',
 'john:neggie.net' => 'John Belmonte',
@@ -804,6 +827,7 @@
 'johnrose:austin.ibm.com' => 'John Rose',
 'johnstul:us.ibm.com' => 'John Stultz',
 'jon:focalhost.com' => 'Jon Oberheide',
+'jonas.larsson:net.rmk.(none)' => 'Jonas Larsson',
 'jones:ingate.com' => 'Jones Desougi',
 'jonsmirl:yahoo.com' => 'Jon Smirl',
 'joris:struyve.be' => 'Joris Struyve',
@@ -825,6 +849,7 @@
 'judd:jpilot.org' => 'Judd Montgomery',
 'jun.nakajima:intel.com' => 'Jun Nakajima',
 'jung-ik.lee:intel.com' => 'Jung-Ik Lee',
+'jurgen:botz.org' => 'Jürgen Botz',
 'jwoithe:physics.adelaide.edu.au' => 'Jonathan Woithe',
 'k-suganuma:mvj.biglobe.ne.jp' => 'Kimio Suganuma',
 'k.kasprzak:box43.pl' => 'Karol Kasprzak', # by Kristian Peters
@@ -850,6 +875,7 @@
 'kartik_me:hotmail.com' => 'Kartikey Mahendra Bhatt',
 'kas:informatics.muni.cz' => 'Jan Kasprzak', # lbdb
 'kasperd:daimi.au.dk' => 'Kasper Dupont',
+'katzj:redhat.com' => 'Jeremy Katz',
 'kaz:earth.email.ne.jp' => 'Kazuto Miyoshi',
 'kazunori:miyazawa.org' => 'Kazunori Miyazawa',
 'kberg:linux1394.org' => 'Steve Kinneberg',
@@ -880,6 +906,7 @@
 'knut_petersen:t-online.de' => 'Knut Petersen',
 'kochi:hpc.bs1.fc.nec.co.jp' => 'Kochi Takayoshi',
 'kolya:mit.edu' => 'Nickolai Zeldovich',
+'komoriya:paken.org' => 'Takeru Komoriya', # google
 'komujun:nifty.com' => 'Jun Komuro', # google
 'kpc-usbdev:gelato.uiuc.edu' => 'Kevin Cernekee',
 'kpfleming:cox.net' => 'Kevin P. Fleming',
@@ -901,6 +928,7 @@
 'laforge:gnumonks.org' => 'Harald Welte',
 'laforge:netfilter.org' => 'Harald Welte',
 'laforge:org.rmk.(none)' => 'Harald Welte', # guessed
+'lathiat:sixlabs.org' => 'Trent Lathiat Lloyd',
 'latten:austin.ibm.com' => 'Joy Latten',
 'laurent:latil.nom.fr' => 'Laurent Latil',
 'lavarre:iomega.com' => 'Pat LaVarre',
@@ -998,6 +1026,7 @@
 'mark:alpha.dyndns.org' => 'Mark W. McClelland',
 'mark:hal9000.dyndns.org' => 'Mark W. McClelland',
 'mark:net.rmk.(none)' => 'Mark Hindley',
+'markgw:sgi.com' => 'Mark Goodwin',
 'markh:osdl.org' => 'Mark Haverkamp',
 'markhe:veritas.com' => 'Mark Hemment',
 'marr:flex.com' => 'Bill Marr',
@@ -1025,6 +1054,8 @@
 'mb:ozaba.mine.nu' => 'Magnus Boden',
 'mbligh:aracnet.com' => 'Martin J. Bligh',
 'mbp:samba.org' => 'Martin Pool', # lbdb
+'mcgrof:ruslug.rutgers.edu' => 'Luis R. Rodriguez',
+'mcgrof:studorgs.rutgers.edu' => 'Luis R. Rodriguez',
 'mcp:linux-systeme.de' => 'Marc-Christian Petersen',
 'mdharm-scsi:one-eyed-alien.net' => 'Matthew Dharm',
 'mdharm-usb:one-eyed-alien.net' => 'Matthew Dharm',
@@ -1047,6 +1078,7 @@
 'michaelw:foldr.org' => 'Michael Weber', # google
 'michal:harddata.com' => 'Michal Jaegermann',
 'michal:logix.cz' => 'Michal Ludvig',
+'michal_dobrzynski:mac.com' => 'Michal Dobrzynski',
 'michel:daenzer.net' => 'Michel Dänzer',
 'miguel:cetuc.puc-rio.br' => 'Miguel Freitas', # lbdb
 'mikael.starvik:axis.com' => 'Mikael Starvik',
@@ -1078,6 +1110,7 @@
 'mlindner:syskonnect.de' => 'Mirko Lindner',
 'mlocke:mvista.com' => 'Montavista Software, Inc.',
 'mlord:pobox.com' => 'Mark Lord',
+'mlotek:foobar.pl' => 'Michal Mlotek',
 'mludvig:suse.cz' => 'Michal Ludvig',
 'mmagallo:debian.org' => 'Marcelo E. Magallon',
 'mmcclell:bigfoot.com' => 'Mark McClelland',
@@ -1139,6 +1172,7 @@
 'noah:caltech.edu' => 'Noah J. Misch',
 'nobita:t-online.de' => 'Andreas Busch',
 'normalperson:yhbt.net' => 'Eric Wong',
+'not:just.any.name' => 'John Fremlin',
 'nstraz:sgi.com' => 'Nathan Straz',
 'ntfs:flatcap.org' => 'Richard Russon', # lbdb
 'nuno:itsari.org' => 'Nuno Monteiro',
@@ -1179,6 +1213,7 @@
 'paul.clements:steeleye.com' => 'Paul Clements',
 'paul.mundt:timesys.com' => 'Paul Mundt', # google
 'paul:kungfoocoder.org' => 'Paul Wagland', # lbdb
+'paul:wagland.net' => 'Paul Wagland', # lbdb
 'paulkf:microgate.com' => 'Paul Fulghum',
 'paulm:routefree.com' => 'Paul Mielke',
 'paulus:au1.ibm.com' => 'Paul Mackerras',
@@ -1206,6 +1241,7 @@
 'perex:perex.cz' => 'Jaroslav Kysela',
 'perex:pnote.perex-int.cz' => 'Jaroslav Kysela',
 'perex:suse.cz' => 'Jaroslav Kysela',
+'perrye:linuxmail.org' => 'Perry Gilfillan', # lbdb
 'peter:bergner.org' => 'Peter Bergner',
 'peter:cadcamlab.org' => 'Peter Samuelson',
 'peter:chubb.wattle.id.au' => 'Peter Chubb',
@@ -1227,6 +1263,7 @@
 'petri.koistinen:iki.fi' => 'Petri Koistinen',
 'petrides:redhat.com' => 'Ernie Petrides',
 'pfg:sgi.com' => 'Pat Gefre',
+'pg:futureware.at' => 'Philipp Gühring',
 'phil.el:wanadoo.fr' => 'Philippe Elie',
 'philipc:snapgear.com' => 'Philip Craig',
 'philipp:void.at' => 'Philipp Friedrich',
@@ -1292,6 +1329,7 @@
 'rhw:infradead.org' => 'Riley Williams',
 'richard.brunner:amd.com' => 'Richard Brunner',
 'richard.curnow:superh.com' => 'Richard Curnow',
+'ricklind:us.ibm.com' => 'Rick Lindsley',
 'riel:conectiva.com.br' => 'Rik van Riel',
 'riel:imladris.surriel.com' => 'Rik van Riel',
 'riel:redhat.com' => 'Rik van Riel',
@@ -1355,6 +1393,7 @@
 'samel:mail.cz' => 'Vitezslav Samel',
 'samuel.thibault:ens-lyon.fr' => 'Samuel Thibault',
 'samuel.thibault:fnac.net' => 'Samuel Thibault', # lbdb
+'samuel:ibrium.se' => 'Samuel Rydh',
 'sandeen:sgi.com' => 'Eric Sandeen',
 'santiago:newphoenix.net' => 'Santiago A. Nullo', # sent by self
 'santil:us.ibm.com' => 'Santiago Leon',
@@ -1427,6 +1466,8 @@
 'sridhar:x1-6-00-10-a4-8b-06-f6.attbi.com' => 'Sridhar Samudrala',
 'srk:thekelleys.org.uk' => 'Simon Kelley',
 'srompf:isg.de' => 'Stefan Rompf',
+'sryoungs:au.rmk.(none)' => 'Steve Youngs', # guessed
+'sryoungs:bigpond.net.au' => 'Steve Youngs', # GnuPG key servers
 'stanley.wang:linux.co.intel.com' => 'Stanley Wang',
 'stefan.becker:nokia.com' => 'Stefan Becker',
 'stefan.eletzhofer:eletztrick.de' => 'Stefan Eletzhofer',
@@ -1463,6 +1504,7 @@
 'swiergot:intersec.pl' => 'Jaroslaw Swierczynski',
 'szepe:pinerecords.com' => 'Tomas Szepe',
 'sziwan:hell.org.pl' => 'Karol Kozimor',
+'szuk:telusplanet.net' => 'Scott Zuk',
 't-kochi:bq.jp.nec.com' => 'Takayoshi Kochi', # not a typo
 't-kouchi:mvf.biglobe.ne.jp' => 'Takayoshi Kouchi',
 'tai:imasy.or.jp' => 'Taisuke Yamada',
@@ -1474,6 +1516,7 @@
 'tausq:debian.org' => 'Randolph Chung',
 'tcallawa:redhat.com' => "Tom 'spot' Callaway",
 'tchen:on-go.com' => 'Thomas Chen',
+'tejohnson:yahoo.com' => 'Todd E. Johnson',
 'tes:sgi.com' => 'Timothy Shimmin',
 'tetapi:utu.fi' => 'Tero Pirkkanen', # by Kristian Peters
 'tgraf:suug.ch' => 'Thomas Graf',
@@ -1483,6 +1526,7 @@
 'thiel:ksan.de' => 'Florian Thiel', # lbdb
 'thockin:freakshow.cobalt.com' => 'Tim Hockin',
 'thockin:sun.com' => 'Tim Hockin',
+'thoffman:arnor.net' => 'Torrey Hoffman',
 'thomas:bender.thinknerd.de' => 'Thomas Walpuski',
 'thomas:habets.pp.se' => 'Thomas Habets',
 'thomas:osterried.de' => 'Thomas Osterried',
@@ -1494,6 +1538,7 @@
 'thunder:ngforever.de' => 'Thunder From The Hill',
 'tigran:aivazian.name' => 'Tigran Aivazian',
 'tigran:veritas.com' => 'Tigran Aivazian',
+'tim:cambrant.com' => 'Tim Cambrant', # lbdb
 'tim:physik3.uni-rostock.de' => 'Tim Schmielau',
 'timw:splhi.com' => 'Tim Wright',
 'tinglett:vnet.ibm.com' => 'Todd Inglett',
@@ -1534,6 +1579,7 @@
 'tytso:mit.edu' => "Theodore Y. T'so", # web.mit.edu/tytso/www/home.html
 'tytso:snap.thunk.org' => "Theodore Y. T'so",
 'tytso:think.thunk.org' => "Theodore Y. T'so", # guessed
+'u233:shaw.ca' => 'Trent Whaley',
 'urban.widmark:enlight.net' => 'Urban Widmark',
 'urban:teststation.com' => 'Urban Widmark',
 'uzi:uzix.org' => 'Joshua Uziel',
@@ -1572,7 +1618,9 @@
 'wcohen:redhat.com' => 'Will Cohen',
 'wd:denx.de' => 'Wolfgang Denk',
 'webvenza:libero.it' => 'Daniele Venzano',
+'weeve:gentoo.org' => 'Jason Wever',
 'wei_ni:ali.com.tw' => 'Wei Ni',			# Guessed
+'weicht:in.tum.de' => 'Thomas Weich',
 'weigand:immd1.informatik.uni-erlangen.de' => 'Ulrich Weigand',
 'weihs:linux1394.org' => 'Manfred Weihs',
 'wensong:linux-vs.org' => 'Wensong Zhang',
@@ -2014,6 +2062,34 @@
   return ();
 }
 
+sub treat_addr_name(\$\$) {
+    my ($address, $name) = @_;
+    my $havename = $$name ne $$address;
+    my $author;
+
+    if ($opt{'obfuscate'}) {
+	$$address = obfuscate $$address;
+    }
+
+    if ($havename) {
+	if ($opt{'abbreviate-names'}) {
+	    $$name = abbreviate_name($$name);
+	}
+	if ($opt{'omitaddresses'}) {
+	    $author = $$name;
+	} else {
+	    $author = $$name . ' <' . $$address . '>';
+	}
+    } else { # $havename
+	# must obfuscate name since it contains an address still
+	if ($opt{obfuscate}) {
+	    $$name = obfuscate $$name;
+	}
+	$author = '<' . $$address . '>';
+    }
+    return $author;
+}
+
 # Read a file and parse it into the %log hash.
 sub parse_file(\%$$ ) {
 # arguments: %log hash
@@ -2066,28 +2142,15 @@
       $address = lc($1);
       $address =~ s/\[[^]]+\]$//;
       $name = rmap_address($address);
-      my $havename = $name ne $address;
-      if ($opt{'obfuscate'}) {
-	$address = obfuscate $address;
-      }
-      if ($havename) {
-	if ($opt{'abbreviate-names'}) {
-	  $name = abbreviate_name($name);
-	}
-	if ($opt{'omitaddresses'}) {
-	  $author = $name;
-	} else {
-	  $author = $name . ' <' . $address . '>';
-	}
-      } else { # $havename
-	# must obfuscate name since it contains an address still
-	if ($opt{obfuscate}) {
-	    $name = obfuscate $name;
-	}
-	$author = '<' . $address . '>';
-      }
+      $author = treat_addr_name($address, $name);
+      print STDERR "AUTHOR $author\n" if $debug;
       $first = 1;
       $firstpar = 1;
+    } elsif (/^\s+From:\s*(.*)\s+\<(.*)\>\s*$/) {
+      $name = $1;
+      $address = lc $2;
+      $author = treat_addr_name($address, $name);
+      print STDERR " FROM  $author\n" if $debug;
     } elsif ($first) {
       # we have a "first" line after an address, take it, 
       # strip common redundant tags

