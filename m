Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265670AbSKIOdP>; Sat, 9 Nov 2002 09:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265732AbSKIOdP>; Sat, 9 Nov 2002 09:33:15 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:19977 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S265670AbSKIOdJ>; Sat, 9 Nov 2002 09:33:09 -0500
Date: Sat, 9 Nov 2002 15:39:49 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] BK-kernel-tools: update shortlog
Message-ID: <20021109143949.GA17121@merlin.emma.line.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is against the current version of shortlog in
bk://gkernel.bkbits.net/BK-kernel-tools/

It updates shortlog to 0.50, adding more addresses.

# shortlog |  123 ++++++++++++++++++++++++++++++++++++++++++++++---------
# 1 files changed, 104 insertions(+), 19 deletions(-)

diff -u shortlog:0.44 shortlog
--- shortlog:0.44	Sat Nov  9 15:35:12 2002
+++ shortlog	Sat Nov  9 15:24:21 2002
@@ -7,7 +7,7 @@
 #			Marcus Alanen <maalanen@abo.fi>
 #			Tomas Szepe <szepe@pinerecords.com>
 #
-# $Id: lk-changelog.pl,v 0.44 2002/10/04 03:37:51 emma Exp $
+# $Id: lk-changelog.pl,v 0.50 2002/11/09 14:24:21 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -74,6 +74,7 @@
 'achirica@ttd.net' => 'Javier Achirica',
 'acme@brinquedo.oo.ps' => 'Arnaldo Carvalho de Melo',
 'acme@conectiva.com.br' => 'Arnaldo Carvalho de Melo',
+'acme@dhcp197.conectiva' => 'Arnaldo Carvalho de Melo',
 'adam@mailhost.nmt.edu' => 'Adam Radford', # google
 'adam@nmt.edu' => 'Adam Radford', # google
 'adam@yggdrasil.com' => 'Adam J. Richter',
@@ -91,19 +92,23 @@
 'ak@suse.de' => 'Andi Kleen',
 'akpm@digeo.com' => 'Andrew Morton',
 'akpm@zip.com.au' => 'Andrew Morton',
+'akropel1@rochester.rr.com' => 'Adam Kropelin', # lbdb
 'alan@irongate.swansea.linux.org.uk' => 'Alan Cox',
 'alan@lxorguk.ukuu.org.uk' => 'Alan Cox',
 'alan@redhat.com' => 'Alan Cox',
-'alexander.riesen@synopsys.com' => 'Alexander Riesen',
-'alex_williamson@hp.com' => 'Alex Williamson', # google
 'alex_williamson@attbi.com' => 'Alex Williamson', # lbdb
+'alex_williamson@hp.com' => 'Alex Williamson', # google
+'alexander.riesen@synopsys.com' => 'Alexander Riesen',
 'alfre@ibd.es' => 'Alfredo Sanjuán',
+'ambx1@neo.rr.com' => 'Adam Belay',
 'amunoz@vmware.com' => 'Alberto Munoz',
 'andersen@codepoet.org' => 'Erik Andersen',
 'andersg@0x63.nu' => 'Anders Gustafsson',
 'andmike@us.ibm.com' => 'Mike Anderson', # lbdb
 'andrea@suse.de' => 'Andrea Arcangeli',
 'andries.brouwer@cwi.nl' => 'Andries E. Brouwer',
+'andros@citi.umich.edu' => 'Andy Adamson',
+'angus.sawyer@dsl.pipex.com' => 'Angus Sawyer',
 'ankry@green.mif.pg.gda.pl' => 'Andrzej Krzysztofowicz',
 'anton@samba.org' => 'Anton Blanchard',
 'arjan@redhat.com' => 'Arjan van de Ven',
@@ -111,11 +116,14 @@
 'arndb@de.ibm.com' => 'Arnd Bergmann',
 'asit.k.mallick@intel.com' => 'Asit K. Mallick', # by Kristian Peters
 'axboe@burns.home.kernel.dk' => 'Jens Axboe', # guessed
