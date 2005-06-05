Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261556AbVFEMNQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbVFEMNQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 08:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261557AbVFEMNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 08:13:16 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:60370 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261556AbVFEMLz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 08:11:55 -0400
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: lk-changelog.pl 20050605
CC: linux-kernel@vger.kernel.org, matthias.andree@gmx.de
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Sun,_05_Jun_2005_12_11_46_+0000_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20050605121146.B15F877579@merlin.emma.line.org>
Date: Sun,  5 Jun 2005 14:11:46 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a semi-automatic announcement.

lk-changelog.pl aka. shortlog version 20050605 has been released.

This script is used by Linus and Marcelo to rearrange and reformat BK
ChangeSet logs into a more human-readable format, and the official
repository is Parent repository is file://var/bitkeeper/BK-kernel-tools

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
revision 0.329
date: 2005-06-05 14:01:18 +0200;  author: emma;  state: Exp;  lines: +160 -10
Support GIT logs.
Synch addresses from Linus' BK tools and git-shortlog.
----------------------------
revision 0.328
date: 2005-03-04 03:36:50 +0100;  author: emma;  state: Exp;  lines: +200 -3
Merge CVS <-> BK, dropping ID line which is sorta useless.
=============================================================================
Index: lk-changelog.pl
===================================================================
RCS file: /var/CVS/lk-changelog/lk-changelog.pl,v
retrieving revision 0.328
retrieving revision 0.329
diff -u -U2 -r0.328 -r0.329
--- lk-changelog.pl	4 Mar 2005 02:36:50 -0000	0.328
+++ lk-changelog.pl	5 Jun 2005 12:01:18 -0000	0.329
@@ -78,6 +78,7 @@
 [ 'bos@([^.]+\.)?serpentine\.com' => 'Bryan O\'Sullivan', ],
 [ 'chas@([^.]+\.)*nrl\.navy\.mil' => 'Chas Williams', ],
-[ 'davej@(.*\.)?codemonkey\W' => 'Dave Jones', ],
+[ 'davej@(.*\.)?codemonkey\.or(g\.uk?)?' => 'Dave Jones', ],
 [ 'davem@[^.]+\.ninka\.net' => 'David S. Miller', ],
+[ 'davem@([^.]+\.)*davemloft\.net' => 'David S. Miller', ],
 [ 'kuznet@[^.]+\.inr\.ac\.ru' => 'Alexey Kuznetsov', ],
 [ 'torvalds@([^.]+\.)?transmeta\.com' => 'Linus Torvalds', ],
@@ -145,4 +146,5 @@
 '_nessuno_:katamail.com' => 'Davide Andrian',
 'a.kasparas:gmc.lt' => 'Aidas Kasparas',
+'a.llano:usyscom.com' => 'Asier Llano Palacios',
 'a.othieno:bluewin.ch' => 'Arthur Othieno',
 'a.othieno:ch.rmk.(none)' => 'Arthur Othieno',
@@ -151,4 +153,5 @@
 'a1tmblwd:netscape.net' => 'Kam Leo',
 'aaron.baranoff:tsc.tdk.com' => 'Aaron Baranoff',
+'aaw:rincewind.tv' => 'Ollie Wild',
 'abbotti:mev.co.uk' => 'Ian Abbott',
 'abem.se:shinybook.infradead.org' => 'Per Hedblom',
@@ -178,6 +181,7 @@
 'adam:skullslayer.rod.org' => 'Adam Bernau',
 'adam:yggdrasil.com' => 'Adam J. Richter',
-'adaplas:hotpop.com' => 'Antonino Daplas',
-'adaplas:pol.net' => 'Antonino Daplas',
+'adaplas:gawab.com' => 'Antonino A. Daplas', # guessed
+'adaplas:hotpop.com' => 'Antonino A. Daplas',
+'adaplas:pol.net' => 'Antonino A. Daplas',
 'aderesch:fs.tum.de' => 'Andreas Deresch',
 'adi:drcomp.erfurt.thur.de' => 'Adrian Knoth',
@@ -190,4 +194,5 @@
 'aebr:win.tue.nl' => 'Andries E. Brouwer',
 'afleming:freescale.com' => 'Andy Fleming',
+'afong:org.rmk.(none)' => 'Amy Fong',
 'agk:redhat.com' => 'Alasdair G. Kergon',
 'agl:us.ibm.com' => 'Adam Litke',
@@ -230,8 +235,9 @@
 'akpm:digeo.com' => 'Andrew Morton',
 'akpm:org.rmk.(none)' => 'Andrew Morton',
-'akpm:osdl.org' => 'Andrew Morton', # guessed
+'akpm:osdl.org' => 'Andrew Morton',
 'akpm:reardensteel.com' => 'Andrew Morton',
 'akpm:zip.com.au' => 'Andrew Morton',
 'akropel1:rochester.rr.com' => 'Adam Kropelin', # lbdb
+'akropel:rochester.rr.com' => 'Adam Kropelin', # guessed
 'al.fracchetti:tin.it' => 'Alessandro Fracchetti',
 'alain.knaff:lll.lu' => 'Alain Knaff',
@@ -288,4 +294,5 @@
 'andersen:codepoet.org' => 'Erik Andersen',
 'andersg:0x63.nu' => 'Anders Gustafsson',
+'andi:cosy.sbg.ac.at' => 'Andreas Maier',
 'andikies:t-online.de' => 'Andreas Kies',
 'andmike:us.ibm.com' => 'Mike Anderson', # lbdb
@@ -293,4 +300,6 @@
 'andre.landwehr:gmx.net' => 'Andre Landwehr',
 'andre:linux-ide.org' => 'Andre Hedrick',
+'andre:tomt.net' => 'Andre Tomt',
+'andrea:cpushare.com' => 'Andrea Arcangeli',
 'andrea:novell.com' => 'Andrea Arcangeli',
 'andrea:suse.de' => 'Andrea Arcangeli',
@@ -324,12 +333,16 @@
 'aoliva:redhat.com' => 'Alexandre Oliva',
 'ap:cipherica.com' => 'Alex Pankratov',
+'apatard:mandrakesoft.com' => 'Arnaud Patard',
 'apm:brigitte.dna.fi' => 'Antti P. Miettinen',
 'apolkosnik:directvinternet.com' => 'Adam Polkosnik',
 'appro:fy.chalmers.se' => 'Andy Polyakov',
 'apw:shadowen.org' => 'Andy Whitcroft',
