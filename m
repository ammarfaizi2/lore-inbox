Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264690AbTARMkk>; Sat, 18 Jan 2003 07:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264702AbTARMkk>; Sat, 18 Jan 2003 07:40:40 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:55047 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S264690AbTARMkZ>; Sat, 18 Jan 2003 07:40:25 -0500
Date: Sat, 18 Jan 2003 13:49:21 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: BK PATCH: BK-kernel-tools/shortlog (to complement recent lk-changelog.pl update).
Message-ID: <20030118124921.GA3620@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates shortlog to the latest lk-changelog.pl version.

Please apply.

-- 
Matthias Andree

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.33, 2003-01-18 13:46:34+01:00, matthias.andree@gmx.de
  Add more addresses dug out by Vietzslav Samel.

ChangeSet@1.32, 2003-01-13 15:14:33+01:00, matthias.andree@gmx.de
  Another 14 addresses have been dug out by Vitezslav Samel.

ChangeSet@1.31, 2003-01-09 04:40:05+01:00, matthias.andree@gmx.de
  Update to mainstream version 0.64.

ChangeSet@1.30, 2002-11-27 14:54:01-08:00, torvalds@home.transmeta.com
  Remove merge duplication, add Miles Bader and Ralf Baechle


 shortlog |  177 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 173 insertions(+), 4 deletions(-)


diff -Nru a/shortlog b/shortlog
--- a/shortlog	Sat Jan 18 13:47:34 2003
+++ b/shortlog	Sat Jan 18 13:47:34 2003
@@ -6,8 +6,9 @@
 # (C) Copyright 2002 by Matthias Andree <matthias.andree@gmx.de>
 #			Marcus Alanen <maalanen@abo.fi>
 #			Tomas Szepe <szepe@pinerecords.com>
