Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263176AbTIVO4O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 10:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263183AbTIVO4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 10:56:13 -0400
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:47337 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S263176AbTIVOzC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 10:55:02 -0400
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: lk-changelog.pl 0.180
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Mon_Sep_22_14_54_58_UTC_2003_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20030922145458.BBF2194048@merlin.emma.line.org>
Date: Mon, 22 Sep 2003 16:54:58 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a semi-automatic announcement.

lk-changelog.pl aka. shortlog version 0.180 has been released.

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
revision 0.180
date: 2003/09/22 14:13:31;  author: vita;  state: Exp;  lines: +12 -1
8 new addresses
----------------------------
revision 0.179
date: 2003/09/19 09:40:52;  author: vita;  state: Exp;  lines: +10 -1
6 new addresses
----------------------------
revision 0.178
date: 2003/09/18 10:55:48;  author: vita;  state: Exp;  lines: +8 -1
4 new addresses
----------------------------
revision 0.177
date: 2003/09/15 13:04:41;  author: vita;  state: Exp;  lines: +12 -1
8 new addresses
----------------------------
revision 0.176
date: 2003/09/11 09:11:48;  author: vita;  state: Exp;  lines: +8 -1
4 new addresses
----------------------------
revision 0.175
date: 2003/09/08 05:31:21;  author: vita;  state: Exp;  lines: +8 -1
4 new addresses
----------------------------
revision 0.174
date: 2003/09/05 05:30:36;  author: vita;  state: Exp;  lines: +10 -1
6 new addresses (from `bk changes` since 2.5.0)
----------------------------
revision 0.173
date: 2003/09/05 02:10:40;  author: emma;  state: Exp;  lines: +19 -3
13 new addresses, courtesy of Alan Cox
----------------------------
revision 0.172
date: 2003/09/04 21:08:20;  author: emma;  state: Exp;  lines: +7 -1
2 new addresses
----------------------------
revision 0.171
date: 2003/09/04 20:55:38;  author: emma;  state: Exp;  lines: +48 -2
11 new addresses.
add --mode=resolve
----------------------------
revision 0.170
date: 2003/09/03 04:31:37;  author: vita;  state: Exp;  lines: +8 -1
4 new addresses
----------------------------
revision 0.169
date: 2003/09/02 05:28:25;  author: vita;  state: Exp;  lines: +7 -1
3 new addresses
----------------------------
revision 0.168
date: 2003/09/01 09:35:59;  author: vita;  state: Exp;  lines: +13 -1
7 new addresses
----------------------------
revision 0.167
date: 2003/08/31 14:08:56;  author: emma;  state: Exp;  lines: +16 -4
ADD: --selftest now checks for non-obfuscated addresses
FIX: 1 address (wasn't obfuscated)
REMOVE: 1 address (didn't contain domain part)
=============================================================================
Index: lk-changelog.pl
===================================================================
RCS file: /var/CVS/lk-changelog/lk-changelog.pl,v
retrieving revision 0.167
retrieving revision 0.180
diff -u -r0.167 -r0.180
--- lk-changelog.pl	31 Aug 2003 14:08:56 -0000	0.167
+++ lk-changelog.pl	22 Sep 2003 14:13:31 -0000	0.180
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.167 2003/08/31 14:08:56 emma Exp $
+# $Id: lk-changelog.pl,v 0.180 2003/09/22 14:13:31 vita Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -122,6 +122,7 @@
 undef @addresses_handled_in_regexp;
 
 my %addresses = (
+'a.wegele:tu-bs.de' => 'Artur Wegele',
 'aaron.baranoff:tsc.tdk.com' => 'Aaron Baranoff',
 'abbotti:mev.co.uk' => 'Ian Abbott',
 'abraham:2d3d.co.za' => 'Abraham van der Merwe',
@@ -131,6 +132,7 @@
 'acher:in.tum.de' => 'Georg Acher',
 'achirica:telefonica.net' => 'Javier Achirica',
 'achirica:ttd.net' => 'Javier Achirica',
+'acme:allegro.kerneljanitors.org' => 'Arnaldo Carvalho de Melo',
 'acme:brinquedo.oo.ps' => 'Arnaldo Carvalho de Melo',
 'acme:conectiva.com.br' => 'Arnaldo Carvalho de Melo',
 'acme:dhcp197.conectiva' => 'Arnaldo Carvalho de Melo',
@@ -138,6 +140,7 @@
 'adam:kroptech.com' => 'Adam Kropelin',
 'adam:mailhost.nmt.edu' => 'Adam Radford', # google
 'adam:nmt.edu' => 'Adam Radford', # google
+'adam:os.inf.tu-dresden.de' => 'Adam Lackorzynski',
 'adam:skullslayer.rod.org' => 'Adam Bernau',
 'adam:yggdrasil.com' => 'Adam J. Richter',
 'adaplas:pol.net' => 'Antonino Daplas',
@@ -156,12 +159,14 @@
 'aia21:cam.ac.uk' => 'Anton Altaparmakov',
 'aia21:cantab.net' => 'Anton Altaparmakov',
 'aia21:cus.cam.ac.uk' => 'Anton Altaparmakov',
+'aia21:drop.stormcorp.org' => 'Anton Altaparmakov', # guessed
 'ajoshi:kernel.crashing.org' => 'Ani Joshi',
 'ajoshi:shell.unixbox.com' => 'Ani Joshi',
 'ak:colin.muc.de' => 'Andi Kleen',
 'ak:muc.de' => 'Andi Kleen',
 'ak:suse.de' => 'Andi Kleen',
 'akpm:digeo.com' => 'Andrew Morton',
+'akpm:org.rmk.(none)' => 'Andrew Morton',
 'akpm:osdl.org' => 'Andrew Morton', # guessed
 'akpm:reardensteel.com' => 'Andrew Morton',
 'akpm:zip.com.au' => 'Andrew Morton',
@@ -172,6 +177,7 @@
 'albert:users.sourceforge.net' => 'Albert Cahalan',
 'albertogli:telpin.com.ar' => 'Alberto Bertogli',
 'alborchers:steinerpoint.com' => 'Al Borchers',
+'alex.williamson:hp.com' => 'Alex Williamson',
 'alex:ssi.bg' => 'Alexander Atanasov',
 'alex_williamson:attbi.com' => 'Alex Williamson', # lbdb
 'alex_williamson:com.rmk.(none)' => 'Alex Williamson',
@@ -182,6 +188,7 @@
 'alexey:technomagesinc.com' => 'Alex Tomas',
 'alext:fc.hp.com' => 'Alex Tsariounov',
 'alfre:ibd.es' => 'Alfredo Sanjuán',
+'aliakc:web.de' => 'Ali Akcaagac', # lbdb
 'ambx1:com.rmk.(none)' => 'Adam Belay',
 'ambx1:neo.rr.com' => 'Adam Belay',
 'amir.noam:intel.com' => 'Amir Noam',
@@ -191,6 +198,7 @@
 'andmike:us.ibm.com' => 'Mike Anderson', # lbdb
 'andre.breiler:null-mx.org' => 'André Breiler',
 'andrea:suse.de' => 'Andrea Arcangeli',
+'andrew.grover:intel.com' => 'Andy Grover', # "Andy" to match former entries
 'andrew.wood:ivarch.com' => 'Andrew Wood',
 'andries.brouwer:cwi.nl' => 'Andries E. Brouwer',
 'andros:citi.umich.edu' => 'Andy Adamson',
@@ -204,6 +212,7 @@
 'aris:cathedrallabs.org' => 'Aristeu Sergio Rozanski Filho',
 'arjan:redhat.com' => 'Arjan van de Ven',
 'arjanv:redhat.com' => 'Arjan van de Ven',
+'armin:melware.de' => 'Armin Schindler',
 'arnaud.quette:mgeups.com' => 'Arnaud Quette',
 'arnd:arndb.de' => 'Arnd Bergmann',
 'arnd:bergmann-dalldorf.de' => 'Arnd Bergmann',
@@ -219,8 +228,10 @@
 'axboe:hera.kernel.org' => 'Jens Axboe',
 'axboe:suse.de' => 'Jens Axboe',
 'azarah:gentoo.org' => 'Martin Schlemmer',
+'aziz:hp.com' => 'Khalid Aziz', # Alan
 'b.zolnierkiewicz:elka.pw.edu.pl' => 'Bartlomiej Zolnierkiewicz',
 'baccala:vger.freesoft.org' => 'Brent Baccala',
+'baldrick:free.fr' => 'Duncan Sands',
 'baldrick:wanadoo.fr' => 'Duncan Sands',
 'ballabio_dario:emc.com' => 'Dario Ballabio',
 'barrow_dj:yahoo.com' => 'D. J. Barrow',
@@ -280,6 +291,7 @@
 'c-d.hailfinger.kernel.2002-07:gmx.net' => 'Carl-Daniel Hailfinger',
 'c-d.hailfinger.kernel.2002-q4:gmx.net' => 'Carl-Daniel Hailfinger', # himself
 'c-d.hailfinger.kernel.2003:gmx.net' => 'Carl-Daniel Hailfinger', # himself
+'cagle:mindspring.com' => 'John Cagle', # Alan
 'calum.mackay:cdmnet.org' => 'Calum Mackay', # lbdb
 'cananian:lesser-magoo.lcs.mit.edu' => 'C. Scott Ananian',
 'cattelan:sgi.com' => 'Russell Cattelan', # google
@@ -293,10 +305,12 @@
 'chad_smith:hp.com' => 'Chad Smith',
 'chadt:sgi.com' => 'Chad Talbott',
 'chan:aleph1.co.uk' => 'Tak-Shing Chan',
+'char:cmf.nrl.navy.mil' => 'Chas Williams', # typo ???
 'charles.white:hp.com' => 'Charles White',
 'chas:cmd.nrl.navy.mil' => 'Chas Williams',
 'chas:cmf.nrl.navy.mil' => 'Chas Williams',
 'chas:locutus.cmf.nrl.navy.mil' => 'Chas Williams',
+'chas:nrl.navy.mil' => 'Chas Williams',
 'chessman:tux.org' => 'Samuel S. Chessman',
 'chip:pobox.com' => 'Chip Salzenberg', # lbdb
 'chris:qwirx.com' => 'Chris Wilson',
@@ -305,6 +319,7 @@
 'christophe:saout.de' => 'Christophe Saout',
 'christopher.leech:intel.com' => 'Christopher Leech',
 'christopher:intel.com' => 'Christopher Goldfarb',
+'chrisw:osdl.org' => 'Chris Wright',
 'chyang:clusterfs.com' => 'Chen Yang',
 'cip307:cip.physik.uni-wuerzburg.de' => 'Jochen Karrer', # from shortlog
 'ckulesa:as.arizona.edu' => 'Craig Kulesa',
@@ -342,20 +357,25 @@
 'dale:farnsworth.org' => 'Dale Farnsworth',
 'dalecki:evision-ventures.com' => 'Martin Dalecki',
 'dalecki:evision.ag' => 'Martin Dalecki',
+'damien.morange:hp.com' => 'Damien Morange',
 'dan.zink:hp.com' => 'Dan Zink',
 'dan:debian.org' => 'Daniel Jacobowitz',
+'dan:reactivated.net' => 'Daniel Drake',
 'dana.lacoste:peregrine.com' => 'Dana Lacoste',
 'danc:mvista.com' => 'Dan Cox', # some CREDITS patch found by google
 'daniel.ritz:ch.rmk.(none)' => 'Daniel Ritz',
 'daniel.ritz:gmx.ch' => 'Daniel Ritz',
+'daniel:deadlock.et.tudelft.nl' => 'Daniël Mantione',
 'daniel:osdl.org' => 'Daniel McNeil',
 'dank:kegel.com' => 'Dan Kegel',
+'dario:emc.com' => 'Dario Ballabio', # Alan Cox
 'dave:qix.net' => 'Dave Maietta',
 'dave:thedillows.org' => 'David Dillow',
 'davej:codemonkey.or' => 'Dave Jones',
 'davej:codemonkey.org.u' => 'Dave Jones',
 'davej:codemonkey.org.uk' => 'Dave Jones',
 'davej:codmonkey.org.uk' => 'Dave Jones',
+'davej:hardwired.(none)' => 'Dave Jones',
 'davej:redhat.com' => 'Dave Jones', # lbdb
 'davej:suse.de' => 'Dave Jones',
 'davej:tetrachloride.(none)' => 'Dave Jones',
@@ -412,6 +432,7 @@
 'driver:huey.jpl.nasa.gov' => 'Bryan B. Whitehead', # google
 'drow:false.org' => 'Daniel Jacobowitz',
 'drow:nevyn.them.org' => 'Daniel Jacobowitz',
+'dsaxena:com.rmk' => 'Deepak Saxena',
 'dsaxena:com.rmk.(none)' => 'Deepak Saxena',
 'dsaxena:mvista.com' => 'Deepak Saxena',
 'dsteklof:us.ibm.com' => 'Daniel E. F. Stekloff',
@@ -442,13 +463,19 @@
 'engebret:brule.rchland.ibm.com' => 'David Engebretsen',
 'engebret:us.ibm.com' => 'David Engebretsen',
 'eranian:frankl.hpl.hp.com' => 'Stéphane Eranian',
+'eranian:hpl.hp.co' => 'Stéphane Eranian', # typo
 'eranian:hpl.hp.com' => 'Stéphane Eranian',
 'eric.piel:bull.net' => 'Eric Piel',
+'eric:lammerts.org' => 'Eric Lammerts',
 'erik:aarg.net' => 'Erik Arneson',
 'erik_habbinga:hp.com' => 'Erik Habbinga',
+'erikj:subway.americas.sgi.com' => 'Erik Jacobson',
+'erlend-a:us.his.no' => 'Erlend Aasland',
+'ernstp:mac.com' => 'Ernst Persson', # lbdb
 'eyal:eyal.emu.id.au' => 'Eyal Lebedinsky', # lbdb
 'faikuygur:ttnet.net.tr' => 'Faik Uygur',
 'falk.hueffner:student.uni-tuebingen.de' => 'Falk Hüffner',
+'fbecker:com.rmk.(none)' => 'Frank Becker',
 'fbl:conectiva.com.br' => 'Flávio Bruno Leitner', # google
 'fcusack:fcusack.com' => 'Frank Cusack',
 'fdavis:si.rr.com' => 'Frank Davis',
@@ -493,12 +520,14 @@
 'gibbs:scsiguy.com' => 'Justin T. Gibbs',
 'gilbertd:treblig.org' => 'Dr. David Alan Gilbert',
 'gj:pointblue.com.pl' => 'Grzegorz Jaskiewicz',
+'gkernel.adm:hostme.bitkeeper.com' => 'Jeff Garzik', # himself
 'gl:dsa-ac.de' => 'Guennadi Liakhovetski',
 'glee:gnupilgrims.org' => 'Geoffrey Lee', # lbdb
 'gnb:alphalink.com.au' => 'Greg Banks',
 'go:turbolinux.co.jp' => 'Go Taniguchi',
 'gone:us.ibm.com' => 'Patricia Gaughen',
 'gorgo:thunderchild.debian.net' => 'Madarasz Gergely',
+'gortmaker:yahoo.com' => 'Paul Gortmaker',
 'gotom:debian.or.jp' => 'Goto Masanori', # from shortlog
 'gphat:cafes.net' => 'Cory Watson',
 'greearb:candelatech.com' => 'Ben Greear',
@@ -514,17 +543,21 @@
 'grundym:us.ibm.com' => 'Michael Grundy',
 'gsromero:alumnos.euitt.upm.es' => 'Guillermo S. Romero',
 'gtoumi:laposte.net' => 'Ghozlane Toumi',
+'guillaume:morinfr.org' => 'Guillaume Morin',
 'gwehrman:sgi.com' => 'Geoffrey Wehrman',
 'hadi:cyberus.ca' => 'Jamal Hadi Salim',
 'hadi:shell.cyberus.ca' => 'Jamal Hadi Salim',
 'hall:vdata.com' => 'Jeff Hall',
+'hammer:adaptec.com' => 'Jack Hammer',
 'hannal:us.ibm.com' => 'Hanna V. Linder',
 'hanno:gmx.de' => 'Hanno Böck',
 'harald:gnumonks.org' => 'Harald Welte',
 'haveblue:us.ibm.com' => 'Dave Hansen',
 'hawkes:oss.sgi.com' => 'John Hawkes',
 'hch:caldera.de' => 'Christoph Hellwig',
+'hch:com.rmk' => 'Christoph Hellwig',
 'hch:com.rmk.(none)' => 'Christoph Hellwig',
+'hch:de.rmk' => 'Christoph Hellwig',
 'hch:de.rmk.(none)' => 'Christoph Hellwig',
 'hch:dhcp212.munich.sgi.com' => 'Christoph Hellwig',
 'hch:hera.kernel.org' => 'Christoph Hellwig',
@@ -536,6 +569,7 @@
 'hch:sgi.com' => 'Christoph Hellwig',
 'heiko.carstens:de.ibm.com' => 'Heiko Carstens',
 'helgaas:fc.hp.com' => 'Bjorn Helgaas', # doesn't want ø/å
+'helgaas:hp.com' => 'Bjorn Helgaas', # guessed
 'henk:god.dyndns.org' => 'Henk Vergonet',
 'henning:meier-geinitz.de' => 'Henning Meier-Geinitz',
 'henrique2.gobbi:cyclades.com' => 'Henrique Gobbi',
@@ -590,6 +624,7 @@
 'jani:astechnix.ro' => 'Jani Monoses',
 'jani:iv.ro' => 'Jani Monoses',
 'janiceg:us.ibm.com' => 'Janice M. Girouard',
+'janitor:sternwelten.at' => 'Maximilian Attems',
 'jasper:vs19.net' => 'Jasper Spaans',
 'javaman:katamail.com' => 'Paulo Ornati',
 'javier:tudela.mad.ttd.net' => 'Javier Achirica',
@@ -668,6 +703,7 @@
 'johnpol:2ka.mipt.ru' => 'Evgeniy Polyakov',
 'johnstul:us.ibm.com' => 'John Stultz',
 'jones:ingate.com' => 'Jones Desougi',
+'joris:struyve.be' => 'Joris Struyve',
 'josh:joshisanerd.com' => 'Josh Myer',
 'jsiemes:web.de' => 'Josef Siemes',
 'jsimmons:heisenberg.transvirtual.com' => 'James Simmons',
@@ -703,6 +739,7 @@
 'kaos:ocs.com.au' => 'Keith Owens',
 'kaos:sgi.com' => 'Keith Owens', # sent by himself
 'kare.sars:lmf.ericsson.se' => 'Kåre Särs',
+'karlis:mt.lv' => 'Karlis Peisenieks',
 'kartik_me:hotmail.com' => 'Kartikey Mahendra Bhatt',
 'kasperd:daimi.au.dk' => 'Kasper Dupont',
 'kaz:earth.email.ne.jp' => 'Kazuto Miyoshi',
@@ -729,8 +766,10 @@
 'kochi:hpc.bs1.fc.nec.co.jp' => 'Kochi Takayoshi',
 'komujun:nifty.com' => 'Jun Komuro', # google
 'kpc-usbdev:gelato.uiuc.edu' => 'Kevin Cernekee',
+'kpfleming:cox.net' => 'Kevin P. Fleming',
 'kraxel:bytesex.org' => 'Gerd Knorr',
 'kraxel:suse.de' => 'Gerd Knorr',
+'krishnakumar:naturesoft.net' => 'Krishna Kumar',
 'krkumar:us.ibm.com' => 'Krishna Kumar',
 'kronos:kronoz.cjb.net' => 'Luca Tettamanti',
 'kuba:mareimbrium.org' => 'Kuba Ober',
@@ -745,14 +784,18 @@
 'laforge:netfilter.org' => 'Harald Welte',
 'latten:austin.ibm.com' => 'Joy Latten',
 'laurent:latil.nom.fr' => 'Laurent Latil',
+'lavarre:iomega.com' => 'Pat LaVarre',
 'lawrence:the-penguin.otak.com' => 'Lawrence Walton',
+'lcapitulino:prefeitura.sp.gov.br' => 'Luiz Capitulino',
 'ldb:ldb.ods.org' => 'Luca Barbieri',
 'ldl:aros.net' => 'Lou Langholtz',
+'ldm.adm:hostme.bitkeeper.com' => 'Patrick Mochel', # self
 'ldm:flatcap.org' => 'Richard Russon',
 'lee:compucrew.com' => 'Lee Nash', # lbdb
 'legoll:free.fr' => 'Vincent Legoll', # correction sent by himself
 'leigh:solinno.co.uk' => 'Leigh Brown', # lbdb
 'len.brown:intel.com' => 'Len Brown',
+'lenb:dhcppc11.' => 'Len Brown',
 'lenb:dhcppc3.' => 'Len Brown',
 'lenb:dhcppc6.' => 'Len Brown',
 'lenehan:twibble.org' => 'Jamie Lenehan',
@@ -760,6 +803,7 @@
 'lethal:unusual.internal.linux-sh.org' => 'Paul Mundt',
 'levon:movementarian.org' => 'John Levon',
 'lfo:polyad.org' => 'Luis F. Ortiz',
+'liam.girdwood:wolfsonmicro.com' => 'Liam Girdwood',
 'linux-usb:gemeinhardt.info' => 'Lars Gemeinhardt',
 'linux:brodo.de' => 'Dominik Brodowski',
 'linux:de.rmk.(none)' => 'Dominik Brodowski',
@@ -778,6 +822,7 @@
 'lord:jen.americas.sgi.com' => 'Stephen Lord',
 'lord:laptop.americas' => 'Stephen Lord',
 'lord:laptop.americas.sgi.com' => 'Stephen Lord',
+'lord:penguin.americas.sgi.com' => 'Stephen Lord',
 'lord:sgi.com' => 'Stephen Lord',
 'louis.zhuang:linux.co.intel.com' => 'Louis Zhuang',
 'louisk:cse.unsw.edu.au' => 'Louis Yu-Kiu Kwan',
@@ -787,10 +832,12 @@
 'lucasvr:terra.com.br' => 'Lucas Correia Villa Real', # google
 'lunz:falooley.org' => 'Jason Lunz',
 'm.c.p:wolk-project.de' => 'Marc-Christian Petersen',
+'m:mbsks.franken.de' => 'Matthias Bruestle',
 'maalanen:ra.abo.fi' => 'Marcus Alanen',
 'mac:melware.de' => 'Armin Schindler',
 'macro:ds2.pg.gda.pl' => 'Maciej W. Rozycki',
 'makisara:abies.metla.fi' => 'Kai Makisara',
+'maloi:phota.to' => 'Andy Molloy',
 'malte.d:gmx.net' => 'Malte Doersam', # google
 'manand:us.ibm.com' => 'Mala Anand',
 'maneesh:in.ibm.com' => 'Maneesh Soni',
@@ -801,6 +848,7 @@
 'marc:mbsi.ca' => 'Marc Boucher',
 'marcel:holtmann.org' => 'Marcel Holtmann', # sent by himself
 'marcelo:conectiva.com.br' => 'Marcelo Tosatti',
+'marcelo.tosatti:cyclades.com.br' => 'Marcelo Tosatti',
 'marcelo:freak.distro.conectiva' => 'Marcelo Tosatti', # guessed
 'marcelo:logos.cnet' => 'Marcelo Tosatti', # guessed
 'marcelo:plucky.distro.conectiva' => 'Marcelo Tosatti',
@@ -826,6 +874,7 @@
 'mathieu:newview.com' => 'Mathieu Chouquet-Stringer',
 'matt_domsch:dell.com' => 'Matt Domsch', # sent by himself
 'matthew:wil.cx' => 'Matthew Wilcox',
+'matthewc:cse.unsw.edu.au' => 'Matthew Chapman',
 'matthewn:snapgear.com' => 'Matthew Natalier',
 'matthias.andree:gmx.de' => 'Matthias Andree', # added by himself
 'mauelshagen:sistina.com' => 'Heinz J. Mauelshagen',
@@ -839,6 +888,7 @@
 'mdharm-usb:one-eyed-alien.net' => 'Matthew Dharm',
 'mdharm:one-eyed-alien.net' => 'Matthew Dharm',
 'mdiehl:mdiehl.de' => 'Martin Diehl',
+'mdomsch:dell.com' => 'Matt Domsch', # lbdb
 'mec:shout.net' => 'Michael Elizabeth Chastain',
 'meissner:suse.de' => 'Marcus Meissner',
 'mgreer:mivsta.com' => 'Mark A. Greer', # typo
@@ -876,7 +926,9 @@
 'mlocke:mvista.com' => 'Montavista Software, Inc.',
 'mmagallo:debian.org' => 'Marcelo E. Magallon',
 'mmcclell:bigfoot.com' => 'Mark McClelland',
+'mochel:bambi.(none)' => 'Patrick Mochel',
 'mochel:geena.pdx.osdl.net' => 'Patrick Mochel',
+'mochel:hera.kernel.org' => 'Patrick Mochel',
 'mochel:osdl.org' => 'Patrick Mochel',
 'mochel:segfault.osdl.org' => 'Patrick Mochel',
 'mochel:segfault.osdlab.org' => 'Patrick Mochel',
@@ -884,8 +936,10 @@
 'mort:wildopensource.com' => 'Martin Hicks',
 'mostrows:speakeasy.net' => 'Michal Ostrowski',
 'mostrows:watson.ibm.com' => 'Michal Ostrowski',
+'moz:compsoc.man.ac.uk' => 'John Levon',
 'mporter:cox.net' => 'Matt Porter',
 'mporter:kernel.crashing.org' => 'Matt Porter',
+'mroos:linux.ee' => 'Meelis Roos',
 'mrr:nexthop.com' => 'Mathew Richardson',
 'msdemlei:cl.uni-heidelberg.de' => 'Markus Demleitner',
 'msw:redhat.com' => 'Matt Wilson',
@@ -905,10 +959,12 @@
 'netfilter:interlinx.bc.ca' => 'Brian J. Murrell',
 'nick.holloway:pyrites.org.uk' => 'Nick Holloway',
 'nico:cam.org' => 'Nicolas Pitre',
+'nico:org.rmk' => 'Nicolas Pitre',
 'nico:org.rmk.(none)' => 'Nicolas Pitre',
 'nicolas.aspert:epfl.ch' => 'Nicolas Aspert',
 'nicolas.mailhot:laposte.net' => 'Nicolas Mailhot',
 'nicolas:dupeux.net' => 'Nicolas Dupeux',
+'nikai:nikai.net' => 'Nicolas Kaiser',
 'niv:us.ibm.com' => 'Nivedita Singhvi',
 'nivedita:w-nivedita.beaverton.ibm.com' => 'Nivedita Singhvi',
 'nkbj:image.dk' => 'Niels Kristian Bech Jensen',
@@ -943,6 +999,7 @@
 'pam.delaney:lsil.com' => 'Pamela Delaney',
 'paschal:rcsis.com' => 'David Paschal',
 'pasky:ucw.cz' => 'Petr Baudis',
+'patch:luckynet.dynu.com' => '"Lightweight Patch Manager"', # lbdb
 'patmans:us.ibm.com' => 'Patrick Mansfield',
 'patrick:dreker.de' => 'Patrick Dreker', # lbdb
 'paubert:iram.es' => 'Gabriel Paubert',
@@ -953,6 +1010,7 @@
 'paulus:au1.ibm.com' => 'Paul Mackerras',
 'paulus:cargo.(none)' => 'Paul Mackerras',
 'paulus:nanango.paulus.ozlabs.org' => 'Paul Mackerras',
+'paulus:quango.(none)' => 'Paul Mackerras', # lk, Alan Cox 20030904
 'paulus:quango.ozlabs.ibm.com' => 'Paul Mackerras',
 'paulus:samba.org' => 'Paul Mackerras',
 'paulus:tango.paulus.ozlabs.org' => 'Paul Mackerras',
@@ -988,6 +1046,8 @@
 'petrides:redhat.com' => 'Ernie Petrides',
 'philipp:void.at' => 'Philipp Friedrich',
 'phillim2:comcast.net' => 'Mike Phillips',
+'piggin:cyberone.com.au' => 'Nick Piggin',
+'pixi:burble.org' => 'Maurice S. Barnum',
 'pkot:linuxnews.pl' => 'Pawel Kot',
 'pkot:ziew.org' => 'Pawel Kot',
 'plars:austin.ibm.com' => 'Paul Larson',
@@ -1000,9 +1060,13 @@
 'ppc64:brule.rchland.ibm.com' => 'Peter Bergner',
 'prom:berlin.ccc.de' => 'Ingo Albrecht',
 'proski:gnu.org' => 'Pavel Roskin',
+'proski:org.rmk' => 'Pavel Roskin',
 'proski:org.rmk.(none)' => 'Pavel Roskin',
+'purna:jcom.home.ne.jp' => 'Yusuf Wilajati Purna',
 'pwaechtler:mac.com' => 'Peter Wächtler',
+'q:kampsax.dtu.dk' => 'Dennis Jørgensen',
 'qboosh:pld.org.pl' => 'Jakub Bogusz',
+'quade:hsnr.de' => 'Jürgen Quade',
 'quinlan:transmeta.com' => 'Daniel Quinlan',
 'quintela:mandrakesoft.com' => 'Juan Quintela',
 'r.a.mercer:blueyonder.co.uk' => 'Adam Mercer',
@@ -1022,6 +1086,7 @@
 'rct:gherkin.frus.com' => 'Bob Tracy',
 'rddunlap:osdl.org' => 'Randy Dunlap',
 'reality:delusion.de' => 'Udo A. Steinberg',
+'redbliss:libero.it' => 'Leopoldo Cerbaro',
 'reeja.john:amd.com' => 'Reeja John',
 'reiser:namesys.com' => 'Hans Reiser',
 'rem:osdl.org' => 'Bob Miller',
@@ -1097,6 +1162,7 @@
 'schoenfr:gaaertner.de' => 'Erik Schoenfelder',
 'schwab:suse.de' => 'Andreas Schwab',
 'schwidefsky:de.ibm.com' => 'Martin Schwidefsky',
+'scole:zianet.com' => 'Steven Cole', # lk, Alan Cox 20030904
 'scott.feldman:intel.com' => 'Scott Feldman',
 'scott_anderson:mvista.com' => 'Scott Anderson',
 'scottm:minion.yyz.somanetworks.com' => 'Scott Murray',
@@ -1104,8 +1170,10 @@
 'sct:redhat.com' => 'Stephen C. Tweedie',
 'sds:epoch.ncsc.mil' => 'Stephen D. Smalley',
 'sds:tislabs.com' => 'Stephen D. Smalley',
+'sean.mcgoogan:superh.com' => 'Sean McGoogan',
 'seanlkml:rogers.com' => 'Sean Estabrooks',
 'sebastian.droege:gmx.de' => 'Sebastian Dröge',
+'set:pobox.com' => 'Paul Thompson',
 'sfbest:us.ibm.com' => 'Steve Best',
 'sfr:canb.auug.org.au' => 'Stephen Rothwell',
 'sfrost:snowman.net' => 'Stephen Frost',
@@ -1159,11 +1227,13 @@
 'steved:redhat.com' => 'Steve Dickson',
 'stevef:linux.local' => 'Steve French', # guessed
 'stevef:smfhome1.austin.rr.com' => 'Steve French',
+'stevef:smfhome2.austin.rr.com' => 'Steve French',
 'stevef:stevef95.austin.ibm.com' => 'Steve French',
 'stevef:steveft21.austin.ibm.com' => 'Steve French',
 'stevef:steveft21.ltcsamba' => 'Steve French',
 'stewart:inverse.wetlogic.net' => 'Paul Stewart',
 'stewart:wetlogic.net' => 'Paul Stewart',
+'stuart_hayes:dell.com' => 'Stuart Hayes',
 'stuartm:connecttech.com' => 'Stuart MacDonald',
 'sullivan:austin.ibm.com' => 'Mike Sullivan',
 'suncobalt.adm:hostme.bitkeeper.com' => 'Tim Hockin', # by Duncan Laurie
@@ -1180,12 +1250,15 @@
 'tao:acc.umu.se' => 'David Weinehall', # by himself
 'tao:kernel.org' => 'David Weinehall', # by himself
 'tapio:iptime.fi' => 'Tapio Laxström',
+'taral:taral.net' => 'Jean-Philippe Sugarbroad', # Muli Ben-Yehuda on lk
 'tausq:debian.org' => 'Randolph Chung',
 'tcallawa:redhat.com' => "Tom 'spot' Callaway",
+'tes:sgi.com' => 'Timothy Shimmin',
 'tetapi:utu.fi' => 'Tero Pirkkanen', # by Kristian Peters
 'tgraf:suug.ch' => 'Thomas Graf',
 'th122948:scl1.sfbay.sun.com' => 'Tim Hockin', # by Duncan Laurie
 'th122948:scl3.sfbay.sun.com' => 'Tim Hockin', # by Duncan Laurie
+'thchou:ali.com.tw' => 'T. H. Chou', # Alan Cox
 'thiel:ksan.de' => 'Florian Thiel', # lbdb
 'thockin:freakshow.cobalt.com' => 'Tim Hockin',
 'thockin:sun.com' => 'Tim Hockin',
@@ -1220,9 +1293,11 @@
 'tvignaud:mandrakesoft.com' => 'Thierry Vignaud',
 'tvrtko:net4u.hr' => 'Tvrtko A. Ursulin',
 'twaugh:redhat.com' => 'Tim Waugh',
+'typhoon.adm:hostme.bitkeeper.com' => 'Dave Dillow', # himself on lk
 'tytso:mit.edu' => "Theodore Y. T'so", # web.mit.edu/tytso/www/home.html
 'tytso:snap.thunk.org' => "Theodore Y. T'so",
 'tytso:think.thunk.org' => "Theodore Y. T'so", # guessed
+'urban.widmark:enlight.net' => 'Urban Widmark',
 'urban:teststation.com' => 'Urban Widmark',
 'uzi:uzix.org' => 'Joshua Uziel',
 'valdis.kletnieks:vt.edu' => 'Valdis Kletnieks',
@@ -1234,6 +1309,7 @@
 'venkatesh.pallipadi:intel.com' => 'Venkatesh Pallipadi',
 'vherva:niksula.hut.fi' => 'Ville Herva',
 'vinay-rc:naturesoft.net' => 'Vinay K. Nallamothu',
+'vinay.nallamothu:gsecone.com' => 'Vinay K. Nallamothu',
 'viro:math.psu.edu' => 'Alexander Viro',
 'viro:parcelfarce.linux.theplanet.co.uk' => 'Alexander Viro',
 'viro:www.linux.org.uk' => 'Alexander Viro',
@@ -1253,6 +1329,7 @@
 'warlord:mit.edu' => 'Derek Atkins',
 'warp:mercury.d2dc.net' => 'Zephaniah E. Hull',
 'wayne:stallion.oz.au' => 'Wayne Piekarski',
+'wcohen:redhat.com' => 'Will Cohen',
 'wd:denx.de' => 'Wolfgang Denk',
 'weigand:immd1.informatik.uni-erlangen.de' => 'Ulrich Weigand',
 'wensong:linux-vs.org' => 'Wensong Zhang',
@@ -1265,6 +1342,7 @@
 'willschm:us.ibm.com' => 'Will Schmidt',
 'willy:debian.org' => 'Matthew Wilcox',
 'willy:fc.hp.com' => 'Matthew Wilcox',
+'willy:org.rmk' => 'Matthew Wilcox',
 'willy:org.rmk.(none)' => 'Matthew Wilcox',
 'willy:w.ods.org' => 'Willy Tarreau',
 'wilsonc:abocom.com.tw' => 'Wilson Chen', # google
@@ -1289,6 +1367,8 @@
 'ysato:users.sourceforge.jp' => 'Yoshinori Sato', # lbdb
 'yuri:acronis.com' => 'Yuri Per', # lbdb
 'zaitcev:redhat.com' => 'Pete Zaitcev',
+'zecke:flint.arm.linux.org.uk' => 'Holger Freyther',
+'zecke:org.rmk.(none)' => 'Holger Freyther',
 'zinx:epicsol.org' => 'Zinx Verituse',
 'zippel:linux-m68k.org' => 'Roman Zippel',
 'zubarev:us.ibm.com' => 'Irene Zubarev', # google
@@ -1375,7 +1455,10 @@
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
@@ -1655,6 +1738,29 @@
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
@@ -1956,6 +2062,46 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.180  2003/09/22 14:13:31  vita
+# 8 new addresses
+#
+# Revision 0.179  2003/09/19 09:40:52  vita
+# 6 new addresses
+#
+# Revision 0.178  2003/09/18 10:55:48  vita
+# 4 new addresses
+#
+# Revision 0.177  2003/09/15 13:04:41  vita
+# 8 new addresses
+#
+# Revision 0.176  2003/09/11 09:11:48  vita
+# 4 new addresses
+#
+# Revision 0.175  2003/09/08 05:31:21  vita
+# 4 new addresses
+#
+# Revision 0.174  2003/09/05 05:30:36  vita
+# 6 new addresses (from `bk changes` since 2.5.0)
+#
+# Revision 0.173  2003/09/05 02:10:40  emma
+# 13 new addresses, courtesy of Alan Cox
+#
+# Revision 0.172  2003/09/04 21:08:20  emma
+# 2 new addresses
+#
+# Revision 0.171  2003/09/04 20:55:38  emma
+# 11 new addresses.
+# add --mode=resolve
+#
+# Revision 0.170  2003/09/03 04:31:37  vita
+# 4 new addresses
+#
+# Revision 0.169  2003/09/02 05:28:25  vita
+# 3 new addresses
+#
+# Revision 0.168  2003/09/01 09:35:59  vita
+# 7 new addresses
+#
 # Revision 0.167  2003/08/31 14:08:56  emma
 # ADD: --selftest now checks for non-obfuscated addresses
 # FIX: 1 address (wasn't obfuscated)
@@ -2596,6 +2742,12 @@
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
 