+'apw:us.ibm.com' => 'Amos Waterland',
+'aquynh:gmail.com' => 'Nguyen Anh Quynh',
 'aradford:amcc.com' => 'Adam Radford',
 'arashi:yomerashi.yi.org' => 'Matt Reppert',
 'arekm:pld-linux.org' => 'Arkadiusz Miskiewicz', # lbdb
 'arief_m_utama:telkomsel.co.id' => 'Arief Mulya Utama',
+'ariel:blueslice.com' => 'Ariel Rosenblatt',
 'aris:cathedrallabs.org' => 'Aristeu Sergio Rozanski Filho',
 'arjan:fenrus.demon.nl' => 'Arjan van de Ven',
@@ -415,4 +428,5 @@
 'ben:simtec.co.uk' => 'Ben Dooks',
 'bengen:hilluzination.de' => 'Hilko Bengen',
+'benh:au1.ibm.com' => 'Benjamin Herrenschmidt',
 'benh:kenrel.crashing.org' => 'Benjamin Herrenschmidt', # typo
 'benh:kernel.crashing.org' => 'Benjamin Herrenschmidt',
@@ -437,4 +451,5 @@
 'bhavesh:avaya.com' => 'Bhavesh P. Davda',
 'bheilbrun:paypal.com' => 'Brad Heilbrun', # by himself
+'bill.irwin:oracle.com' => 'William Lee Irwin III',
 'bjoern:j3e.de' => 'Bjoern Jacke',
 'bjohnson:sgi.com' => 'Brian J. Johnson',
@@ -457,4 +472,5 @@
 'bo.henriksen:com.rmk.(none)' => 'Bo Henriksen',
 'bo.henriksen:nordicid.com' => 'Bo Henriksen',
+'bob.montgomery:hp.com' => 'Bob Montgomery',
 'bob.picco:hp.com' => 'Bob Picco',
 'bodo.stroesser:fujitsu-siemens.com' => 'Bodo Stroesser',
@@ -468,4 +484,5 @@
 'brad:wasp.net.au' => 'Brad Campbell',
 'brad_mssw:gentoo.org' => 'Brad House',
+'bram.verweij:wanadoo.nl' => 'Bram Verweij',
 'bram:sara.nl' => 'Bram Stolk',
 'braunu:de.ibm.com' => 'Ursula Braun-Krahl',
@@ -475,7 +492,9 @@
 'brewt-linux-kernel:brewt.org' => 'Adrian Yee',
 'brian.haley:hp.com' => 'Brian Haley',
+'brian:murphy.dk' => 'Brian Murphy',
 'brian:rentec.com' => 'Brian Childs',
 'brihall:pcisys.net' => 'Brian Hall', # google
 'brill:fs.math.uni-frankfurt.de' => 'Björn Brill',
+'brix:gentoo.org' => 'Henrik Brix Andersen',
 'brking:us.ibm.com' => 'Brian King',
 'brm:murphy.dk' => 'Brian Murphy',
@@ -484,4 +503,5 @@
 'bryan:staidm.org' => 'Bryan Rittmeyer',
 'bryder:paradise.net.nz' => 'Bill Ryder',
+'bstroesser:fijitsu-siemens.com' => 'Bodo Stroesser', # typo
 'bstroesser:fujitsu-siemens.com' => 'Bodo Stroesser',
 'buffer:antifork.org' => 'Angelo Dell\'Aera',
@@ -502,9 +522,10 @@
 'bzzz:gerasimov.net' => 'Alex Tomas',
 'bzzz:tmi.comex.ru' => 'Alex Tomas',
+'c-d.hailfinger.devel.2005:gmx.net' => 'Carl-Daniel Hailfinger',
 'c-d.hailfinger.kernel.2002-07:gmx.net' => 'Carl-Daniel Hailfinger',
 'c-d.hailfinger.kernel.2002-q4:gmx.net' => 'Carl-Daniel Hailfinger', # himself
 'c-d.hailfinger.kernel.2003:gmx.net' => 'Carl-Daniel Hailfinger', # himself
 'c-d.hailfinger.kernel.2004:gmx.net' => 'Carl-Daniel Hailfinger',
-'c.lucas@com.rmk.(none)' => 'Christophe Lucas',
+'c.lucas:com.rmk.(none)' => 'Christophe Lucas',
 'c.lucas:ifrance.com' => 'Christophe Lucas',
 'cagle:mindspring.com' => 'John Cagle', # Alan
@@ -514,4 +535,5 @@
 'car.busse:gmx.de' => 'Carsten Busse',	# verified by Greg KH
 'carlo:linux.it' => 'Carlo Perassi',
+'carlos.pardo:siliconimage.com' => 'Carlos Pardo',
 'castet.matthieu:free.fr' => 'Matthieu Castet',
 'castor:3pardata.com' => 'Castor Fu',
@@ -527,6 +549,8 @@
 'cbajumpa:or8.net' => 'Chris Bajumpaa',
 'cborntra:de.ibm.com' => 'Christian Bornträger',
+'cbrake:com.rmk.(none)' => 'Cliff Brake',
 'ccaputo:alt.net' => 'Chris Caputo',
 'ccheney:cheney.cx' => 'Christopher L. Cheney',
+'ce:idtect.com' => 'Charles-Edouard Ruault',
 'cel:citi.umich.edu' => 'Chuck Lever',
 'cel:netapp.com' => 'Chuck Lever',
@@ -556,4 +580,5 @@
 'christer:weinigel.se' => 'Christer Weinigel', # from shortlog
 'christian:borntraeger.net' => 'Christian Borntraeger',
+'christian:leber.de' => 'Christian Leber',
 'christoph:graphe.net' => 'Christoph Lameter',
 'christoph:lameter.com' => 'Christoph Lameter',
@@ -568,4 +593,5 @@
 'ckoerner:sysgo.com' => 'Christian Koerner',
 'ckulesa:as.arizona.edu' => 'Craig Kulesa',
+'cl81:gmx.net' => 'Christian Ludwig',
 'clameter:sgi.com' => 'Christoph Lameter',
 'clear.zhang:uli.com.tw' => 'Clear Zhang',
@@ -608,4 +634,5 @@
 'craig:gumstix.com' => 'Craig Hughes',
 'craig:homerjay.homelinux.org' => 'Craig Wilkie',
+'craig:microtron.org.uk' => 'Craig Shelley',
 'cramerj:intel.com' => 'Jeb J. Cramer',
 'crn:netunix.com' => 'Chris Newport',
@@ -657,4 +684,5 @@
 'dave:thedillows.org' => 'David Dillow',
 'davej:codmonkey.org.uk' => 'Dave Jones', # not matched by regexp above
+'davej:delerium.kernelslacker.org' => 'Dave Jones',
 'davej:dhcp83-103.boston.redhat.com' => 'Dave Jones',
 'davej:hardwired.(none)' => 'Dave Jones',