+'axboe@hera.kernel.org' => 'Jens Axboe',
 'axboe@suse.de' => 'Jens Axboe',
 'baccala@vger.freesoft.org' => 'Brent Baccala',
 'barrow_dj@yahoo.com' => 'D. J. Barrow',
+'barryn@pobox.com' => 'Barry K. Nathan', # lbdb
 'bart.de.schuymer@pandora.be' => 'Bart De Schuymer',
 'bcollins@debian.org' => 'Ben Collins',
+'bcrl@bob.home.kvack.org' => 'Benjamin LaHaise',
 'bcrl@redhat.com' => 'Benjamin LaHaise',
 'bcrl@toomuch.toronto.redhat.com' => 'Benjamin LaHaise', # guessed
 'beattie@beattie-home.net' => 'Brian Beattie', # from david.nelson
@@ -125,7 +133,7 @@
 'bhards@bigpond.net.au' => 'Brad Hards',
 'bhavesh@avaya.com' => 'Bhavesh P. Davda',
 'bheilbrun@paypal.com' => 'Brad Heilbrun', # by himself
-'bjorn.andersson@erc.ericsson.se' => 'Bjorn Andersson',
+'bjorn.andersson@erc.ericsson.se' => 'Björn Andersson', # google, guessed ö
 'bjorn.wesen@axis.com' => 'Bjorn Wesen',
 'bjorn_helgaas@hp.com' => 'Bjorn Helgaas',
 'bmatheny@purdue.edu' => 'Blake Matheny', # google
@@ -145,23 +153,26 @@
 'charles.white@hp.com' => 'Charles White',
 'chessman@tux.org' => 'Samuel S. Chessman',
 'chris@wirex.com' => 'Chris Wright',
-'christer@weinigel.se' => 'Christer Weinigel',
+'christer@weinigel.se' => 'Christer Weinigel', # from shortlog
 'christopher.leech@intel.com' => 'Christopher Leech',
-'cip307@cip.physik.uni-wuerzburg.de' => 'Jochen Karrer',
+'cip307@cip.physik.uni-wuerzburg.de' => 'Jochen Karrer', # from shortlog
 'ckulesa@as.arizona.edu' => 'Craig Kulesa',
 'colin@gibbs.dhs.org' => 'Colin Gibbs',
 'colpatch@us.ibm.com' => 'Matthew Dobson',
+'cort@fsmlabs.com' => 'Cort Dougan',
 'cph@zurich.ai.mit.edu' => 'Chris Hanson',
 'cr@sap.com' => 'Christoph Rohland',
 'cruault@724.com' => 'Charles-Edouard Ruault',
 'ctindel@cup.hp.com' => 'Chad N. Tindel',
 'cyeoh@samba.org' => 'Christopher Yeoh',
 'da-x@gmx.net' => 'Dan Aloni',
-'daisy@teetime.dynamic.austin.ibm.com' => 'Daisy Chang',
+'daisy@teetime.dynamic.austin.ibm.com' => 'Daisy Chang', # from shortlog
 'dalecki@evision-ventures.com' => 'Martin Dalecki',
 'dalecki@evision.ag' => 'Martin Dalecki',
+'dan.zink@hp.com' => 'Dan Zink',
 'dan@debian.org' => 'Daniel Jacobowitz',
 'danc@mvista.com' => 'Dan Cox', # some CREDITS patch found by google
+'davej@codemonkey.org.uk' => 'Dave Jones',
 'davej@suse.de' => 'Dave Jones',
 'davem@hera.kernel.org' => 'David S. Miller',
 'davem@nuts.ninka.net' => 'David S. Miller',
@@ -170,19 +181,24 @@
 'david-b@pacbell.net' => 'David Brownell',
 'david.nelson@pobox.com' => 'David Nelson',
 'david@gibson.dropbear.id.au' => 'David Gibson',
+'david_jeffery@adaptec.com' => 'David Jeffery',
 'davidel@xmailserver.org' => 'Davide Libenzi',
 'davidm@hpl.hp.com' => 'David Mosberger',
 'davidm@napali.hpl.hp.com' => 'David Mosberger',
 'davidm@tiger.hpl.hp.com' => 'David Mosberger',
 'davidm@wailua.hpl.hp.com' => 'David Mosberger',
 'davids@youknow.youwant.to' => 'David Schwartz', # google
