Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265510AbUAGLb3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 06:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265503AbUAGLb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 06:31:29 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:51672 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S266199AbUAGLaC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 06:30:02 -0500
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: lk-changelog.pl 0.213
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Wed_Jan__7_11_29_59_UTC_2004_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20040107112959.4D7D7A030E@merlin.emma.line.org>
Date: Wed,  7 Jan 2004 12:29:59 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a semi-automatic announcement.

lk-changelog.pl aka. shortlog version 0.213 has been released.

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
revision 0.213
date: 2004/01/07 09:45:46;  author: vita;  state: Exp;  lines: +9 -6
resort address->name hash with LC_ALL=POSIX sort -u
----------------------------
revision 0.212
date: 2004/01/07 08:38:47;  author: vita;  state: Exp;  lines: +38 -1
34 new addresses
----------------------------
revision 0.211
date: 2004/01/05 01:07:20;  author: emma;  state: Exp;  lines: +6 -1
Pull in two addresses from Linus' tree.
----------------------------
revision 0.210
date: 2003/12/30 02:11:39;  author: emma;  state: Exp;  lines: +8 -1
4 new addresses.
=============================================================================
Index: lk-changelog.pl
===================================================================
RCS file: /var/CVS/lk-changelog/lk-changelog.pl,v
retrieving revision 0.210
retrieving revision 0.213
diff -u -r0.210 -r0.213
--- lk-changelog.pl	30 Dec 2003 02:11:39 -0000	0.210
+++ lk-changelog.pl	7 Jan 2004 09:45:46 -0000	0.213
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.210 2003/12/30 02:11:39 emma Exp $
+# $Id: lk-changelog.pl,v 0.213 2004/01/07 09:45:46 vita Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -122,6 +122,7 @@
 undef @addresses_handled_in_regexp;
 
 my %addresses = (
+'_nessuno_:katamail.com' => 'Davide Andrian',
 'a.wegele:tu-bs.de' => 'Artur Wegele',
 'aaron.baranoff:tsc.tdk.com' => 'Aaron Baranoff',
 'abbotti:mev.co.uk' => 'Ian Abbott',
@@ -191,6 +192,7 @@
 'alexander.riesen:synopsys.com' => 'Alexander Riesen',
 'alexander.schulz:com.rmk.(none)' => 'Alexander Schulz',
 'alexander.schulz:innominate.com' => 'Alexander Schulz',
+'alexander:all-2.com' => 'Alexander Oltu',
 'alexey:technomagesinc.com' => 'Alex Tomas',
 'alext:fc.hp.com' => 'Alex Tsariounov',
 'alfre:ibd.es' => 'Alfredo Sanjuán',
@@ -206,9 +208,9 @@
 'andmike:us.ibm.com' => 'Mike Anderson', # lbdb
 'andre.breiler:null-mx.org' => 'André Breiler',
 'andrea:suse.de' => 'Andrea Arcangeli',
-'andrew:com.rmk.(none)' => 'Andrew Victor', # double-check
 'andrew.grover:intel.com' => 'Andy Grover', # "Andy" to match former entries
 'andrew.wood:ivarch.com' => 'Andrew Wood',
+'andrew:com.rmk.(none)' => 'Andrew Victor', # double-check
 'andries.brouwer:cwi.nl' => 'Andries E. Brouwer',
 'andros:citi.umich.edu' => 'Andy Adamson',
 'angus.sawyer:dsl.pipex.com' => 'Angus Sawyer',
@@ -219,6 +221,7 @@
 'apolkosnik:directvinternet.com' => 'Adam Polkosnik',
 'arashi:yomerashi.yi.org' => 'Matt Reppert',
 'arekm:pld-linux.org' => 'Arkadiusz Miskiewicz', # lbdb
+'arief_m_utama:telkomsel.co.id' => 'Arief Mulya Utama',
 'aris:cathedrallabs.org' => 'Aristeu Sergio Rozanski Filho',
 'arjan:redhat.com' => 'Arjan van de Ven',
 'arjanv:redhat.com' => 'Arjan van de Ven',
@@ -235,8 +238,9 @@
 'asit.k.mallick:intel.com' => 'Asit K. Mallick', # by Kristian Peters
 'asl:launay.org' => 'Arnaud S. Launay',
 'aspicht:arkeia.com' => 'Arnaud Spicht',
-'atulm:lsil.com' => 'Atul Mukker',
 'atul.mukker:lsil.com' => 'Atul Mukker',
+'atulm:lsil.com' => 'Atul Mukker',
+'aviro:parcelfarce.linux.theplanet.co.uk' => 'Alexander Viro',
 'axboe:burns.home.kernel.dk' => 'Jens Axboe', # guessed
 'axboe:hera.kernel.org' => 'Jens Axboe',
 'axboe:suse.de' => 'Jens Axboe',
@@ -263,6 +267,7 @@
 'bellucda:tiscali.it' => 'Daniele Bellucci',
 'benh:kernel.crashing.org' => 'Benjamin Herrenschmidt',
 'benh:zion.wanadoo.fr' => 'Benjamin Herrenschmidt',
+'berentsen:sent5.uni-duisburg.de' => 'Martin Berentsen',
 'bergner:brule.rchland.ibm.com' => 'Peter Bergner',
 'bergner:cannon.rchland.ibm.com' => 'Peter Bergner',
 'bergner:vnet.ibm.com' => 'Peter Bergner',
@@ -287,6 +292,7 @@
 'bmatheny:purdue.edu' => 'Blake Matheny', # google
 'bombe:informatik.tu-muenchen.de' => 'Andreas Bombe',
 'borisitk:fortunet.com' => 'Boris Itkis', # by Kristian Peters
+'boutcher:us.ibm.com' => 'Dave Boutcher',
 'braam:clusterfs.com' => 'Peter Braam',
 'brett:bad-sports.com' => 'Brett Pemberton',
 'brihall:pcisys.net' => 'Brian Hall', # google
@@ -340,6 +346,7 @@
 'christopher:intel.com' => 'Christopher Goldfarb',
 'chrisw:osdl.org' => 'Chris Wright',
 'chyang:clusterfs.com' => 'Chen Yang',
+'ciaranm:gentoo.org' => 'Ciaran McCreesh',
 'cip307:cip.physik.uni-wuerzburg.de' => 'Jochen Karrer', # from shortlog
 'ckulesa:as.arizona.edu' => 'Craig Kulesa',
 'clemens-dated-1061728015.bf63:endorphin.org' => 'Fruhwirth Clemens',
@@ -382,10 +389,12 @@
 'dan:reactivated.net' => 'Daniel Drake',
 'dana.lacoste:peregrine.com' => 'Dana Lacoste',
 'danc:mvista.com' => 'Dan Cox', # some CREDITS patch found by google
+'dancy:dancysoft.com' => 'Ahmon Dancy',
 'daniel.ritz:ch.rmk.(none)' => 'Daniel Ritz',
 'daniel.ritz:gmx.ch' => 'Daniel Ritz',
 'daniel:deadlock.et.tudelft.nl' => 'Daniël Mantione',
 'daniel:osdl.org' => 'Daniel McNeil',
+'daniela:cyclades.com' => 'Daniela Squassoni',
 'dank:kegel.com' => 'Dan Kegel',
 'dario:emc.com' => 'Dario Ballabio', # Alan Cox
 'dave.jiang:com.rmk.(none)' => 'Dave Jiang',
@@ -436,6 +445,7 @@
 'dhollis:davehollis.com' => 'David T. Hollis',
 'dhowells:cambridge.redhat.com' => 'David Howells',
 'dhowells:redhat.com' => 'David Howells',
+'dhylands:com.rmk.(none)' => 'Dave Hylands',
 'dilinger:mp3revolution.net' => 'Andres Salomon',
 'dipankar:in.ibm.com' => 'Dipankar Sarma',
 'dirk.behme:com.rmk.(none)' => 'Dirk Behme',
@@ -481,9 +491,11 @@
 'eike:bilbo.math.uni-mannheim.de' => 'Rolf Eike Beer',
 'elenstev:com.rmk.(none)' => 'Steven Cole',
 'elenstev:mesatop.com' => 'Steven Cole',
+'elf:com.rmk.(none)' => 'Marc Singer',
 'eli.carter:com.rmk.(none)' => 'Eli Carter',
 'eli.kupermann:intel.com' => 'Eli Kupermann',
 'emann:mrv.com' => 'Eran Mann',
+'engebret:au1.ibm.com' => 'David Engebretsen',
 'engebret:brule.rchland.ibm.com' => 'David Engebretsen',
 'engebret:us.ibm.com' => 'David Engebretsen',
 'eranian:frankl.hpl.hp.com' => 'Stéphane Eranian',
@@ -496,6 +508,7 @@
 'erik_habbinga:hp.com' => 'Erik Habbinga',
 'erikj:subway.americas.sgi.com' => 'Erik Jacobson',
 'erlend-a:us.his.no' => 'Erlend Aasland',
+'erlend-a:ux.his.no' => 'Erlend Aasland',
 'ernstp:mac.com' => 'Ernst Persson', # lbdb
 'eyal:eyal.emu.id.au' => 'Eyal Lebedinsky', # lbdb
 'faikuygur:ttnet.net.tr' => 'Faik Uygur',
@@ -505,6 +518,7 @@
 'fcusack:fcusack.com' => 'Frank Cusack',
 'fdavis:si.rr.com' => 'Frank Davis',
 'felipewd:terra.com.br' => 'Felipe Damasio', # by self (did not ask to include the W.)
+'fello:libero.it' => 'Fabrizio Fellini',
 'fenghua.yu:intel.com' => 'Fenghua Yu', # google
 'fero:sztalker.hu' => 'Bakonyi Ferenc',
 'filip.sneppe:cronos.be' => 'Filip Sneppe',
@@ -715,6 +729,7 @@
 'jmcmullan:linuxcare.com' => 'Jason McMullan',
 'jmm:informatik.uni-bremen.de' => 'Moritz Mühlenhoff',
 'jmorris:intercode.com.au' => 'James Morris',
+'jmorris:redhat.com' => 'James Morris',
 'jmorros:intercode.com.au' => 'James Morris',	# it's typo IMHO
 'jo-lkml:suckfuell.net' => 'Jochen Suckfuell',
 'jochen:jochen.org' => 'Jochen Hein',
@@ -846,6 +861,7 @@
 'levon:movementarian.org' => 'John Levon',
 'lfo:polyad.org' => 'Luis F. Ortiz',
 'liam.girdwood:wolfsonmicro.com' => 'Liam Girdwood',
+'linas:us.ibm.com' => 'Linas Vepstas',
 'linux-usb:gemeinhardt.info' => 'Lars Gemeinhardt',
 'linux:brodo.de' => 'Dominik Brodowski',
 'linux:de.rmk.(none)' => 'Dominik Brodowski',
@@ -872,6 +888,8 @@
 'lowekamp:cs.wm.edu' => 'Bruce B. Lowekamp', # lbdb
 'luben:splentec.com' => 'Luben Tuikov',
 'luc.vanoostenryck:easynet.be' => 'Luc Van Oostenryck', # lbdb
+'luca.risolia:studio.unibo.it' => 'Luca Risolia',
+'luca:libero.it' => 'Luca Risolia',
 'lucasvr:terra.com.br' => 'Lucas Correia Villa Real', # google
 'lunz:falooley.org' => 'Jason Lunz',
 'lxiep:us.ibm.com' => 'Linda Xie',
@@ -880,6 +898,7 @@
 'maalanen:ra.abo.fi' => 'Marcus Alanen',
 'mac:melware.de' => 'Armin Schindler',
 'macro:ds2.pg.gda.pl' => 'Maciej W. Rozycki',
+'mail:de.rmk.(none)' => 'Peter Teichmann',
 'makisara:abies.metla.fi' => 'Kai Mäkisara',
 'maloi:phota.to' => 'Andy Molloy',
 'malte.d:gmx.net' => 'Malte Doersam', # google
@@ -891,6 +910,7 @@
 'mannthey:us.ibm.com' => 'Keith Mannthey',
 'marc:mbsi.ca' => 'Marc Boucher',
 'marcel:holtmann.org' => 'Marcel Holtmann', # sent by himself
+'marcelo.tosatti:cyclades.com' => 'Marcelo Tosatti',
 'marcelo.tosatti:cyclades.com.br' => 'Marcelo Tosatti',
 'marcelo:conectiva.com.br' => 'Marcelo Tosatti',
 'marcelo:dhcp-103.cyclades.de' => 'Marcelo Tosatti',
@@ -908,6 +928,7 @@
 'mark:hal9000.dyndns.org' => 'Mark W. McClelland',
 'markh:osdl.org' => 'Mark Haverkamp',
 'markhe:veritas.com' => 'Mark Hemment',
+'marr:flex.com' => 'Bill Marr',
 'martin.bene:icomedias.com' => 'Martin Bene',
 'martin.bligh:us.ibm.com' => 'Martin J. Bligh',
 'martin.schwidefsky:debitel.net' => 'Martin Schwidefsky',
@@ -928,8 +949,8 @@
 'maxk:viper.(none)' => 'Maksim Krasnyanskiy', # from shortlog
 'maxk:viper.qualcomm.com' => 'Maksim Krasnyanskiy',
 'mb:ozaba.mine.nu' => 'Magnus Boden',
-'mbp:samba.org' => 'Martin Pool', # lbdb
 'mbligh:aracnet.com' => 'Martin J. Bligh',
+'mbp:samba.org' => 'Martin Pool', # lbdb
 'mcp:linux-systeme.de' => 'Marc-Christian Petersen',
 'mdharm-scsi:one-eyed-alien.net' => 'Matthew Dharm',
 'mdharm-usb:one-eyed-alien.net' => 'Matthew Dharm',
@@ -939,13 +960,15 @@
 'mds:paradyne.com' => 'Mark D. Studebaker',
 'mec:shout.net' => 'Michael Elizabeth Chastain',
 'meissner:suse.de' => 'Marcus Meissner',
+'mfedyk:matchmail.com' => 'Mike Fedyk',
+'mgalgoci:redhat.com' => 'Matthew Galgoci',
 'mgreer:mivsta.com' => 'Mark A. Greer', # typo
 'mgreer:mvista.com' => 'Mark A. Greer', # lbdb
 'mhoffman:lightlink.com' => 'Mark M. Hoffman',
 'mhopf:innominate.com' => 'Mark-André Hopf',
 'michael:metaparadigm.com' => 'Michael Clark',
-'michaelw:foldr.org' => 'Michael Weber', # google
 'michael_e_brown:dell.com' => 'Michael E. Brown', # lbdb
+'michaelw:foldr.org' => 'Michael Weber', # google
 'michal:harddata.com' => 'Michal Jaegermann',
 'michal:logix.cz' => 'Michal Ludvig',
 'michel:daenzer.net' => 'Michel Dänzer',
@@ -953,6 +976,7 @@
 'mikal:stillhq.com' => 'Michael Still',
 'mike.miller:hp.com' => 'Mike Miller',
 'mike:aiinc.ca' => 'Michael Hayes',
+'mikem:beardog.cca.cpqcorp.net' => 'Mike Miller',
 'mikenc:us.ibm.com' => 'Mike Christie',
 'mikep:linuxtr.net' => 'Mike Phillips',
 'mikpe:csd.uu.se' => 'Mikael Pettersson',
@@ -986,6 +1010,7 @@
 'mochel:segfault.osdl.org' => 'Patrick Mochel',
 'mochel:segfault.osdlab.org' => 'Patrick Mochel',
 'moilanen:austin.ibm.com' => 'Jake Moilanen',
+'moilanen:us.ibm.com' => 'Jake Moilanen',
 'mort:green.i.bork.org' => 'Martin Hicks',
 'mort:wildopensource.com' => 'Martin Hicks',
 'mostrows:speakeasy.net' => 'Michal Ostrowski',
@@ -1032,6 +1057,7 @@
 'nobita:t-online.de' => 'Andreas Busch',
 'nstraz:sgi.com' => 'Nathan Straz',
 'ntfs:flatcap.org' => 'Richard Russon', # lbdb
+'nuno:itsari.org' => 'Nuno Monteiro',
 'okir:suse.de' => 'Olaf Kirch', # lbdb
 'okurth:gmx.net' => 'Oliver Kurth',
 'olaf.dietsche#list.linux-kernel:t-online.de' => 'Olaf Dietsche',
@@ -1085,6 +1111,7 @@
 'pee:erkkila.org' => 'Paul E. Erkkila',
 'pekon:informatics.muni.cz' => 'Petr Konecny',
 'per.winkvist:telia.com' => 'Per Winkvist',
+'per.winkvist:uk.com' => 'Per Winkvist',
 'perex:perex.cz' => 'Jaroslav Kysela',
 'perex:pnote.perex-int.cz' => 'Jaroslav Kysela',
 'perex:suse.cz' => 'Jaroslav Kysela',
@@ -1147,6 +1174,7 @@
 'randolph:tausq.org' => 'Randolph Chung',
 'randy.dunlap:verizon.net' => 'Randy Dunlap',
 'ranty:debian.org' => 'Manuel Estrada Sainz',
+'rask:sygehus.dk' => 'Rask Ingemann Lambertsen',
 'raul:pleyades.net' => 'Raul Nunez de Arenas Coronado',
 'ray-lk:madrabbit.org' => 'Ray Lee',
 'rbh00:utsglobal.com' => 'Richard Hitt', # asked him, he prefers Richard
@@ -1296,6 +1324,7 @@
 'stekloff:w-stekloff.beaverton.ibm.com' => 'Daniel Stekloff',
 'stelian.pop:fr.alcove.com' => 'Stelian Pop',
 'stelian:popies.net' => 'Stelian Pop',
+'stephane.galles:free.fr' => 'Stephane Galles', # guessed
 'stern:rowland.harvard.edu' => 'Alan Stern',
 'stern:rowland.org' => 'Alan Stern', # lbdb
 'steve.cameron:hp.com' => 'Stephen Cameron',
@@ -1323,6 +1352,7 @@
 'swiergot:intersec.pl' => 'Jaroslaw Swierczynski',
 'szepe:pinerecords.com' => 'Tomas Szepe',
 'sziwan:hell.org.pl' => 'Karol Kozimor',
+'t-kochi:bq.jp.nec.com' => 'Takayoshi Kochi', # not a typo
 't-kouchi:mvf.biglobe.ne.jp' => 'Takayoshi Kouchi',
 'tai:imasy.or.jp' => 'Taisuke Yamada',
 'taka:valinux.co.jp' => 'Hirokazu Takahashi',
@@ -1332,6 +1362,7 @@
 'taral:taral.net' => 'Jean-Philippe Sugarbroad', # Muli Ben-Yehuda on lk
 'tausq:debian.org' => 'Randolph Chung',
 'tcallawa:redhat.com' => "Tom 'spot' Callaway",
+'tchen:on-go.com' => 'Thomas Chen',
 'tes:sgi.com' => 'Timothy Shimmin',
 'tetapi:utu.fi' => 'Tero Pirkkanen', # by Kristian Peters
 'tgraf:suug.ch' => 'Thomas Graf',
@@ -1370,11 +1401,13 @@
 'trevor.pering:intel.com' => 'Trevor Pering',
 'trini:bill-the-cat.bloom.county' => 'Tom Rini',
 'trini:kernel.crashing.org' => 'Tom Rini',
+'trini:mvista.com' => 'Tom Rini',
 'trini:opus.bloom.county' => 'Tom Rini',
 'trini:org.rmk.(none)' => 'Tom Rini',
 'trivial:rustcorp.com.au' => 'Rusty Russell',
 'trond.myklebust:fys.uio.no' => 'Trond Myklebust',
 'tsk:ibakou.com' => 'Kawazoe Tomonori',
+'tspat:de.ibm.com' => 'Thomas Spatzier',
 'tv:debian.org' => 'Tommi Virtanen',
 'tvignaud:mandrakesoft.com' => 'Thierry Vignaud',
 'tvrtko:net4u.hr' => 'Tvrtko A. Ursulin',
@@ -1412,12 +1445,14 @@
 'vsu:altlinux.ru' => 'Sergey Vlasov',
 'wa:almesberger.net' => 'Werner Almesberger',
 'wahrenbruch:kobil.de' => 'Thomas Wahrenbruch',
+'waltabbyh:comcast.net' => 'Walt Holman',
 'walter.harms:informatik.uni-oldenburg.de' => 'Walter Harms',
 'warlord:mit.edu' => 'Derek Atkins',
 'warp:mercury.d2dc.net' => 'Zephaniah E. Hull',
 'wayne:stallion.oz.au' => 'Wayne Piekarski',
 'wcohen:redhat.com' => 'Will Cohen',
 'wd:denx.de' => 'Wolfgang Denk',
+'webvenza:libero.it' => 'Daniele Venzano',
 'wei_ni:ali.com.tw' => 'Wei Ni',			# Guessed
 'weigand:immd1.informatik.uni-erlangen.de' => 'Ulrich Weigand',
 'wensong:linux-vs.org' => 'Wensong Zhang',
@@ -1441,6 +1476,7 @@
 'wolfgang.fritz:gmx.net' => 'Wolfgang Fritz', # by Kristian Peters
 'wolfgang:iksw-muees.de' => 'Wolfgang Muees',
 'wolfgang:top.mynetix.de' => 'Wolfgang Mauerer',
+'woody:org.rmk.(none)' => 'Woody Suwalski',
 'wriede:riede.org' => 'Willem Riede',
 'wrlk:riede.org' => 'Willem Riede',
 'wstinson:infonie.fr' => 'William Stinson',
@@ -2163,6 +2199,15 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.213  2004/01/07 09:45:46  vita
+# resort address->name hash with LC_ALL=POSIX sort -u
+#
+# Revision 0.212  2004/01/07 08:38:47  vita
+# 34 new addresses
+#
+# Revision 0.211  2004/01/05 01:07:20  emma
+# Pull in two addresses from Linus' tree.
+#
 # Revision 0.210  2003/12/30 02:11:39  emma
 # 4 new addresses.
 #