@@ -663,9 +691,7 @@
 'davej:tetrachloride.(none)' => 'Dave Jones',
 'davem:cheetah.(none)' => 'David S. Miller',
-'davem:davemloft.net' => 'David S. Miller',
 'davem:hera.kernel.org' => 'David S. Miller',
 'davem:kernel.bkbits.net' => 'David S. Miller',
 'davem:netfilter.org' => 'David S. Miller',
-'davem:nuts.davemloft.net' => 'David S. Miller',
 'davem:redhat.co' => 'David S. Miller',
 'davem:redhat.com' => 'David S. Miller',
@@ -694,4 +720,5 @@
 'dax:gurulabs.com' => 'Dax Kelson',
 'dbrownell:users.sourceforge.net' => 'David Brownell',
+'dcbw:redhat.com' => 'Dan Williams',
 'dcn:sgi.com' => 'Dean Nelson',
 'ddstreet:ieee.org' => 'Dan Streetman',
@@ -715,6 +742,10 @@
 'devik:cdi.cz' => 'Martin Devera',
 'dfages:arkoon.net' => 'Daniel Fages',
+'dfarnsworth.adm:bkbits.net' => 'Dale Farnsworth', # guessed
+'dfarnsworth:mvista.com' => 'Dale Farnsworth',
 'dfries:mail.win.org' => 'David Fries',
+'dgc:sgi.com' => 'David Chinner',
 'dgibson:samba.org' => 'David Gibson',
+'dgoeddel:trustedcs.com' => 'Darrel Goeddel',
 'dhinds:sonic.net' => 'David Hinds', # google
 'dhollis:davehollis.com' => 'David T. Hollis',
@@ -722,6 +753,9 @@
 'dhowells:redhat.com' => 'David Howells',
 'dhylands:com.rmk.(none)' => 'Dave Hylands',
+'dick:com.rmk.(none)' => 'Dick Hollenbeck',
+'didickman:yahoo.com' => 'Daniel Dickman',
 'diegocg:teleline.es' => 'Diego Calleja García',
 'dignome:gmail.com' => 'Lonnie Mendez',
+'dilinger:debian.org' => 'Andres Salomon',
 'dilinger:mp3revolution.net' => 'Andres Salomon',
 'dilinger:voxel.net' => 'Andres Salomon',
@@ -784,4 +818,5 @@
 'duncan.sands:math.u-psud.fr' => 'Duncan Sands',
 'duncan:sun.com' => 'Duncan Laurie',
+'duraid:octopus.com.au' => 'Duraid Madina',
 'duwe:suse.de' => 'Torsten Duwe',
 'dvhltc:us.ibm.com' => 'Darren Hart',
@@ -835,4 +870,5 @@
 'eli.carter:com.rmk.(none)' => 'Eli Carter',
 'eli.kupermann:intel.com' => 'Eli Kupermann',
+'elueck:de.ibm.com' => 'Einar Lueck',
 'emann:mrv.com' => 'Eran Mann',
 'emcnabb:cs.byu.edu' => 'Evan N. McNabb',
@@ -854,4 +890,5 @@
 'eric.moore:lsil.com' => 'Eric Moore',
 'eric.piel:bull.net' => 'Eric Piel',
+'eric.piel:lifl.fr' => 'Eric Piel',
 'eric.valette:free.fr' => 'Eric Valette',
 'eric:lammerts.org' => 'Eric Lammerts',
@@ -890,4 +927,5 @@
 'felipe_alfaro:linuxmail.org' => 'Felipe Alfaro Solana',
 'felipewd:terra.com.br' => 'Felipe Damasio', # by self (did not ask to include the W.)
+'felix:derklecks.de' => 'Felix Möller',
 'felixb:sgi.com' => 'Felix Blyakher',
 'fello:libero.it' => 'Fabrizio Fellini',
@@ -914,4 +952,5 @@
 'francis.wiran:hp.com' => 'Francis Wiran',
 'frank.a.uepping:t-online.de' => 'Frank A. Uepping',
+'frank.beesley:aeroflex.com' => 'Frank Beesley',
 'frank.cornelis:elis.ugent.be' => 'Frank Cornelis',
 'frank:tuxrocks.com' => 'Frank Sorenson',
@@ -926,4 +965,5 @@
 'fscked:netvisao.pt' => 'Paulo André',
 'fsgqa:sgi.com' => 'Nathan Scott',
+'fthain:telegraphics.com.au' => 'Finn Thain',
 'fubar:us.ibm.com' => 'Jay Vosburgh',
 'fujiwara:linux-m32r.org' => 'Hayato Fujiwara',
@@ -931,5 +971,7 @@
 'fxhuehl:gmx.de' => 'Felix Kuehling',
 'fzago:austin.rr.com' => 'Frank Zago', # google
+'fzago:systemfabricworks.com' => 'Frank Zago',
 'g.liakhovetski:gmx.de' => 'Guennadi Liakhovetski',
+'g.toth:e-biz.lu' => 'Georges Toth',
 'gaa:ulticom.com' => 'Gary Algier', # google
 'gaboregry:axelero.hu' => 'Gabor Egry',
@@ -938,4 +980,5 @@
 'galak:linen.sps.mot.com' => 'Kumar Gala',
 'galak:somerset.sps.mot.com' => 'Kumar Gala',
+'gam3:gam3.net' => 'G. Allen Morris III',
 'gamal:alternex.com.br' => 'Haroldo Gamal',
 'ganadist:nakyup.mizi.com' => 'Cha Young-Ho',
@@ -968,4 +1011,5 @@
 'gibbs:overdrive.btc.adaptec.com' => 'Justin T. Gibbs',
 'gibbs:scsiguy.com' => 'Justin T. Gibbs',
+'gijoe:poczta.onet.pl' => 'Daniel Johnson',
 'gilbertd:treblig.org' => 'Dr. David Alan Gilbert',
 'giorgio:org.rmk.(none)' => 'Giorgio Padrin',
@@ -983,4 +1027,5 @@
 'glynis:butterfly.hjsoft.com' => 'John M. Flinchbaugh',
 'gme:citi.umich.edu' => 'Galen Michael Elias',
+'gmenguez:usuarios.retecal.es' => 'Guillermo Menguez Alvarez',
 'gnb:alphalink.com.au' => 'Greg Banks',
 'gnb:melbourne.sgi.com' => 'Greg Banks',
@@ -995,4 +1040,5 @@
 'gotom:debian.or.jp' => 'Goto Masanori', # from shortlog
 'gphat:cafes.net' => 'Cory Watson',