+'dbrownell@users.sourceforge.net' => 'David Brownell',
+'ddstreet@ieee.org' => 'Dan Streetman',
 'ddstreet@us.ibm.com' => 'Dan Streetman',
 'defouwj@purdue.edu' => 'Jeff DeFouw',
 'dent@cosy.sbg.ac.at' => "Thomas 'Dent' Mirlacher",
 'devel@brodo.de' => 'Dominik Brodowski',
 'devik@cdi.cz' => 'Martin Devera',
 'dgibson@samba.org' => 'David Gibson',
+'dhinds@sonic.net' => 'David Hinds', # google
 'dhowells@redhat.com' => 'David Howells',
+'dipankar@in.ibm.com' => 'Dipankar Sarma',
 'dirk.uffmann@nokia.com' => 'Dirk Uffmann',
 'dledford@aladin.rdu.redhat.com' => 'Doug Ledford',
 'dledford@redhat.com' => 'Doug Ledford',
@@ -195,6 +211,7 @@
 'dwmw2@infradead.org' => 'David Woodhouse',
 'dwmw2@redhat.com' => 'David Woodhouse',
 'dz@cs.unitn.it' => 'Massimo Dal Zotto',
+'ebiederm@xmission.com' => 'Eric Biederman',
 'ebrower@resilience.com' => 'Eric Brower',
 'ebrower@usa.net' => 'Eric Brower',
 'ecd@skynet.be' => 'Eddie C. Dost',
@@ -206,6 +223,7 @@
 'engebret@us.ibm.com' => 'Dave Engebretsen',
 'eranian@hpl.hp.com' => 'Stéphane Eranian',
 'erik_habbinga@hp.com' => 'Erik Habbinga',
+'eyal@eyal.emu.id.au' => 'Eyal Lebedinsky', # lbdb
 'fbl@conectiva.com.br' => 'Flávio Bruno Leitner', # google
 'fdavis@si.rr.com' => 'Frank Davis',
 'felipewd@terra.com.br' => 'Felipe Damasio', # by self (did not ask to include the W.)
@@ -214,11 +232,13 @@
 'fischer@linux-buechse.de' => 'Jürgen E. Fischer',
 'fletch@aracnet.com' => 'Martin J. Bligh',
 'flo@rfc822.org' => 'Florian Lohoff',
-'florian.thiel@gmx.net' => 'Florian Thiel',
+'florian.thiel@gmx.net' => 'Florian Thiel', # from shortlog
 'focht@ess.nec.de' => 'Erich Focht',
 'fokkensr@fokkensr.vertis.nl' => 'Rolf Fokkens',
 'franz.sirl-kernel@lauterbach.com' => 'Franz Sirl',
 'franz.sirl@lauterbach.com' => 'Franz Sirl',
+'fubar@us.ibm.com' => 'Jay Vosburgh',
+'fw@deneb.enyo.de' => 'Florian Weimer', # lbdb
 'fzago@austin.rr.com' => 'Frank Zago', # google
 'ganesh@veritas.com' => 'Ganesh Varadarajan',
 'ganesh@vxindia.veritas.com' => 'Ganesh Varadarajan',
@@ -235,7 +255,7 @@
 'gnb@alphalink.com.au' => 'Greg Banks',
 'go@turbolinux.co.jp' => 'Go Taniguchi',
 'gone@us.ibm.com' => 'Patricia Guaghen',
-'gotom@debian.or.jp' => 'GOTO Masanori',
+'gotom@debian.or.jp' => 'Goto Masanori', # from shortlog
 'gphat@cafes.net' => 'Cory Watson',
 'green@angband.namesys.com' => 'Oleg Drokin',
 'green@namesys.com' => 'Oleg Drokin',
@@ -245,10 +265,11 @@
 'gtoumi@laposte.net' => 'Ghozlane Toumi',
 'hannal@us.ibm.com' => 'Hanna Linder',
 'haveblue@us.ibm.com' => 'Dave Hansen',