+#			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.54 2002/11/26 23:27:11 emma Exp $
+# $Id: lk-changelog.pl,v 0.66 2003/01/18 12:44:33 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -69,6 +70,7 @@
 # lbdb.
 my %addresses = (
 'abraham@2d3d.co.za' => 'Abraham van der Merwe',
+'abslucio@terra.com.br' => 'Lucio Maciel',
 'ac9410@attbi.com' => 'Albert Cranford',
 'acher@in.tum.de' => 'Georg Acher',
 'achirica@ttd.net' => 'Javier Achirica',
@@ -78,11 +80,14 @@
 'adam@mailhost.nmt.edu' => 'Adam Radford', # google
 'adam@nmt.edu' => 'Adam Radford', # google
 'adam@yggdrasil.com' => 'Adam J. Richter',
+'adaplas@pol.net' => 'Antonino Daplas',
 'adilger@clusterfs.com' => 'Andreas Dilger',
+'aebr@win.tue.nl' => 'Andries E. Brouwer',
 'agrover@acpi3.(none)' => 'Andy Grover',
 'agrover@acpi3.jf.intel.com' => 'Andy Grover', # guessed
 'agrover@dexter.groveronline.com' => 'Andy Grover',
 'agrover@groveronline.com' => 'Andy Grover',
+'agruen@suse.de' => 'Andreas Gruenbacher',
 'ahaas@airmail.net' => 'Art Haas',
 'ahaas@neosoft.com' => 'Art Haas',
 'aia21@cam.ac.uk' => 'Anton Altaparmakov',
@@ -97,6 +102,7 @@
 'alan@irongate.swansea.linux.org.uk' => 'Alan Cox',
 'alan@lxorguk.ukuu.org.uk' => 'Alan Cox',
 'alan@redhat.com' => 'Alan Cox',
+'alex@ssi.bg' => 'Alexander Atanasov',
 'alex_williamson@attbi.com' => 'Alex Williamson', # lbdb
 'alex_williamson@hp.com' => 'Alex Williamson', # google
 'alexander.riesen@synopsys.com' => 'Alexander Riesen',
@@ -112,14 +118,19 @@
 'angus.sawyer@dsl.pipex.com' => 'Angus Sawyer',
 'ankry@green.mif.pg.gda.pl' => 'Andrzej Krzysztofowicz',
 'anton@samba.org' => 'Anton Blanchard',
+'aris@cathedrallabs.org' => 'Aristeu Sergio Rozanski Filho',
 'arjan@redhat.com' => 'Arjan van de Ven',
 'arjanv@redhat.com' => 'Arjan van de Ven',
+'arnd@bergmann-dalldorf.de' => 'Arnd Bergmann',
 'arndb@de.ibm.com' => 'Arnd Bergmann',
+'arun.sharma@intel.com' => 'Arun Sharma',
 'asit.k.mallick@intel.com' => 'Asit K. Mallick', # by Kristian Peters
 'axboe@burns.home.kernel.dk' => 'Jens Axboe', # guessed
 'axboe@hera.kernel.org' => 'Jens Axboe',
 'axboe@suse.de' => 'Jens Axboe',
 'baccala@vger.freesoft.org' => 'Brent Baccala',
+'baldrick@wanadoo.fr' => 'Duncan Sands',
+'ballabio_dario@emc.com' => 'Dario Ballabio',
 'barrow_dj@yahoo.com' => 'D. J. Barrow',
 'barryn@pobox.com' => 'Barry K. Nathan', # lbdb
 'bart.de.schuymer@pandora.be' => 'Bart De Schuymer',
@@ -127,8 +138,10 @@
 'bcrl@bob.home.kvack.org' => 'Benjamin LaHaise',
 'bcrl@redhat.com' => 'Benjamin LaHaise',
 'bcrl@toomuch.toronto.redhat.com' => 'Benjamin LaHaise', # guessed
+'bdschuym@pandora.be' => 'Bart De Schuymer',
 'beattie@beattie-home.net' => 'Brian Beattie', # from david.nelson
 'benh@kernel.crashing.org' => 'Benjamin Herrenschmidt',
+'bero@arklinux.org' => 'Bernhard Rosenkraenzer',
 'bfennema@falcon.csc.calpoly.edu' => 'Ben Fennema',
 'bgerst@didntduck.org' => 'Brian Gerst',
 'bhards@bigpond.net.au' => 'Brad Hards',
@@ -137,10 +150,13 @@
 'bjorn.andersson@erc.ericsson.se' => 'Björn Andersson', # google, guessed ö
 'bjorn.wesen@axis.com' => 'Bjorn Wesen',
 'bjorn_helgaas@hp.com' => 'Bjorn Helgaas',
+'blueflux@koffein.net' => 'Oskar Andreasson',
 'bmatheny@purdue.edu' => 'Blake Matheny', # google
 'borisitk@fortunet.com' => 'Boris Itkis', # by Kristian Peters
+'braam@clusterfs.com' => 'Peter Braam',
 'brett@bad-sports.com' => 'Brett Pemberton',
 'brihall@pcisys.net' => 'Brian Hall', # google
+'brm@murphy.dk' => 'Brian Murphy',
 'brownfld@irridia.com' => 'Ken Brownfield',
 'bunk@fs.tum.de' => 'Adrian Bunk',
 'buytenh@gnu.org' => 'Lennert Buytenhek',
@@ -154,11 +170,15 @@
 'ch@hpl.hp.com' => 'Christopher Hoover', # by Kristian Peters
 'charles.white@hp.com' => 'Charles White',
 'chessman@tux.org' => 'Samuel S. Chessman',
+'chris@qwirx.com' => 'Chris Wilson',
 'chris@wirex.com' => 'Chris Wright',
 'christer@weinigel.se' => 'Christer Weinigel', # from shortlog
 'christopher.leech@intel.com' => 'Christopher Leech',
 'cip307@cip.physik.uni-wuerzburg.de' => 'Jochen Karrer', # from shortlog
 'ckulesa@as.arizona.edu' => 'Craig Kulesa',
+'cloos@jhcloos.com' => 'James H. Cloos Jr.',
+'cminyard@mvista.com' => 'Corey Minyard',
+'cobra@compuserve.com' => 'Kevin Brosius',
 'colin@gibbs.dhs.org' => 'Colin Gibbs',
 'colpatch@us.ibm.com' => 'Matthew Dobson',
 'cort@fsmlabs.com' => 'Cort Dougan',
@@ -166,17 +186,26 @@
 'cr@sap.com' => 'Christoph Rohland',
 'cruault@724.com' => 'Charles-Edouard Ruault',
 'ctindel@cup.hp.com' => 'Chad N. Tindel',
+'cubic@miee.ru' => 'Ruslan U. Zakirov',
 'cyeoh@samba.org' => 'Christopher Yeoh',
 'da-x@gmx.net' => 'Dan Aloni',
 'daisy@teetime.dynamic.austin.ibm.com' => 'Daisy Chang', # from shortlog
+'dale.farnsworth@mvista.com' => 'Dale Farnsworth',
 'dalecki@evision-ventures.com' => 'Martin Dalecki',
 'dalecki@evision.ag' => 'Martin Dalecki',
 'dan.zink@hp.com' => 'Dan Zink',
 'dan@debian.org' => 'Daniel Jacobowitz',
+'dana.lacoste@peregrine.com' => 'Dana Lacoste',
 'danc@mvista.com' => 'Dan Cox', # some CREDITS patch found by google
+'daniel.ritz@gmx.ch' => 'Daniel Ritz',
+'dave@qix.net' => 'Dave Maietta',
+'davej@codemonkey.or' => 'Dave Jones',
+'davej@codemonkey.org.u' => 'Dave Jones',
 'davej@codemonkey.org.uk' => 'Dave Jones',
 'davej@suse.de' => 'Dave Jones',
+'davej@tetrachloride.(none)' => 'Dave Jones',
 'davem@hera.kernel.org' => 'David S. Miller',
+'davem@kernel.bkbits.net' => 'David S. Miller',
 'davem@nuts.ninka.net' => 'David S. Miller',
 'davem@pizda.ninka.net' => 'David S. Miller', # guessed
 'davem@redhat.com' => 'David S. Miller',
@@ -205,14 +234,18 @@
 'dipankar@in.ibm.com' => 'Dipankar Sarma',
 'dirk.uffmann@nokia.com' => 'Dirk Uffmann',
 'dledford@aladin.rdu.redhat.com' => 'Doug Ledford',
+'dledford@dledford.theledfords.org' => 'Doug Ledford',
+'dledford@flossy.devel.redhat.com' => 'Doug Ledford',
 'dledford@redhat.com' => 'Doug Ledford',
 'dmccr@us.ibm.com' => 'Dave McCracken',
 'dok@directfb.org' => 'Denis Oliver Kropp',
 'dougg@torque.net' => 'Douglas Gilbert',
+'drepper@redhat.com' => 'Ulrich Drepper',
 'driver@huey.jpl.nasa.gov' => 'Bryan B. Whitehead', # google
 'drow@false.org' => 'Daniel Jacobowitz',
 'drow@nevyn.them.org' => 'Daniel Jacobowitz',
 'dsaxena@mvista.com' => 'Deepak Saxena',
+'duncan.sands@math.u-psud.fr' => 'Duncan Sands',
 'dwmw2@infradead.org' => 'David Woodhouse',
 'dwmw2@redhat.com' => 'David Woodhouse',
 'dz@cs.unitn.it' => 'Massimo Dal Zotto',
@@ -226,7 +259,9 @@
 'eike@bilbo.math.uni-mannheim.de' => 'Rolf Eike Beer',
 'elenstev@mesatop.com' => 'Steven Cole',
 'engebret@us.ibm.com' => 'Dave Engebretsen',
+'eranian@frankl.hpl.hp.com' => 'Stéphane Eranian',
 'eranian@hpl.hp.com' => 'Stéphane Eranian',
+'erik@aarg.net' => 'Erik Arneson',
 'erik_habbinga@hp.com' => 'Erik Habbinga',
 'eyal@eyal.emu.id.au' => 'Eyal Lebedinsky', # lbdb
 'fbl@conectiva.com.br' => 'Flávio Bruno Leitner', # google
@@ -234,22 +269,29 @@
 'felipewd@terra.com.br' => 'Felipe Damasio', # by self (did not ask to include the W.)
 'fenghua.yu@intel.com' => 'Fenghua Yu', # google
 'fero@sztalker.hu' => 'Bakonyi Ferenc',
+'filip.sneppe@cronos.be' => 'Filip Sneppe',
 'fischer@linux-buechse.de' => 'Jürgen E. Fischer',
 'fletch@aracnet.com' => 'Martin J. Bligh',
 'flo@rfc822.org' => 'Florian Lohoff',
 'florian.thiel@gmx.net' => 'Florian Thiel', # from shortlog
+'fnm@fusion.ukrsat.com' => 'Nick Fedchik',
 'focht@ess.nec.de' => 'Erich Focht',
 'fokkensr@fokkensr.vertis.nl' => 'Rolf Fokkens',
 'franz.sirl-kernel@lauterbach.com' => 'Franz Sirl',
 'franz.sirl@lauterbach.com' => 'Franz Sirl',
+'fscked@netvisao.pt' => 'Paulo André',
 'fubar@us.ibm.com' => 'Jay Vosburgh',
 'fw@deneb.enyo.de' => 'Florian Weimer', # lbdb
 'fzago@austin.rr.com' => 'Frank Zago', # google
+'ganadist@nakyup.mizi.com' => 'Cha Young-Ho',
+'gandalf@wlug.westbo.se' => 'Martin Josefsson',
+'ganesh@tuxtop.vxindia.veritas.com' => 'Ganesh Varadarajan',
 'ganesh@veritas.com' => 'Ganesh Varadarajan',
 'ganesh@vxindia.veritas.com' => 'Ganesh Varadarajan',
 'garloff@suse.de' => 'Kurt Garloff',
 'geert@linux-m68k.org' => 'Geert Uytterhoeven',
 'george@mvista.com' => 'George Anzinger',
+'gerg@moreton.com.au' => 'Greg Ungerer',
 'gerg@snapgear.com' => 'Greg Ungerer',
 'ghoz@sympatico.ca' => 'Ghozlane Toumi',
 'gibbs@overdrive.btc.adaptec.com' => 'Justin T. Gibbs',
@@ -262,12 +304,16 @@
 'gone@us.ibm.com' => 'Patricia Guaghen',
 'gotom@debian.or.jp' => 'Goto Masanori', # from shortlog
 'gphat@cafes.net' => 'Cory Watson',
+'greearb@candelatech.com' => 'Ben Greear',
 'green@angband.namesys.com' => 'Oleg Drokin',
 'green@namesys.com' => 'Oleg Drokin',
 'greg@kroah.com' => 'Greg Kroah-Hartman',
+'gronkin@nerdvana.com' => 'George Ronkin',
 'grundler@cup.hp.com' => 'Grant Grundler',
+'grundym@us.ibm.com' => 'Michael Grundy',
 'gsromero@alumnos.euitt.upm.es' => 'Guillermo S. Romero',
 'gtoumi@laposte.net' => 'Ghozlane Toumi',
+'hadi@cyberus.ca' => 'Jamal Hadi Salim',
 'hannal@us.ibm.com' => 'Hanna Linder',
 'haveblue@us.ibm.com' => 'Dave Hansen',
 'hch@caldera.de' => 'Christoph Hellwig',
@@ -279,7 +325,9 @@
 'hch@pentafluge.infradead.org' => 'Christoph Hellwig',
 'hch@sb.bsdonline.org' => 'Christoph Hellwig', # by Kristian Peters
 'hch@sgi.com' => 'Christoph Hellwig',
-'helgaas@fc.hp.com' => 'Bjørn Helgås', # lbdb + guessed national characters
+'helgaas@fc.hp.com' => 'Bjorn Helgaas', # doesn't want ø/å
+'henning@meier-geinitz.de' => 'Henning Meier-Geinitz',
+'henrique2.gobbi@cyclades.com' => 'Henrique Gobbi',
 'henrique@cyclades.com' => 'Henrique Gobbi',
 'hermes@gibson.dropbear.id.au' => 'David Gibson',
 'hirofumi@mail.parknet.co.jp' => 'Hirofumi Ogawa', # corrected by himself
@@ -289,7 +337,6 @@
 'ica2_ts@csv.ica.uni-stuttgart.de' => 'Thiemo Seufer', # google
 'info@usblcd.de' =>  'Adams IT Services',
 'ink@jurassic.park.msu.ru' => 'Ivan Kokshaysky',
-'ink@jurassic.park.msu.ru[rth]' => 'Ivan Kokshaysky',
 'ionut@cs.columbia.edu' => 'Ion Badulescu',
 'ioshadij@hotmail.com' => 'Ishan O. Jayawardena',
 'irohlfs@irohlfs.de' => 'Ingo Rohlfs',
@@ -301,11 +348,13 @@
 'jamagallon@able.es' => 'J. A. Magallon',
 'james.bottomley@steeleye.com' => 'James Bottomley',
 'james@cobaltmountain.com' => 'James Mayer',
+'james_mcmechan@hotmail.com' => 'James McMechan',
 'jamey.hicks@hp.com' => 'Jamey Hicks',
 'jamey@crl.dec.com' => 'Jamey Hicks',
 'jani@astechnix.ro' => 'Jani Monoses',
 'jani@iv.ro' => 'Jani Monoses',
 'jb@jblache.org' => 'Julien Blache',
+'jbarnes@sgi.com' => 'Jesse Barnes',
 'jbglaw@lug-owl.de' => 'Jan-Benedict Glaw',
 'jblack@linuxguru.net' => 'James Blackwell',
 'jdavid@farfalle.com' => 'David Ruggiero',
@@ -315,53 +364,72 @@
 'jdr@farfalle.com' => 'David Ruggiero',
 'jdthood@yahoo.co.uk' => 'Thomas Hood',
 'jeb.j.cramer@intel.com' => 'Jeb J. Cramer',
+'jeff.wiedemeier@hp.com' => 'Jeff Wiedemeier',
 'jeffs@accelent.com' => 'Jeff Sutherland', # lbdb
 'jejb@mulgrave.(none)' => 'James Bottomley', # from shortlog
+'jejb@raven.il.steeleye.com' => 'James Bottomley',
 'jenna.s.hall@intel.com' => 'Jenna S. Hall', # google
 'jes@trained-monkey.org' => 'Jes Sorensen',
 'jes@wildopensource.com' => 'Jes Sorensen',
 'jgarzik@fokker2.devel.redhat.com' => 'Jeff Garzik',
 'jgarzik@mandrakesoft.com' => 'Jeff Garzik',
+'jgarzik@pobox.com' => 'Jeff Garzik',
 'jgarzik@redhat.com' => 'Jeff Garzik',
 'jgarzik@rum.normnet.org' => 'Jeff Garzik',
 'jgarzik@tout.normnet.org' => 'Jeff Garzik',
+'jgrimm2@us.ibm.com' => 'Jon Grimm',
 'jgrimm@jgrimm.austin.ibm.com' => 'Jon Grimm', # google
 'jgrimm@touki.austin.ibm.com' => 'Jon Grimm', # google
 'jgrimm@touki.qip.austin.ibm.com' => 'Jon Grimm', # google
 'jhammer@us.ibm.com' => 'Jack Hammer',
+'jkt@helius.com' => 'Jack Thomasson',
 'jmorris@intercode.com.au' => 'James Morris',
 'jo-lkml@suckfuell.net' => 'Jochen Suckfuell',
+'jochen@jochen.org' => 'Jochen Hein',
+'jochen@scram.de' => 'Jochen Friedrich',
+'joe@fib011235813.fsnet.co.uk' => 'Joe Thornber',
 'joe@wavicle.org' => 'Joe Burks',
+'joergprante@netcologne.de' => 'Jörg Prante',
 'johann.deneux@it.uu.se' => 'Johann Deneux',
 'johannes@erdfelt.com' => 'Johannes Erdfelt',
 'john@deater.net' => 'John Clemens',
+'john@grabjohn.com' => 'John Bradford',
 'john@larvalstage.com' => 'John Kim',
 'johnpol@2ka.mipt.ru' => 'Evgeniy Polyakov',
 'johnstul@us.ibm.com' => 'John Stultz',
 'jsiemes@web.de' => 'Josef Siemes',
 'jsimmons@heisenberg.transvirtual.com' => 'James Simmons',
+'jsimmons@infradead.org' => 'James Simmons',
+'jsimmons@kozmo.(none)' => 'James Simmons',
 'jsimmons@maxwell.earthlink.net' => 'James Simmons',
 'jsimmons@transvirtual.com' => 'James Simmons',
+'jsm@udlkern.fc.hp.com' => 'John Marvin',
 'jt@bougret.hpl.hp.com' => 'Jean Tourrilhes',
 'jt@hpl.hp.com' => 'Jean Tourrilhes',
+'jtyner@cs.ucr.edu' => 'John Tyner',
 'jun.nakajima@intel.com' => 'Jun Nakajima',
 'jung-ik.lee@intel.com' => 'J.I. Lee',
 'jwoithe@physics.adelaide.edu.au' => 'Jonathan Woithe',
 'k-suganuma@mvj.biglobe.ne.jp' => 'Kimio Suganuma',
 'k.kasprzak@box43.pl' => 'Karol Kasprzak', # by Kristian Peters
 'kaber@trash.net' => 'Patrick McHardy',
+'kadlec@blackhole.kfki.hu' => 'Jozsef Kadlecsik',
 'kai-germaschewski@uiowa.edu' => 'Kai Germaschewski',
 'kai.makisara@kolumbus.fi' => 'Kai Makisara',
 'kai.reichert@udo.edu' => 'Kai Reichert',
 'kai@chaos.tp1.ruhr-uni-bochum.de' => 'Kai Germaschewski',
 'kai@tp1.ruhr-uni-bochum.de' => 'Kai Germaschewski',
+'kala@pinerecords.com' => 'Tomas Szepe',
 'kanoj@vger.kernel.org' => 'Kanoj Sarcar', # sent by Arnaldo Carvalho de Melo
 'kanojsarcar@yahoo.com' => 'Kanoj Sarcar',
 'kaos@ocs.com.au' => 'Keith Owens',
+'kaos@sgi.com' => 'Keith Owens', # sent by himself
 'kasperd@daimi.au.dk' => 'Kasper Dupont',
 'keithu@parl.clemson.edu' => 'Keith Underwood',
 'kenneth.w.chen@intel.com' => 'Kenneth W. Chen',
+'kernel@steeleye.com' => 'Paul Clements',
 'key@austin.ibm.com' => 'Kent Yoder',
+'khaho@koti.soon.fi' => 'Ari Juhani Hämeenaho',
 'khalid@fc.hp.com' => 'Khalid Aziz',
 'khalid_aziz@hp.com' => 'Khalid Aziz',
 'khc@pm.waw.pl' => 'Krzysztof Halasa',
@@ -373,6 +441,9 @@
 'komujun@nifty.com' => 'Jun Komuro', # google
 'kraxel@bytesex.org' => 'Gerd Knorr',
 'kraxel@suse.de' => 'Gerd Knorr',
+'krkumar@us.ibm.com' => 'Krishna Kumar',
+'kronos@kronoz.cjb.net' => 'Luca Tettamanti',
+'kuba@mareimbrium.org' => 'Kuba Ober',
 'kuebelr@email.uc.edu' => 'Robert Kuebel',
 'kuznet@mops.inr.ac.ru' => 'Alexey Kuznetsov',
 'kuznet@ms2.inr.ac.ru' => 'Alexey Kuznetsov',
@@ -386,6 +457,7 @@
 'leigh@solinno.co.uk' => 'Leigh Brown', # lbdb
 'levon@movementarian.org' => 'John Levon',
 'linux@brodo.de' => 'Dominik Brodowski',
+'linux@hazard.jcu.cz' => 'Jan Marek',
 'lionel.bouton@inet6.fr' => 'Lionel Bouton',
 'lists@mdiehl.de' => 'Martin Diehl',
 'liyang@nerv.cx' => 'Liyang Hu',
@@ -394,9 +466,11 @@
 'lowekamp@cs.wm.edu' => 'Bruce B. Lowekamp', # lbdb
 'luc.vanoostenryck@easynet.be' => 'Luc Van Oostenryck', # lbdb
 'lucasvr@terra.com.br' => 'Lucas Correia Villa Real', # google
+'m.c.p@wolk-project.de' => 'Marc-Christian Petersen',
 'maalanen@ra.abo.fi' => 'Marcus Alanen',
 'mac@melware.de' => 'Armin Schindler',
 'macro@ds2.pg.gda.pl' => 'Maciej W. Rozycki',
+'maneesh@in.ibm.com' => 'Maneesh Soni',
 'manfred@colorfullife.com' => 'Manfred Spraul',
 'manik@cisco.com' => 'Manik Raina',
 'mannthey@us.ibm.com' => 'Keith Mannthey',
@@ -405,7 +479,10 @@
 'marcelo@conectiva.com.br' => 'Marcelo Tosatti',
 'marcelo@freak.distro.conectiva' => 'Marcelo Tosatti', # guessed
 'marcelo@plucky.distro.conectiva' => 'Marcelo Tosatti',
+'marcus@ingate.com' => 'Marcus Sundberg',
+'marekm@amelek.gda.pl' => 'Marek Michalkiewicz',
 'mark@alpha.dyndns.org' => 'Mark W. McClelland',
+'mark@hal9000.dyndns.org' => 'Mark W. McClelland',
 'markh@osdl.org' => 'Mark Haverkamp',
 'martin.bligh@us.ibm.com' => 'Martin J. Bligh',
 'martin@bruli.net' => 'Martin Brulisauer',
@@ -416,6 +493,7 @@
 'mauelshagen@sistina.com' => 'Heinz J. Mauelshagen',
 'maxk@qualcomm.com' => 'Maksim Krasnyanskiy',
 'maxk@viper.(none)' => 'Maksim Krasnyanskiy', # from shortlog
+'maxk@viper.qualcomm.com' => 'Maksim Krasnyanskiy',
 'mbligh@aracnet.com' => 'Martin J. Bligh',
 'mcp@linux-systeme.de' => 'Marc-Christian Petersen',
 'mdharm-scsi@one-eyed-alien.net' => 'Matthew Dharm',
@@ -425,11 +503,14 @@
 'mgreer@mvista.com' => 'Mark A. Greer', # lbdb
 'michaelw@foldr.org' => 'Michael Weber', # google
 'michal@harddata.com' => 'Michal Jaegermann',
+'mikal@stillhq.com' => 'Michael Still',
+'mikael.starvik@axis.com' => 'Mikael Starvik',
 'mikep@linuxtr.net' => 'Mike Phillips',
 'mikpe@csd.uu.se' => 'Mikael Pettersson',
 'mikulas@artax.karlin.mff.cuni.cz' => 'Mikulas Patocka',
 'miles@lsi.nec.co.jp' => 'Miles Bader',
 'miles@megapathdsl.net' => 'Miles Lane',
+'milli@acmeps.com' => 'Michael Milligan',
 'miltonm@bga.com' => 'Milton Miller', # by Kristian Peters
 'mingo@elte.hu' => 'Ingo Molnar',
 'mingo@redhat.com' => 'Ingo Molnar',
@@ -437,24 +518,31 @@
 'mkp@mkp.net' => 'Martin K. Petersen', # lbdb
 'mlang@delysid.org' => 'Mario Lang', # google
 'mlindner@syskonnect.de' => 'Mirko Lindner',
+'mlocke@mvista.com' => 'Montavista Software, Inc.',
 'mmcclell@bigfoot.com' => 'Mark McClelland',
 'mochel@geena.pdx.osdl.net' => 'Patrick Mochel',
 'mochel@osdl.org' => 'Patrick Mochel',
 'mochel@segfault.osdl.org' => 'Patrick Mochel',
 'mostrows@speakeasy.net' => 'Michal Ostrowski',
+'mporter@cox.net' => 'Matt Porter',
 'msw@redhat.com' => 'Matt Wilson',
 'mufasa@sis.com.tw' => 'Mufasa Yang', # sent by himself
 'mulix@actcom.co.il' => 'Muli Ben-Yehuda', # sent by himself
+'mulix@mulix.org' => 'Muli Ben-Yehuda',
 'mw@microdata-pos.de' => 'Michael Westermann',
+'mzyngier@freesurf.fr' => 'Marc Zyngier',
 'n0ano@n0ano.com' => 'Don Dugger',
 'nahshon@actcom.co.il' => 'Itai Nahshon',
 'nathans@sgi.com' => 'Nathan Scott',
 'neilb@cse.unsw.edu.au' => 'Neil Brown',
 'nemosoft@smcc.demon.nl' => 'Nemosoft Unv.',
+'netfilter@interlinx.bc.ca' => 'Brian J. Murrell',
 'nico@cam.org' => 'Nicolas Pitre',
 'nicolas.aspert@epfl.ch' => 'Nicolas Aspert',
+'nicolas.mailhot@laposte.net' => 'Nicolas Mailhot',
 'nkbj@image.dk' => 'Niels Kristian Bech Jensen',
 'nmiell@attbi.com' => 'Nicholas Miell',
+'nobita@t-online.de' => 'Andreas Busch',
 'okir@suse.de' => 'Olaf Kirch', # lbdb
 'olaf.dietsche#list.linux-kernel@t-online.de' => 'Olaf Dietsche',
 'olaf.dietsche' => 'Olaf Dietsche',
@@ -464,12 +552,16 @@
 'oliver.neukum@lrz.uni-muenchen.de' => 'Oliver Neukum',
 'oliver@neukum.name' => 'Oliver Neukum',
 'oliver@neukum.org' => 'Oliver Neukum',
+'oliver@oenone.homelinux.org' => 'Oliver Neukum',
 'orjan.friberg@axis.com' => 'Orjan Friberg',
 'os@emlix.com' => 'Oskar Schirmer', # sent by himself
+'osst@riede.org' => 'Willem Riede',
 'otaylor@redhat.com' => 'Owen Taylor',
 'p2@ace.ulyssis.sutdent.kuleuven.ac.be' => 'Peter De Shrijver',
 'p_gortmaker@yahoo.com' => 'Paul Gortmaker',
+'pasky@ucw.cz' => 'Petr Baudis',
 'patmans@us.ibm.com' => 'Patrick Mansfield',
+'paubert@iram.es' => 'Gabriel Paubert',
 'paul.mundt@timesys.com' => 'Paul Mundt', # google
 'paulkf@microgate.com' => 'Paul Fulghum',
 'paulus@au1.ibm.com' => 'Paul Mackerras',
@@ -491,12 +583,19 @@
 'peter@chubb.wattle.id.au' => 'Peter Chubb',
 'peterc@gelato.unsw.edu.au' => 'Peter Chubb',
 'petero2@telia.com' => 'Peter Osterlund',
+'petkan@mastika.dce.bg' => 'Petko Manolov',
+'petkan@rakia.dce.bg' => 'Petko Manolov',
+'petkan@rakia.hell.org' => 'Petko Manolov',
+'petkan@tequila.dce.bg' => 'Petko Manolov',
 'petkan@users.sourceforge.net' => 'Petko Manolov',
 'petr@vandrovec.name' => 'Petr Vandrovec',
 'petri.koistinen@iki.fi' => 'Petri Koistinen',
+'phillim2@comcast.net' => 'Mike Phillips',
 'pkot@linuxnews.pl' => 'Pawel Kot',
 'plars@austin.ibm.com' => 'Paul Larson',
+'plcl@telefonica.net' => 'Pedro Lopez-Cabanillas',
 'pmenage@ensim.com' => 'Paul Menage',
+'porter@cox.net' => 'Matt Porter',
 'prom@berlin.ccc.de' => 'Ingo Albrecht',
 'proski@gnu.org' => 'Pavel Roskin',
 'pwaechtler@mac.com' => 'Peter Wächtler',
@@ -505,6 +604,7 @@
 'r.e.wolff@bitwizard.nl' => 'Rogier Wolff', # lbdbq
 'ralf@dea.linux-mips.net' => 'Ralf Bächle',
 'ralf@linux-mips.org' => 'Ralf Bächle',
+'ramune@net-ronin.org' => 'Daniel A. Nobuto',
 'randy.dunlap@verizon.net' => 'Randy Dunlap',
 'ray-lk@madrabbit.org' => 'Ray Lee',
 'rbh00@utsglobal.com' => 'Richard Hitt', # asked him, he prefers Richard
@@ -521,6 +621,7 @@
 'rhw@infradead.org' => 'Riley Williams',
 'richard.brunner@amd.com' => 'Richard Brunner',
 'riel@conectiva.com.br' => 'Rik van Riel',
+'rjweryk@uwo.ca' => 'Rob Weryk',
 'rl@hellgate.ch' => 'Roger Luethi',
 'rlievin@free.fr' => 'Romain Lievin',
 'rmk@arm.linux.org.uk' => 'Russell King',
@@ -529,18 +630,24 @@
 'rob@osinvestor.com' => 'Rob Radez',
 'robert.olsson@data.slu.se' => 'Robert Olsson',
 'rohit.seth@intel.com' => 'Rohit Seth',
+'rol@as2917.net' => 'Paul Rolland',
+'roland@redhat.com' => 'Roland McGrath',
 'roland@topspin.com' => 'Roland Dreier',
 'romieu@cogenit.fr' => 'François Romieu',
+'romieu@fr.zoreil.com' => 'François Romieu',
 'root@viper.(none)' => 'Maxim Krasnyansky',
+'rread@clusterfs.com' => 'Robert Read',
 'rscott@attbi.com' => 'Rob Scott',
 'rth@are.twiddle.net' => 'Richard Henderson',
 'rth@dorothy.sfbay.redhat.com' => 'Richard Henderson',
 'rth@dot.sfbay.redhat.com' => 'Richard Henderson',
+'rth@kanga.twiddle.net' => 'Richard Henderson',
 'rth@splat.sfbay.redhat.com' => 'Richard Henderson',
 'rth@twiddle.net' => 'Richard Henderson',
 'rth@vsop.sfbay.redhat.com' => 'Richard Henderson',
 'rui.sousa@laposte.net' => 'Rui Sousa',
 'rusty@rustcorp.com.au' => 'Rusty Russell',
+'rvinson@mvista.com' => 'Randy Vinson',
 'rwhron@earthlink.net' => 'Randy Hron',
 'rz@linux-m68k.org' => 'Richard Zidlicky',
 'sabala@students.uiuc.edu' => 'Michal Sabala', # google
@@ -560,8 +667,10 @@
 'scott_anderson@mvista.com' => 'Scott Anderson',
 'scottm@somanetworks.com' => 'Scott Murray',
 'sct@redhat.com' => 'Stephen C. Tweedie',
-'sds@tislabs.com' => 'Stephen Smalley',
+'sds@epoch.ncsc.mil' => 'Stephen D. Smalley',
+'sds@tislabs.com' => 'Stephen D. Smalley',
 'sebastian.droege@gmx.de' => 'Sebastian Dröge',
+'sfbest@us.ibm.com' => 'Steve Best',
 'sfr@canb.auug.org.au' => 'Stephen Rothwell',
 'shaggy@austin.ibm.com' => 'Dave Kleikamp',
 'shaggy@kleikamp.austin.ibm.com' => 'Dave Kleikamp',
@@ -577,13 +686,18 @@
 'sparker@sun.com' => 'Steven Parker', # by Duncan Laurie
 'spse@secret.org.uk' => 'Simon Evans', # by Kristian Peters
 'sridhar@dyn9-47-18-140.beaverton.ibm.com' => 'Sridhar Samudrala',
+'sridhar@dyn9-47-18-86.beaverton.ibm.com' => 'Sridhar Samudrala',
+'sridhar@x1-6-00-10-a4-8b-06-f6.attbi.com' => 'Sridhar Samudrala',
+'srompf@isg.de' => 'Stefan Rompf',
 'steiner@sgi.com' => 'Jack Steiner',
 'stelian.pop@fr.alcove.com' => 'Stelian Pop',
+'stelian@popies.net' => 'Stelian Pop',
 'stern@rowland.harvard.edu' => 'Alan Stern',
 'stern@rowland.org' => 'Alan Stern', # lbdb
 'steve.cameron@hp.com' => 'Stephen Cameron',
 'steve@chygwyn.com' => 'Steven Whitehouse',
 'steve@gw.chygwyn.com' => 'Steven Whitehouse',
+'steve@kbuxd.necst.nec.co.jp' => 'SL Baur',
 'stevef@smfhome1.austin.rr.com' => 'Steve French',
 'stevef@steveft21.ltcsamba' => 'Steve French',
 'stuartm@connecttech.com' => 'Stuart MacDonald',
@@ -595,6 +709,8 @@
 't-kouchi@mvf.biglobe.ne.jp' => 'Takayoshi Kouchi',
 'tai@imasy.or.jp' => 'Taisuke Yamada',
 'taka@valinux.co.jp' => 'Hirokazu Takahashi',
+'tao@acc.umu.se' => 'David Weinehall', # by himself
+'tao@kernel.org' => 'David Weinehall', # by himself
 'tcallawa@redhat.com' => 'Tom Callaway',
 'tetapi@utu.fi' => 'Tero Pirkkanen', # by Kristian Peters
 'th122948@scl1.sfbay.sun.com' => 'Tim Hockin', # by Duncan Laurie
@@ -604,6 +720,7 @@
 'thockin@sun.com' => 'Tim Hockin',
 'tigran@aivazian.name' => 'Tigran Aivazian',
 'tim@physik3.uni-rostock.de' => 'Tim Schmielau',
+'tmcreynolds@nvidia.com' => 'Tom McReynolds',
 'tmolina@cox.net' => 'Thomas Molina',
 'tomita@cinet.co.jp' => 'Osamu Tomita',
 'tomlins@cam.org' => 'Ed Tomlinson',
@@ -619,13 +736,18 @@
 'trini@kernel.crashing.org' => 'Tom Rini',
 'trond.myklebust@fys.uio.no' => 'Trond Myklebust',
 'tvignaud@mandrakesoft.com' => 'Thierry Vignaud',
+'tvrtko@net4u.hr' => 'Tvrtko A. Ursulin',
 'twaugh@redhat.com' => 'Tim Waugh',
 'tytso@mit.edu' => "Theodore Ts'o", # web.mit.edu/tytso/www/home.html
 'tytso@snap.thunk.org' => "Theodore Ts'o",
 'tytso@think.thunk.org' => "Theodore Ts'o", # guessed
 'urban@teststation.com' => 'Urban Widmark',
 'uzi@uzix.org' => 'Joshua Uziel',
+'valko@linux.karinthy.hu' => 'Laszlo Valko',
 'vandrove@vc.cvut.cz' => 'Petr Vandrovec',
+'vanl@megsinet.net' => 'Martin H. VanLeeuwen',
+'varenet@parisc-linux.org' => 'Thibaut Varene',
+'vberon@mecano.gme.usherb.ca' => 'Vincent Béron',
 'venkatesh.pallipadi@intel.com' => 'Venkatesh Pallipadi',
 'viro@math.psu.edu' => 'Alexander Viro',
 'vojta@math.berkeley.edu' => 'Paul Vojta',
@@ -633,17 +755,25 @@
 'vojtech@twilight.ucw.cz' => 'Vojtech Pavlik',
 'vojtech@ucw.cz' => 'Vojtech Pavlik', # added by himself
 'wa@almesberger.net' => 'Werner Almesberger',
+'wahrenbruch@kobil.de' => 'Thomas Wahrenbruch',
+'wd@denx.de' => 'Wolfgang Denk',
 'wes@infosink.com' => 'Wes Schreiner',
 'wg@malloc.de' => 'Wolfram Gloger', # lbdb
+'whitney@math.berkeley.edu' => 'Wayne Whitney',
+'will@sowerbutts.com' => 'William R. Sowerbutts',
 'willy@debian.org' => 'Matthew Wilcox',
+'willy@fc.hp.com' => 'Matthew Wilcox',
 'willy@w.ods.org' => 'Willy Tarreau',
 'wilsonc@abocom.com.tw' => 'Wilson Chen', # google
 'wim@iguana.be' => 'Wim Van Sebroeck',
 'wli@holomorphy.com' => 'William Lee Irwin III',
 'wolfgang.fritz@gmx.net' => 'Wolfgang Fritz', # by Kristian Peters
 'wolfgang@iksw-muees.de' => 'Wolfgang Muees',
+'wrlk@riede.org' => 'Willem Riede',
 'wstinson@infonie.fr' => 'William Stinson',
+'wstinson@wanadoo.fr' => 'William Stinson',
 'xkaspa06@stud.fee.vutbr.cz' => 'Tomas Kasparek',
+'yokota@netlab.is.tsukuba.ac.jp' => 'Yokota Hiroshi',
 'yoshfuji@linux-ipv6.org' => 'Hideaki Yoshifuji', # lbdb
 'yuri@acronis.com' => 'Yuri Per', # lbdb
 'zaitcev@redhat.com' => 'Pete Zaitcev',
@@ -977,6 +1107,7 @@
       # resolve the address to a name if possible
       append_item(%$log, @cur); @cur = ();
       $address = lc($1);
+      $address =~ s/\[[^]]+\]$//;
       $name = rmap_address($address);
       if ($name ne $address) {
 	if ($opt{'abbreviate-names'}) {
@@ -1176,6 +1307,44 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.66  2003/01/18 12:44:33  emma
+# New addresses found out by Vita.
+#
+# Revision 0.65  2003/01/13 14:12:09  emma
+# New addresses dug out by Vita.
+#
+# Revision 0.64  2003/01/08 14:48:50  emma
+# New addresses by Vita.
+#
+# Revision 0.63  2003/01/08 14:47:37  emma
+# New addresses by Vita.
+#
+# Revision 0.62  2002/12/27 16:59:28  emma
+# Another ten addresses sent by Vitezslav Samel.
+#
+# Revision 0.61  2002/12/14 14:28:49  emma
+# Bjorn Helgaas only uses the transscribed version of his name himself.
+#
+# Revision 0.60  2002/12/13 14:51:35  emma
+# Next dozen of addresses digged out by Vita.
+#
+# Revision 0.59  2002/12/11 12:11:51  emma
+# Workaround: strip trailing [tag] from mail addresses, reported by Marcel
+#     Holtmann.
+# Add some new addresses.
+#
+# Revision 0.58  2002/12/07 15:14:57  emma
+# More addresses figured by Vitezslav Samel.
+#
+# Revision 0.57  2002/12/07 15:08:34  emma
+# 3 more addresses.
+#
+# Revision 0.56  2002/11/28 02:32:11  emma
+# List David Weinehall.
+#
+# Revision 0.55  2002/11/27 04:44:54  emma
+# Add kaos@sgi.com for Keith Owens as per his own request.
+#
 # Revision 0.54  2002/11/26 23:27:11  emma
 # Merge changes from Linus' version.
 #

===================================================================


This BitKeeper patch contains the following changesets:
1.30..1.33
## Wrapped with gzip_uu ##


begin 600 bkpatch3348
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
I6H;DDZ[Z:6B9F8)W#UQ67XZ&MK)2=_6C-*.#E`Z"WO\!Y9??)IDM````
`
end