+'grant_nospam:dodo.com.au' => 'Grant Coady',
 'grantma:anathoth.gen.nz' => 'Matthew Grant',
 'greearb:candelatech.com' => 'Ben Greear',
@@ -1004,4 +1050,5 @@
 'greg_aumann:sil.org' => 'Greg Aumann',
 'gregkh:kernel.bkbits.net' => 'Greg Kroah-Hartman',
+'gregkh:suse.de' => 'Greg Kroah-Hartman',
 'gregor_jan:seznam.cz' => 'Jan Gregor',
 'grigouze:noos.fr' => 'Mickaël Grigouze',
@@ -1014,4 +1061,5 @@
 'gtoumi:laposte.net' => 'Ghozlane Toumi',
 'gtw:cs.bu.edu' => 'Gary Wong',
+'gud:eth.net' => 'Amit Gud',
 'guido.barzini:com.rmk.(none)' => 'Guido Barzini',
 'guillaume.thouvenin:bull.net' => 'Guillaume Thouvenin',
@@ -1030,4 +1078,5 @@
 'hadi:zynx.com' => 'Jamal Hadi Salim',
 'hager:cs.umu.se' => 'Peter Hagervall',
+'hal:realmsys.com' => 'Hal Tolley',
 'hall:vdata.com' => 'Jeff Hall',
 'hallyn:cs.wm.edu' => 'Serge Hallyn',
@@ -1075,4 +1124,5 @@
 'herry:sgi.com' => 'Herry Wiputra',
 'hfvogt:arcor.de' => 'Hans-Frieder Vogt',
+'hfvogt:gmx.net' => 'Hans-Frieder Vogt',
 'hifumi.hisashi:lab.ntt.co.jp' => 'Hisashi Hifumi',
 'hirofumi:mail.parknet.co.jp' => 'Hirofumi Ogawa', # corrected by himself
@@ -1093,8 +1143,10 @@
 'holzheu:de.ibm.com' => 'Michael Holzheu',
 'home:mdiehl.de' => 'Martin Diehl',
+'hong.liu:intel.com' => 'Hong Liu',
 'horms:verge.net.au' => 'Simon Horman',
 'horst.hummel:de.ibm.com' => 'Horst Hummel',
 'hpa:transmeta.com' => 'H. Peter Anvin',
 'hpa:zytor.com' => 'H. Peter Anvin',
+'htejun:gmail.com' => 'Tejun Heo',
 'huangt:star-net.cn' => 'Tao Huang',
 'hugh:com.rmk.(none)' => 'Hugh Dickins',
@@ -1105,4 +1157,5 @@
 'hvr:gnu.org' => 'Herbert V. Riedel',
 'hwahl:hwahl.de' => 'Hartmut Wahl',
+'hwelte:hmw-consulting.de' => 'Harald Welte',
 'hzhong:cisco.com' => 'Hua Zhong',
 'i.palsenberg:jdirmedia.nl' => 'Igmar Palsenberg', # lbdb
@@ -1144,4 +1197,5 @@
 'jackson:realtek.com.tw' => 'Ian Jackson',
 'jacmet:sunsite.dk' => 'Peter Korsgaard',
+'jacques_basson:myrealbox.com' => 'Jacques Basson',
 'jaharkes:cs.cmu.edu' => 'Jan Harkes',
 'jakob.kemi:telia.com' => 'Jakob Kemi',
@@ -1162,4 +1216,5 @@
 'jamie:shareable.org' => 'Jamie Lokier',
 'jan.glauber:de.ibm.com' => 'Jan Glauber',
+'jan.kiszka:web.de' => 'Jan Kiszka',
 'jan.oravec:6com.sk' => 'Jan Oravec',
 'jan:ccsinfo.com' => 'Jan Capek',
@@ -1175,4 +1230,5 @@
 'jason.d.gaston:intel.com' => 'Jason Gaston',
 'jason.davis:unisys.com' => 'Jason Davis',
+'jason:rightthere.net' => 'Jason Davis',
 'jasonuhl:sgi.com' => 'Jason Uhlenkott',
 'jasper:vs19.net' => 'Jasper Spaans',
@@ -1186,8 +1242,10 @@
 'jbaron:redhat.com' => 'Jason Baron',
 'jbglaw:lug-owl.de' => 'Jan-Benedict Glaw',
+'jbj1:ultraemail.net' => 'Jens B. Jorgensen',
 'jblack:linuxguru.net' => 'James Blackwell',
 'jbm:joshisanerd.com' => 'Josh Myer',
 'jbourne:hardrock.org' => 'James Bourne',
 'jcdutton:users.sourceforge.net' => 'James Courtier-Dutton',
+'jchapman:katalix.com' => 'James Chapman',
 'jd:rightthere.net' => 'Jason Davis',
 'jdavid:farfalle.com' => 'David Ruggiero',
@@ -1220,5 +1278,5 @@
 'jejb:jet.(none)' => 'James Bottomley', # wild guess
 'jejb:malley.(none)' => 'James Bottomley',
-'jejb:mulgrave.(none)' => 'James Bottomley', # from shortlog
+'jejb:mulgrave.(none)' => 'James Bottomley',
 'jejb:pashleys.(none)' => 'James Bottomley',
 'jejb:raven.il.steeleye.com' => 'James Bottomley',
@@ -1244,4 +1302,5 @@
 'jgarzik:mandrakesoft.com' => 'Jeff Garzik',
 'jgarzik:pobox.com' => 'Jeff Garzik',
+'jgarzik:pretzel.yyz.us' => 'Jeff Garzik',
 'jgarzik:redhat.com' => 'Jeff Garzik',
 'jgarzik:rum.normnet.org' => 'Jeff Garzik',
@@ -1274,4 +1333,5 @@
 'jimix:watson.ibm.com' => 'Jimi Xenidis',
 'jk:ozlabs.org' => 'Jeremy Kerr',
+'jkacur:rogers.com' => 'John Kacur',
 'jkenisto:us.ibm.com' => 'James Keniston',
 'jkluebs:com.rmk.(none)' => 'John K. Luebs',
@@ -1354,4 +1414,5 @@
 'jsimmons:maxwell.earthlink.net' => 'James Simmons',
 'jsimmons:transvirtual.com' => 'James Simmons',
+'jsimmons:www.infradead.org' => 'James Simmons',
 'jsm:fc.hp.com' => 'John S. Marvin',
 'jsm:udlkern.fc.hp.com' => 'John S. Marvin',
@@ -1425,4 +1486,5 @@
 'keithu:parl.clemson.edu' => 'Keith Underwood',
 'keithw:tungstengraphics.com' => 'Keith Withwell',