-'hch@lst.de' => 'Christoph Hellwig',
 'hch@caldera.de' => 'Christoph Hellwig',
 'hch@dhcp212.munich.sgi.com' => 'Christoph Hellwig',
+'hch@hera.kernel.org' => 'Christoph Hellwig',
 'hch@infradead.org' => 'Christoph Hellwig',
+'hch@lab343.munich.sgi.com' => 'Christoph Hellwig',
 'hch@lst.de' => 'Christoph Hellwig',
 'hch@pentafluge.infradead.org' => 'Christoph Hellwig',
 'hch@sb.bsdonline.org' => 'Christoph Hellwig', # by Kristian Peters
@@ -261,7 +282,9 @@
 'hpa@zytor.com' => 'H. Peter Anvin',
 'hugh@veritas.com' => 'Hugh Dickins',
 'ica2_ts@csv.ica.uni-stuttgart.de' => 'Thiemo Seufer', # google
+'info@usblcd.de' =>  'Adams IT Services',
 'ink@jurassic.park.msu.ru' => 'Ivan Kokshaysky',
+'ink@jurassic.park.msu.ru[rth]' => 'Ivan Kokshaysky',
 'ionut@cs.columbia.edu' => 'Ion Badulescu',
 'ioshadij@hotmail.com' => 'Ishan O. Jayawardena',
 'irohlfs@irohlfs.de' => 'Ingo Rohlfs',
@@ -281,15 +304,19 @@
 'jbglaw@lug-owl.de' => 'Jan-Benedict Glaw',
 'jblack@linuxguru.net' => 'James Blackwell',
 'jdavid@farfalle.com' => 'David Ruggiero',
+'jdike@jdike.wstearns.org' => 'Jeff Dike',
 'jdike@karaya.com' => 'Jeff Dike',
+'jdike@uml.karaya.com' => 'Jeff Dike',
 'jdr@farfalle.com' => 'David Ruggiero',
 'jdthood@yahoo.co.uk' => 'Thomas Hood',
+'jeb.j.cramer@intel.com' => 'Jeb J. Cramer',
 'jeffs@accelent.com' => 'Jeff Sutherland', # lbdb
-'jejb@mulgrave.(none)' => 'James Bottomley',
+'jejb@mulgrave.(none)' => 'James Bottomley', # from shortlog
 'jenna.s.hall@intel.com' => 'Jenna S. Hall', # google
 'jes@trained-monkey.org' => 'Jes Sorensen',
 'jes@wildopensource.com' => 'Jes Sorensen',
 'jgarzik@mandrakesoft.com' => 'Jeff Garzik',
+'jgarzik@redhat.com' => 'Jeff Garzik', # guessed
 'jgarzik@rum.normnet.org' => 'Jeff Garzik',
 'jgarzik@tout.normnet.org' => 'Jeff Garzik',
 'jgrimm@jgrimm.austin.ibm.com' => 'Jon Grimm', # google
@@ -298,6 +325,7 @@
 'jhammer@us.ibm.com' => 'Jack Hammer',
 'jmorris@intercode.com.au' => 'James Morris',
 'jo-lkml@suckfuell.net' => 'Jochen Suckfuell',
+'joe@wavicle.org' => 'Joe Burks',
 'johann.deneux@it.uu.se' => 'Johann Deneux',
 'johannes@erdfelt.com' => 'Johannes Erdfelt',
 'john@deater.net' => 'John Clemens',
@@ -310,6 +338,7 @@
 'jsimmons@transvirtual.com' => 'James Simmons',
 'jt@bougret.hpl.hp.com' => 'Jean Tourrilhes',
 'jt@hpl.hp.com' => 'Jean Tourrilhes',
+'jung-ik.lee@intel.com' => 'J.I. Lee',
 'jwoithe@physics.adelaide.edu.au' => 'Jonathan Woithe',
 'k-suganuma@mvj.biglobe.ne.jp' => 'Kimio Suganuma',
 'k.kasprzak@box43.pl' => 'Karol Kasprzak', # by Kristian Peters
@@ -334,9 +363,11 @@
 'kkeil@suse.de' => 'Karsten Keil',
 'kmsmith@umich.edu' => 'Kendrick M. Smith',
 'knan@mo.himolde.no' => 'Erik Inge Bolsø',