+'ken:mvista.com' => 'Kenneth Sumrall',
 'kenn:linux.ie' => 'Kenn Humborg',
 'kenneth.w.chen:intel.com' => 'Kenneth W. Chen',
@@ -1453,8 +1515,10 @@
 'khc:pc.waw.pl' => 'Krzysztof Halasa',
 'khc:pm.waw.pl' => 'Krzysztof Halasa',
+'kianusch:sk-tech.net' => 'Kianusch Sayah Karadji',
 'kieran:mgpenguin.net' => 'Kieran Morrissey',
 'kihara.seiji:lab.ntt.co.jp' => 'Seiji Kihara',
 'kilgota:banach.math.auburn.edu' => 'Theodore Kilgore',
 'killekulla:rdrz.de' => 'Raphael Zimmerer',
+'kimball.murray:stratus.com' => 'Kimball Murray',
 'kingsley:aurema.com' => 'Cheung Kingsley',
 'kiran:in.ibm.com' => 'Ravikiran G. Thirumalai',
@@ -1462,4 +1526,5 @@
 'kishoreak:myw.ltindia.com' => 'Kishore A K',
 'kisza:sch.bme.hu' => 'Andras Kis-Szabo', # google (netfilter-ext HOWTO)
+'kjhall:us.ibm.com' => 'Kylene Hall',
 'kkeil:isdn4linux.de' => 'Karsten Keil',
 'kkeil:suse.de' => 'Karsten Keil',
@@ -1483,4 +1548,5 @@
 'komoriya:paken.org' => 'Takeru Komoriya', # google
 'komujun:nifty.com' => 'Jun Komuro', # google
+'komurojun-mbn:nifty.com' => 'Jun Komuro',
 'kpc-usbdev:gelato.uiuc.edu' => 'Kevin Cernekee',
 'kpfleming:cox.net' => 'Kevin P. Fleming',
@@ -1551,4 +1617,5 @@
 'liam.girdwood:wolfsonmicro.com' => 'Liam Girdwood',
 'libor:topspin.com' => 'Libor Michalek',
+'liml:rtr.ca' => 'Mark Lord',
 'linas:austin.ibm.com' => 'Linas Vepstas',
 'linas:linas.org' => 'Linas Vepstas',
@@ -1566,4 +1633,5 @@
 'linux:de.rmk.(none2)' => 'Sebastian Henschel',
 'linux:dominikbrodowski.de' => 'Dominik Brodowski',
+'linux:dominikbrodowski.net' => 'Dominik Brodowski',
 'linux:hazard.jcu.cz' => 'Jan Marek',
 'linux:kodeaffe.de' => 'Sebastian Henschel',
@@ -1583,4 +1651,5 @@
 'lklm:lengard.net' => 'Pascal Lengard',
 'lkml001:vrfy.org' => 'Kay Sievers',
+'lkml:einar-lueck.de' => 'Einar Lueck',
 'lkml:felipe-alfaro.com' => 'Felipe Alfaro Solana',
 'lkml:lievin.net' => 'Romain Liévin',
@@ -1613,4 +1682,6 @@
 'luca.risolia:studio.unibo.it' => 'Luca Risolia',
 'luca:libero.it' => 'Luca Risolia',
+'lucasvr:gobolinux.org' => 'Lucas Correia Villa Real',
+'lucasvr:org.rmk.(none)' => 'Lucas Correia Villa Real',
 'lucasvr:terra.com.br' => 'Lucas Correia Villa Real', # google
 'luming.yu:intel.com' => 'Luming Yu',
@@ -1627,4 +1698,5 @@
 'm:mbsks.franken.de' => 'Matthias Bruestle',
 'maalanen:ra.abo.fi' => 'Marcus Alanen',
+'maartendeprez:scarlet.be' => 'Maarten Deprez',
 'mac:melware.de' => 'Armin Schindler',
 'macro:ds2.pg.dga.pl' => 'Maciej W. Rozycki',
@@ -1641,4 +1713,5 @@
 'makisara:abies.metla.fi' => 'Kai Mäkisara',
 'makovick:kmlinux.fjfi.cvut.cz' => 'Jindrich Makovicka',
+'mallikarjuna.chilakala:intel.com' => 'Mallikarjuna R. Chilakala',
 'maloi:phota.to' => 'Andy Molloy',
 'malte.d:gmx.net' => 'Malte Doersam', # google
@@ -1657,4 +1730,5 @@
 'marcelo:conectiva.com.br' => 'Marcelo Tosatti',
 'marcelo:dhcp-103.cyclades.de' => 'Marcelo Tosatti',
+'marcelo:dmt.cnet' => 'Marcelo Tosatti',
 'marcelo:dmt.cyclades' => 'Marcelo Tosatti',
 'marcelo:freak.distro.conectiva' => 'Marcelo Tosatti', # guessed
@@ -1701,4 +1775,5 @@
 'mason:suse.com' => 'Chris Mason',
 'master:sectorb.msk.ru' => 'Vladimir B. Savkin',
+'mat.loikkanen:synopsys.com' => 'Mat Loikkanen',
 'mathieu:newview.com' => 'Mathieu Chouquet-Stringer',
 'matt_domsch:dell.com' => 'Matt Domsch', # sent by himself
@@ -1709,4 +1784,5 @@
 'matthias.andree:gmx.de' => 'Matthias Andree', # added by himself
 'matthias.christian:tiscali.de' => 'Matthias-Christian Ott',
+'matthias.kunze:gmx-topmail.de' => 'Matthias Kunze',
 'matthias:net.rmk.(none)' => 'Matthias Burghardt',
 'mauelshagen:redhat.com' => 'Heinz J. Mauelshagen',
@@ -1723,4 +1799,5 @@
 'mbp:sourcefrog.net' => 'Martin Pool',
 'mbp:vexed.ozlabs.hp.com' => 'Martin Pool',
+'mbrancaleoni:tiscali.it' => 'Matteo Brancaleoni',
 'mbroemme:plusserver.de' => 'Maik Broemme',
 'mbuesch:freenet.de' => 'Michael Buesch',
@@ -1755,4 +1832,5 @@
 'mhuth:mvista.com' => 'Mark Huth',
 'mhw:wittsend.com' => 'Michael H. Warfield',
+'micah:navi.cx' => 'Micah Dowty',
 'michael.kerrisk:gmx.net' => 'Michael Kerrisk',
 'michael.krauth:web.de' => 'Michael Krauth',
@@ -1818,4 +1896,5 @@
 'mkrikis:yahoo.com' => 'Martins Krikis',
 'mlachwani:mvista.com' => 'Manish Lachwani',
+'mlafon:arkoon.net' => 'Mathieu Lafon',
 'mlang:delysid.org' => 'Mario Lang', # google
 'mlev:despammed.com' => 'Lev Makhlis',
@@ -1857,5 +1936,7 @@
 'msalter:redhat.com' => 'Mark Salter',
 'msdemlei:cl.uni-heidelberg.de' => 'Markus Demleitner',
+'mshah:teja.com' => 'Mitesh Shah',
 'mst:mellanox.co.il' => 'Michael S. Tsirkin',
+'mstjohns:mindspring.com' => 'Michael StJohns',
 'msw:redhat.com' => 'Matt Wilson',
 'mtk-lkml:gmx.net' => 'Michael Kerrisk',
@@ -1864,4 +1945,5 @@
 'mulix:actcom.co.il' => 'Muli Ben-Yehuda', # sent by himself
 'mulix:mulix.org' => 'Muli Ben-Yehuda',
+'muneda.takahiro:jp.fujitsu.com' => 'Muneda Takahiro',
 'mw:microdata-pos.de' => 'Michael Westermann',
 'my:post.utfors.se' => 'Mikael Ylikoski',
@@ -1869,4 +1951,5 @@
 'mzzhgg:de.rmk.(none)' => 'Lennart Poettering',
 'n0ano:n0ano.com' => 'Don Dugger',
+'n1gp:hotmail.com' => 'Richard Koch',
 'nacc:us.ibm.com' => 'Nishanth Aravamudan',
 'nahshon:actcom.co.il' => 'Itai Nahshon',
@@ -1881,4 +1964,5 @@
 'nboullis:debian.org' => 'Nicolas Boullis',
 'nbryant:optonline.net' => 'Nathan Bryant',
+'ncunningham:cyclades.com' => 'Nigel Cunningham',
 'ncunningham:linuxmail.org' => 'Nigel Cunningham',
 'ncunningham:users.sourceforge.net' => 'Nigel Cunningham',
@@ -1984,4 +2068,5 @@
 'patmans:us.ibm.com' => 'Patrick Mansfield',
 'patrick.boettcher:desy.de' => 'Patrick Boettcher',
+'patrick:bitwizard.nl' => 'Patrick van de Lageweg',
 'patrick:dreker.de' => 'Patrick Dreker', # lbdb
 'patrick:tykepenguin.com' => 'Patrick Caulfield',
@@ -2010,4 +2095,5 @@
 'paulus:tango.paulus.ozlabs.org' => 'Paul Mackerras',
 'pavel (at) ucw.cz' => 'Pavel Machek',
+'pavel:cz.rmk.(none)' => 'Pavel Machek',
 'pavel:janik.cz' => 'Pavel Janík',
 'pavel:suse.cz' => 'Pavel Machek',
@@ -2036,4 +2122,5 @@
 'per.winkvist:telia.com' => 'Per Winkvist',
 'per.winkvist:uk.com' => 'Per Winkvist',
+'perchrh:pvv.org' => 'Per Christian Henden',
 'perex:perex.cz' => 'Jaroslav Kysela',
 'perex:petra.perex-int.cz' => 'Jaroslav Kysela', # guessed
@@ -2047,4 +2134,5 @@
 'peter:chubb.wattle.id.au' => 'Peter Chubb',
 'peter:developers.dk' => 'Peter Christensen',
+'peter:p12n.org' => 'Peter Samuelson',
 'peter:pantasys.com' => 'Peter Buckingham',
 'peter:programming.kicks-ass.net' => 'Peter Zijlstra',
@@ -2085,6 +2173,9 @@
 'piggy:timesys.com' => 'La Monte H.P. Yarroll',
 'pilo.c:wanadoo.fr' => 'Pilo Chambert',
+'pingc:wacom.com' => 'Ping Cheng',
 'pisa:cmp.felk.cvut.cz' => 'Pavel Pisa',
 'pixi:burble.org' => 'Maurice S. Barnum',
+'pj:engr.sgi.com' => 'Paul Jackson',
+'pj:ludd.ltu.se' => 'Peter A. Jonsson',
 'pj:sgi.com' => 'Paul Jackson',
 'pjones:redhat.com' => 'Peter Jones',
@@ -2143,4 +2234,5 @@
 'r.marek:sh.cvut.cz' => 'Rudolf Marek',
 'r.s.bultje:students.uu.nl' => 'Ronald S. Bultje',
+'radford:golemgroup.com' => 'Jim Radford',
 'radford:indigita.com' => 'Jim Radford',
 'rafael.espindola:gmail.com' => 'Rafael Ávila de Espíndola',
@@ -2148,4 +2240,5 @@
 'rainer.weikusat:sncag.com' => 'Rainer Weikusat',
 'raivis:mt.lv' => 'Raivis Bucis',
+'ralf.wildenhues:gmx.de' => 'Ralf Wildenhues',
 'ralf:dea.linux-mips.net' => 'Ralf Bächle',
 'ralf:linux-mips.org' => 'Ralf Bächle',
@@ -2179,4 +2272,5 @@
 'reeja.john:amd.com' => 'Reeja John',
 'reiser:namesys.com' => 'Hans Reiser',
+'relf:os2.ru' => 'Max Alekseyev',
 'rem:osdl.org' => 'Bob Miller',
 'remy.bruno:trinnov.com' => 'Remy Bruno',
@@ -2184,4 +2278,6 @@
 'rene.herman:nl.rmk.(none)' => 'Rene Herman',
 'rene.rebe:gmx.net' => 'Rene Rebe',
+'rene.scharfe:lsrfire.ath.cx' => 'Rene Scharfe',
+'rene:exactcode.de' => 'Rene Rebe',
 'rgcrettol:datacomm.ch' => 'Roger Crettol',
 'rgooch:atnf.csiro.au' => 'Richard Gooch',
@@ -2195,4 +2291,5 @@
 'richard.curnow:superh.com' => 'Richard Curnow',
 'richm:oldelvet.org.uk' => 'Richard Mortimer',
+'richtera:us.ibm.com' => 'Andy Richter',
 'ricklind:us.ibm.com' => 'Rick Lindsley',
 'riel:conectiva.com.br' => 'Rik van Riel',
@@ -2217,4 +2314,5 @@
 'rml:tech9.net' => 'Robert Love',
 'rml:ximian.com' => 'Robert Love',
+'rmps:joel.ist.utl.pt' => 'Rui Saraiva',
 'rnp:paradise.net.nz' => 'Richard Procter',
 'rob:landley.net' => 'Rob Landley',