+'komujun@nifty.com' => 'Jun Komuro', # google
 'kraxel@bytesex.org' => 'Gerd Knorr',
 'kraxel@suse.de' => 'Gerd Knorr',
 'kuebelr@email.uc.edu' => 'Robert Kuebel',
+'kuznet@mops.inr.ac.ru' => 'Alexey Kuznetsov',
 'kuznet@ms2.inr.ac.ru' => 'Alexey Kuznetsov',
 'ladis@psi.cz' => 'Ladislav Michl',
 'laforge@gnumonks.org' => 'Harald Welte',
@@ -344,15 +375,19 @@
 'lawrence@the-penguin.otak.com' => 'Lawrence Walton',
 'ldb@ldb.ods.org' => 'Luca Barbieri',
 'ldm@flatcap.org' => 'Richard Russon',
+'leigh@solinno.co.uk' => 'Leigh Brown', # lbdb
 'levon@movementarian.org' => 'John Levon',
+'linux@brodo.de' => 'Dominik Brodowski',
 'lionel.bouton@inet6.fr' => 'Lionel Bouton',
 'lists@mdiehl.de' => 'Martin Diehl',
 'liyang@nerv.cx' => 'Liyang Hu',
 'lm@bitmover.com' => 'Larry McVoy',
 'lord@sgi.com' => 'Stephen Lord',
+'lowekamp@cs.wm.edu' => 'Bruce B. Lowekamp', # lbdb
 'luc.vanoostenryck@easynet.be' => 'Luc Van Oostenryck', # lbdb
 'lucasvr@terra.com.br' => 'Lucas Correia Villa Real', # google
 'maalanen@ra.abo.fi' => 'Marcus Alanen',
+'mac@melware.de' => 'Armin Schindler',
 'macro@ds2.pg.gda.pl' => 'Maciej W. Rozycki',
 'manfred@colorfullife.com' => 'Manfred Spraul',
 'manik@cisco.com' => 'Manik Raina',
@@ -360,9 +395,10 @@
 'marc@mbsi.ca' => 'Marc Boucher',
 'marcel@holtmann.org' => 'Marcel Holtmann', # sent by himself
 'marcelo@conectiva.com.br' => 'Marcelo Tosatti',
-'marcelo@plucky.distro.conectiva' => 'Marcelo Tosatti',
 'marcelo@freak.distro.conectiva' => 'Marcelo Tosatti', # guessed
+'marcelo@plucky.distro.conectiva' => 'Marcelo Tosatti',
 'mark@alpha.dyndns.org' => 'Mark W. McClelland',
+'markh@osdl.org' => 'Mark Haverkamp',
 'martin.bligh@us.ibm.com' => 'Martin J. Bligh',
 'martin@bruli.net' => 'Martin Brulisauer',
 'martin@meltin.net' => 'Martin Schwenke',
@@ -371,13 +407,15 @@
 'matthew@wil.cx' => 'Matthew Wilcox',
 'mauelshagen@sistina.com' => 'Heinz J. Mauelshagen',
 'maxk@qualcomm.com' => 'Maksim Krasnyanskiy',
-'maxk@viper.(none)' => 'Maksim Krasnyanskiy',
+'maxk@viper.(none)' => 'Maksim Krasnyanskiy', # from shortlog
+'mbligh@aracnet.com' => 'Martin J. Bligh',
 'mcp@linux-systeme.de' => 'Marc-Christian Petersen',
 'mdharm-usb@one-eyed-alien.net' => 'Matthew Dharm',
 'mdharm@one-eyed-alien.net' => 'Matthew Dharm',
 'mec@shout.net' => 'Michael Elizabeth Chastain',
-'michal@harddata.com' => 'Michal Jaegermann',
+'mgreer@mvista.com' => 'Mark A. Greer', # lbdb
 'michaelw@foldr.org' => 'Michael Weber', # google
+'michal@harddata.com' => 'Michal Jaegermann',
 'mikep@linuxtr.net' => 'Mike Phillips',
 'mikpe@csd.uu.se' => 'Mikael Pettersson',
 'mikulas@artax.karlin.mff.cuni.cz' => 'Mikulas Patocka',
@@ -386,6 +424,7 @@
 'mingo@elte.hu' => 'Ingo Molnar',
 'mingo@redhat.com' => 'Ingo Molnar',
 'mj@ucw.cz' => 'Martin Mares',
+'mkp@mkp.net' => 'Martin K. Petersen', # lbdb
 'mlang@delysid.org' => 'Mario Lang', # google
 'mlindner@syskonnect.de' => 'Mirko Lindner',
 'mmcclell@bigfoot.com' => 'Mark McClelland',
@@ -397,6 +436,7 @@
 'mufasa@sis.com.tw' => 'Mufasa Yang', # sent by himself
 'mulix@actcom.co.il' => 'Muli Ben-Yehuda', # sent by himself
 'mw@microdata-pos.de' => 'Michael Westermann',
+'n0ano@n0ano.com' => 'Don Dugger',
 'nahshon@actcom.co.il' => 'Itai Nahshon',
 'nathans@sgi.com' => 'Nathan Scott',
 'neilb@cse.unsw.edu.au' => 'Neil Brown',
@@ -405,6 +445,9 @@
 'nicolas.aspert@epfl.ch' => 'Nicolas Aspert',
 'nkbj@image.dk' => 'Niels Kristian Bech Jensen',
 'nmiell@attbi.com' => 'Nicholas Miell',
+'okir@suse.de' => 'Olaf Kirch', # lbdb
+'olaf.dietsche#list.linux-kernel@t-online.de' => 'Olaf Dietsche',
+'olaf.dietsche' => 'Olaf Dietsche',
 'oleg@tv-sign.ru' => 'Oleg Nesterov',
 'olh@suse.de' => 'Olaf Hering',
 'oliendm@us.ibm.com' => 'Dave Olien',
@@ -417,6 +460,7 @@
 'p2@ace.ulyssis.sutdent.kuleuven.ac.be' => 'Peter De Shrijver',
 'p_gortmaker@yahoo.com' => 'Paul Gortmaker',
 'patmans@us.ibm.com' => 'Patrick Mansfield',
+'paul.mundt@timesys.com' => 'Paul Mundt', # google
 'paulkf@microgate.com' => 'Paul Fulghum',
 'paulus@au1.ibm.com' => 'Paul Mackerras',
 'paulus@nanango.paulus.ozlabs.org' => 'Paul Mackerras',
@@ -431,6 +475,7 @@
 'pe1rxq@amsat.org' => 'Jeroen Vreeken',
 'pekon@informatics.muni.cz' => 'Petr Konecny',
 'perex@perex.cz' => 'Jaroslav Kysela',
+'perex@pnote.perex-int.cz' => 'Jaroslav Kysela',
 'perex@suse.cz' => 'Jaroslav Kysela',
 'peter@cadcamlab.org' => 'Peter Samuelson',
 'peter@chubb.wattle.id.au' => 'Peter Chubb',
@@ -447,8 +492,10 @@
 'pwaechtler@mac.com' => 'Peter Wächtler',
 'quinlan@transmeta.com' => 'Daniel Quinlan',
 'quintela@mandrakesoft.com' => 'Juan Quintela',
-'ralf@dea.linux-mips.net' => 'Ralf Baechle',
+'ralf@dea.linux-mips.net' => 'Ralf Bächle',
+'randy.dunlap@verizon.net' => 'Randy Dunlap',
 'ray-lk@madrabbit.org' => 'Ray Lee',
+'rbh00@utsglobal.com' => 'Richard Hitt', # asked him, he prefers Richard
 'rbt@mtlb.co.uk' => 'Robert Cardell',
 'rct@gherkin.frus.com' => 'Bob Tracy',
 'rddunlap@osdl.org' => 'Randy Dunlap',
@@ -469,8 +516,14 @@
 'rml@tech9.net' => 'Robert Love',
 'rob@osinvestor.com' => 'Rob Radez',
 'robert.olsson@data.slu.se' => 'Robert Olsson',