@@ -2274,4 +2372,5 @@
 'ruber:engr.es' => 'Ruben Garcia',
 'ruby.joker:op.pl' => 'Ruby Joker',
+'rufus-kernel:hackish.org' => 'Peter Nelson',
 'rui.sousa:laposte.net' => 'Rui Sousa',
 'runet:innovsys.com' => 'Rune Torgersen',
@@ -2308,4 +2407,5 @@
 'santiago:newphoenix.net' => 'Santiago A. Nullo', # sent by self
 'santil:us.ibm.com' => 'Santiago Leon',
+'santtu.hyrkko:gmail.com' => 'Santtu Hyrkkö',
 'sarolaht:cs.helsinki.fi' => 'Pasi Sarolahti',
 'sascha:de.rmk.(none)' => 'Sascha Hauer',
@@ -2325,4 +2425,5 @@
 'schwab:suse.de' => 'Andreas Schwab',
 'schwidefsky:de.ibm.com' => 'Martin Schwidefsky',
+'scjody:modernduck.com' => 'Jody McIntyre',
 'scole:zianet.com' => 'Steven Cole', # lk, Alan Cox 20030904
 'scott.bailey:eds.com' => 'Scott Bailey',
@@ -2368,11 +2469,14 @@
 'shaggy:shaggy.austin.ibm.com' => 'Dave Kleikamp', # lbdb
 'shahamit:gmx.net' => 'Amit Shah',
+'shaharf:voltaire.com' => 'Shahar Frank',
 'shai:ftcon.com' => 'Shai Fultheim',
 'shai:scalex86.org' => 'Shai Fultheim',
 'shaoh.li:gmail.com' => 'Li Shaohua',
 'shaohua.li:intel.com' => 'Li Shaohua',
+'shawn.starr:rogers.com' => 'Shawn Starr',
 'shbader:de.ibm.com' => 'Stefan Bader',
 'sheilds:msrl.com' => 'Michael Shields', # typo
 'shemminger:osdl.org' => 'Stephen Hemminger',
+'shenkel:gmail.com' => 'Sven Henkel',
 'shep:alum.mit.edu' => 'Tim Shepard',
 'shields:msrl.com' => 'Michael Shields',
@@ -2392,4 +2496,5 @@
 'simonb:lipsyncpost.co.uk' => 'Simon Burley',
 'sivanich:sgi.com' => 'Dimitri Sivanich',
+'sj-netfilter:cookinglinux.org' => 'Samuel Jean',
 'sjackman:gmail.com' => 'Shaun Jackman',
 'sjean:cookinglinux.org' => 'Samuel Jean',
@@ -2403,4 +2508,5 @@
 'slansky:usa.net' => 'Petr Slansky',
 'sleddog:us.ibm.com' => 'Dave Boutcher',
+'slee:netengine1.com' => 'Soohoon Lee',
 'slpratt:austin.ibm.com' => 'Steven Pratt',
 'sluskyb:paranoiacs.org' => 'Ben Slusky',
@@ -2409,4 +2515,5 @@
 'smurf:osdl.org' => 'Nathan Dabney',
 'smurf:play.smurf.noris.de' => 'Matthias Urlichs',
+'smurf:smurf.noris.de' => 'Matthias Urlichs',
 'snailtalk:linux-mandrake.com' => 'Geoffrey Lee', # by himself
 'sndirsch:suse.de' => 'Stefan Dirsch',
@@ -2444,4 +2551,5 @@
 'sryoungs:au.rmk.(none)' => 'Steve Youngs', # guessed
 'sryoungs:bigpond.net.au' => 'Steve Youngs', # GnuPG key servers
+'ssant:in.ibm.com' => 'Sachin P. Sant',
 'stanley.wang:linux.co.intel.com' => 'Stanley Wang',
 'starvik:axis.com' => 'Mikael Starvik',
@@ -2449,4 +2557,6 @@
 'stefan.eletzhofer:eletztrick.de' => 'Stefan Eletzhofer',
 'stefan.macher:web.de' => 'Stefan Macher',
+'stefan.nickl:kontron.com' => 'Stefan Nickl',
+'stefan:desire.ch' => 'Stefan Ott',
 'steiner:sgi.com' => 'Jack Steiner',
 'stekloff:w-stekloff.beaverton.ibm.com' => 'Daniel Stekloff',
@@ -2467,4 +2577,5 @@
 'stevef:linux-udp14619769uds.austin.ibm.com' => 'Steve French',
 'stevef:linux.local' => 'Steve French', # guessed
+'stevef:smf-t23.(none)' => 'Steve French',
 'stevef:smfhome.smfdom' => 'Steve French',
 'stevef:smfhome.smfsambadom' => 'Steve French',
@@ -2477,4 +2588,5 @@
 'stevef:steveft21.ltcsamba' => 'Steve French',
 'stevel:mvista.com' => 'Steve Longerbeam',
+'steven:brudenell.name' => 'Steven Brudenell',
 'stewart:inverse.wetlogic.net' => 'Paul Stewart',
 'stewart:linux.org.au' => 'Stewart Smith',
@@ -2501,4 +2613,5 @@
 'sv:sw.com.sg' => 'Vladimir Simonov',
 'svm:kozmix.org' => 'Sander van Malssen',
+'svrmgrl:gmx.net' => 'Rainer Kümmerle',
 'swanson:uklinux.net' => 'Alan Swanson',
 'swiergot:intersec.pl' => 'Jaroslaw Swierczynski',
@@ -2520,4 +2633,6 @@
 'takata.hirokazu:renesas.com' => 'Hirokazu Takata',
 'takata:linux-m32r.org' => 'Hirokazu Takata',
+'takata:org.rmk.(none)' => 'Hirokazu Takata',
+'takis:lumumba.luc.ac.be' => 'Panagiotis Issaris',
 'tali:admingilde.org' => 'Martin Waitz',
 'tao:acc.umu.se' => 'David Weinehall', # by himself
@@ -2532,6 +2647,9 @@
 'teanropo:cc.jyu.fi' => 'Tero Roponen',
 'tejohnson:yahoo.com' => 'Todd E. Johnson',
+'telendiz:eircom.net' => 'Telemaque Ndizihiwe',
 'temnota+kernel:kmv.ru' => 'Andrey Melnikov',
 'temnota:kmv.ru' => 'Andrey Melnikov',
+'tero_niemela:yahoo.com' => 'Tero Niemela',
+'terra:gnome.org' => 'Morten Welinder',
 'tes:sgi.com' => 'Timothy Shimmin',
 'tetapi:utu.fi' => 'Tero Pirkkanen', # by Kristian Peters