+'rohit.seth@intel.com' => 'Rohit Seth',
 'roland@topspin.com' => 'Roland Dreier',
 'romieu@cogenit.fr' => 'François Romieu',
+'root@viper.(none)' => 'Maxim Krasnyansky',
+'rscott@attbi.com' => 'Rob Scott',
+'rth@are.twiddle.net' => 'Richard Henderson',
+'rth@dot.sfbay.redhat.com' => 'Richard Henderson',
+'rth@splat.sfbay.redhat.com' => 'Richard Henderson',
 'rth@twiddle.net' => 'Richard Henderson',
 'rui.sousa@laposte.net' => 'Rui Sousa',
 'rusty@rustcorp.com.au' => 'Rusty Russell',
@@ -483,7 +536,9 @@
 'samuel.thibault@ens-lyon.fr' => 'Samuel Thibault',
 'sandeen@sgi.com' => 'Eric Sandeen',
 'santiago@newphoenix.net' => 'Santiago A. Nullo', # sent by self
+'sarolaht@cs.helsinki.fi' => 'Pasi Sarolahti',
 'sawa@yamamoto.gr.jp' => 'sawa',
+'schoenfr@gaaertner.de' => 'Erik Schoenfelder',
 'schwab@suse.de' => 'Andreas Schwab',
 'schwidefsky@de.ibm.com' => 'Martin Schwidefsky',
 'scott.feldman@intel.com' => 'Scott Feldman',
@@ -495,6 +550,7 @@
 'sfr@canb.auug.org.au' => 'Stephen Rothwell',
 'shaggy@austin.ibm.com' => 'Dave Kleikamp',
 'shaggy@kleikamp.austin.ibm.com' => 'Dave Kleikamp',
+'shaggy@shaggy.austin.ibm.com' => 'Dave Kleikamp', # lbdb
 'shingchuang@via.com.tw' => 'Shing Chuang',
 'silicon@falcon.sch.bme.hu' => 'Szilárd Pásztor', # google
 'simonb@lipsyncpost.co.uk' => 'Simon Burley',
@@ -503,36 +559,46 @@
 'smurf@osdl.org' => 'Nathan Dabney',
 'snailtalk@linux-mandrake.com' => 'Geoffrey Lee', # by himself
 'solar@openwall.com' => 'Solar Designer',
+'sparker@sun.com' => 'Steven Parker', # by Duncan Laurie
 'spse@secret.org.uk' => 'Simon Evans', # by Kristian Peters
+'sridhar@dyn9-47-18-140.beaverton.ibm.com' => 'Sridhar Samudrala',
 'steiner@sgi.com' => 'Jack Steiner',
 'stelian.pop@fr.alcove.com' => 'Stelian Pop',
 'stern@rowland.harvard.edu' => 'Alan Stern',
 'stern@rowland.org' => 'Alan Stern', # lbdb
 'steve.cameron@hp.com' => 'Stephen Cameron',
+'steve@chygwyn.com' => 'Steven Whitehouse',
 'steve@gw.chygwyn.com' => 'Steven Whitehouse',
+'stevef@smfhome1.austin.rr.com' => 'Steve French',
 'stuartm@connecttech.com' => 'Stuart MacDonald',
 'sullivan@austin.ibm.com' => 'Mike Sullivan',
+'suncobalt.adm@hostme.bitkeeper.com' => 'Tim Hockin', # by Duncan Laurie
 'sunil.saxena@intel.com' => 'Sunil Saxena',
 'swanson@uklinux.net' => 'Alan Swanson',
 'szepe@pinerecords.com' => 'Tomas Szepe',
-'t-kouchi@mvf.biglobe.ne.jp' => 'Takayoshi Koshi',
+'t-kouchi@mvf.biglobe.ne.jp' => 'Takayoshi Kouchi',
 'tai@imasy.or.jp' => 'Taisuke Yamada',
 'taka@valinux.co.jp' => 'Hirokazu Takahashi',
 'tcallawa@redhat.com' => 'Tom Callaway',
 'tetapi@utu.fi' => 'Tero Pirkkanen', # by Kristian Peters
+'th122948@scl1.sfbay.sun.com' => 'Tim Hockin', # by Duncan Laurie
+'th122948@scl3.sfbay.sun.com' => 'Tim Hockin', # by Duncan Laurie
 'thiel@ksan.de' => 'Florian Thiel', # lbdb
 'thockin@freakshow.cobalt.com' => 'Tim Hockin',
 'thockin@sun.com' => 'Tim Hockin',
 'tigran@aivazian.name' => 'Tigran Aivazian',
 'tim@physik3.uni-rostock.de' => 'Tim Schmielau',
+'tmolina@cox.net' => 'Thomas Molina',
 'tomita@cinet.co.jp' => 'Osamu Tomita',
 'tomlins@cam.org' => 'Ed Tomlinson',
+'tony.luck@intel.com' => 'Tony Luck',
 'tony@cantech.net.au' => 'Anthony J. Breeds-Taurima',
 'torvalds@athlon.transmeta.com' => 'Linus Torvalds',
 'torvalds@home.transmeta.com' => 'Linus Torvalds',
+'torvalds@kiwi.transmeta.com' => 'Linus Torvalds',
 'torvalds@penguin.transmeta.com' => 'Linus Torvalds',
+'torvalds@tove.transmeta.com' => 'Linus Torvalds',
 'torvalds@transmeta.com' => 'Linus Torvalds',
-'torvalds@kiwi.transmeta.com' => 'Linus Torvalds',
 'trini@bill-the-cat.bloom.county' => 'Tom Rini',
 'trini@kernel.crashing.org' => 'Tom Rini',
 'trond.myklebust@fys.uio.no' => 'Trond Myklebust',
@@ -542,14 +608,15 @@
 'urban@teststation.com' => 'Urban Widmark',
 'uzi@uzix.org' => 'Joshua Uziel',
 'vandrove@vc.cvut.cz' => 'Petr Vandrovec',
+'venkatesh.pallipadi@intel.com' => 'Venkatesh Pallipadi',
 'viro@math.psu.edu' => 'Alexander Viro',
 'vojta@math.berkeley.edu' => 'Paul Vojta',
 'vojtech@suse.cz' => 'Vojtech Pavlik',
 'vojtech@twilight.ucw.cz' => 'Vojtech Pavlik',
-'vojtechpavlik@bik-gmbh.de' => 'Vojtech Pavlik',
 'vojtech@ucw.cz' => 'Vojtech Pavlik', # added by himself
 'wa@almesberger.net' => 'Werner Almesberger',
 'wes@infosink.com' => 'Wes Schreiner',
+'wg@malloc.de' => 'Wolfram Gloger', # lbdb
 'willy@debian.org' => 'Matthew Wilcox',
 'willy@w.ods.org' => 'Willy Tarreau',
 'wilsonc@abocom.com.tw' => 'Wilson Chen', # google
@@ -890,7 +957,7 @@
       # go figure if a line starts with an address, if so, take it
       # resolve the address to a name if possible
       append_item(%$log, @cur); @cur = ();
-      $address = $1;
+      $address = lc($1);
       $name = rmap_address($address);
       if ($name ne $address) {
 	if ($opt{'abbreviate-names'}) {
@@ -1090,6 +1157,24 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.50  2002/11/09 14:24:21  emma
+# Add comment to Richard Hitt's address.
+#
+# Revision 0.49  2002/11/04 17:13:21  emma
+# Add 4 addresses sent by Duncan Laurie.
+#
+# Revision 0.48  2002/11/04 12:37:38  emma
+# Another four dozen addresses, courtesy of Vitezslav Samel.
+#
+# Revision 0.47  2002/11/04 12:19:17  emma
+# Vitezslav Samel: Merge bugfix to treat addresses with upper-case characters in ChangeSet.
+#
+# Revision 0.46  2002/11/04 11:37:33  emma
+# 7 new addresses.
+#
+# Revision 0.45  2002/11/04 11:26:41  emma
+# 18 new addresses.
+#
 # Revision 0.44  2002/10/04 03:37:51  emma
 # Track BK-kernel-tools changes to Jes Sorensen's name.
 #
-- 
Matthias Andree