@@ -2568,4 +2686,5 @@
 'tigran:aivazian.name' => 'Tigran Aivazian',
 'tigran:veritas.com' => 'Tigran Aivazian',
+'tim.bird:am.sony.com' => 'Tim Bird',
 'tim.chick:conexant.com' => 'Tim Chick',
 'tim:cambrant.com' => 'Tim Cambrant', # lbdb
@@ -2576,4 +2695,5 @@
 'tiwai:suse.de' => 'Takashi Iwai',
 'tj:home-tj.org' => 'Tejun Heo',
+'tklauser:nuerscht.ch' => 'Tobias Klauser',
 'tkooda-patch-kernel:devsec.org' => 'Thor Kooda',
 'tlnguyen:snoqualmie.dp.intel.com' => 'Tom L. Nguyen',
@@ -2640,4 +2760,5 @@
 'tytso:think.thunk.org' => "Theodore Y. Ts'o", # guessed
 'tytso:thunk.org' => "Theodore Ts'o",
+'tzachar:cs.bgu.ac.il' => 'Nir Tzachar',
 'u233:shaw.ca' => 'Trent Whaley',
 'uaca:alumni.uv.es' => 'Ulisses Alonso Camaró',
@@ -2656,4 +2777,5 @@
 'valdis.kletnieks:vt.edu' => 'Valdis Kletnieks',
 'valko:linux.karinthy.hu' => 'Laszlo Valko',
+'vandrove:cz.rmk.(none)' => 'Petr Vandrovec',
 'vandrove:vc.cvut.cz' => 'Petr Vandrovec',
 'vanl:megsinet.net' => 'Martin H. VanLeeuwen',
@@ -2664,4 +2786,5 @@
 'vegarwa:online.no' => 'Vegard Wærp',
 'venkatesh.pallipadi:intel.com' => 'Venkatesh Pallipadi',
+'venza:brownhat.org' => 'Daniele Venzano', # by request
 'vernux:us.ibm.com' => 'Vernon Mauery',
 'vesely:gjh.sk' => 'Jozef Vesely',
@@ -2674,4 +2797,5 @@
 'vince:arm.linux.org.uk' => 'Vincent Sanders',
 'vince:kyllikki.org' => 'Vincent Sanders',
+'vince:org.rmk.(none)' => 'Vincent Sanders',
 'vinsci:floss.(none)' => 'Leonard Norrgard',
 'viro:math.psu.edu' => 'Alexander Viro',
@@ -2696,6 +2820,8 @@
 'vs:tribesman.namesys.com' => 'Vladimir Saveliev',
 'vsu:altlinux.ru' => 'Sergey Vlasov',
+'vvs:sw.ru' => 'Vasily Averin',
 'wa:almesberger.net' => 'Werner Almesberger',
 'wahrenbruch:kobil.de' => 'Thomas Wahrenbruch',
+'waite:skycomputers.com' => 'Brian Waite',
 'waltabbyh:comcast.net' => 'Walt Holman',
 'walter.harms:informatik.uni-oldenburg.de' => 'Walter Harms',
@@ -2714,5 +2840,9 @@
 'weihs:linux1394.org' => 'Manfred Weihs',
 'wein:de.ibm.com' => 'Stefan Weinhuber',
+'welinder:anemone.rentec.com' => 'Morten Welinder',
+'welinder:darter.rentec.com' => 'Morten Welinder',
+'welinder:troll.com' => 'Morten Welinder',
 'wellnhofer:aevum.de' => 'Nick Wellnhofer',
+'wendyx:us.ibm.com' => 'Wen Xiong',
 'wensong:linux-vs.org' => 'Wensong Zhang',
 'wenxiong:us.ibm.com' => 'Wen Xiong',
@@ -2762,4 +2892,5 @@
 'yanmin.zhang:intel.com' => 'Yanmin Zhang',
 'yasuyuki.kozakai:toshiba.co.jp' => 'Yasuyuki Kozakai',
+'yekkim:pacbell.net' => 'Mickey Stein',
 'yi.zhu:intel.com' => 'Yi Zhu',
 'yinah:couragetech.com.cn' => 'Yin Aihua',
@@ -2776,7 +2907,9 @@
 'yust:anti-leasure.ru' => 'Alex Yustasov',
 'yuvalt:gmail.com' => 'Yuval Turgeman',
+'zach.brown:oracle.com' => 'Zach Brown',
 'zach:vmware.com' => 'Zachary Amsden',
 'zaitcev:redhat.com' => 'Pete Zaitcev',
 'zaitcev:yahoo.com' => 'Pete Zaitcev',
+'zam:namesys.com' => 'Alexander Zarochentcev',
 'zap:homelink.ru' => 'Andrew Zabolotny',
 'zap:ru.rmk.(none)' => 'Andrew Zabolotny',
@@ -2824,5 +2957,5 @@
     # return result if any
     foreach my $ar (@addrregexps) {
-	if ($in =~ m/$ar->[0]/) {
+	if ($in =~ m/^$ar->[0]$/) {
 	    return $ar->[1];
 	}
@@ -3292,4 +3425,5 @@
     chomp;
     s/^  (\S)/\t$1/;
+    s/^    (\S)/\t$1/;
     # expand all tabs but the first
     $_ = expand($_);
@@ -3311,4 +3445,20 @@
       undef %$log;
       undef $address;
+    } elsif (/^commit /) {
+	# GIT log/revlist entry
+	append_item(%$log, @cur);
+	@cur = ();
+    } elsif (m{^(Author:|author)\s+([^<]*?)\s+<([^>]*)>}) {
+	# GIT author
+	append_item(%$log, @cur); @cur = ();
+	$address = lc($3);
+	$name = $2 ? $2 : rmap_address($address, 1);
+	$author = treat_addr_name($address, $name);
+	$first = 1;
+	$firstpar = 1;
+	print STDERR " GIT-AUTHOR $author\n" if $debug;
+	$namepref = 1;
+    } elsif (/^(Date:|date|tree|parent|committer) /) {
+	# GIT entries to ignore
     } elsif (m{^<([^>]+)>} or m{^ChangeSet@[0-9.]+,\s*[-0-9:+ ]+,\s*(\S+)}) {
       # go figure if a line starts with an address, if so, take it
@@ -3406,5 +3556,5 @@
     foreach my $address (unveil keys %addresses) {
 	foreach my $ar (@addrregexps) {
-	    if ($address =~ m/$ar->[0]/) {
+	    if ($address =~ m/^$ar->[0]$/) {
 		print STDERR "Warning: address '$address'\n";
 		print STDERR "  shadows regexp '$ar->[0]'\n";

