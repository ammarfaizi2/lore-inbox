Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261527AbTAIDj3>; Wed, 8 Jan 2003 22:39:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261529AbTAIDj3>; Wed, 8 Jan 2003 22:39:29 -0500
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:55820 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S261527AbTAIDjU>; Wed, 8 Jan 2003 22:39:20 -0500
Date: Thu, 9 Jan 2003 04:47:55 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: shortlog update (BK format)
Message-ID: <20030109034754.GA21678@merlin.emma.line.org>
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

Hi,

for your convenience, I'm resending the lk-changelog.pl script as BK
ChangeSet. It upgrades shortlog aka lk-changelog.pl from upstream
version 0.54 to 0.64. Please apply.

The three deleted lines are 1 duplicate removed, 1 fix and 1 for the
version tag.

Matthias
--------------------------------------------------------------------
You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.31, 2003-01-09 04:40:05+01:00, matthias.andree@gmx.de
  Update to mainstream version 0.64.


 shortlog |  142 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 139 insertions(+), 3 deletions(-)


diff -Nru a/shortlog b/shortlog
--- a/shortlog	Thu Jan  9 04:46:09 2003
+++ b/shortlog	Thu Jan  9 04:46:09 2003
@@ -6,8 +6,9 @@
 # (C) Copyright 2002 by Matthias Andree <matthias.andree@gmx.de>
 #			Marcus Alanen <maalanen@abo.fi>
 #			Tomas Szepe <szepe@pinerecords.com>
+#			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.54 2002/11/26 23:27:11 emma Exp $
+# $Id: lk-changelog.pl,v 0.64 2003/01/08 14:48:50 emma Exp $
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
@@ -112,14 +117,19 @@
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
@@ -127,8 +137,10 @@
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
@@ -139,8 +151,10 @@
 'bjorn_helgaas@hp.com' => 'Bjorn Helgaas',
 'bmatheny@purdue.edu' => 'Blake Matheny', # google
 'borisitk@fortunet.com' => 'Boris Itkis', # by Kristian Peters
+'braam@clusterfs.com' => 'Peter Braam',
 'brett@bad-sports.com' => 'Brett Pemberton',
 'brihall@pcisys.net' => 'Brian Hall', # google
+'brm@murphy.dk' => 'Brian Murphy',
 'brownfld@irridia.com' => 'Ken Brownfield',
 'bunk@fs.tum.de' => 'Adrian Bunk',
 'buytenh@gnu.org' => 'Lennert Buytenhek',
@@ -154,6 +168,7 @@
 'ch@hpl.hp.com' => 'Christopher Hoover', # by Kristian Peters
 'charles.white@hp.com' => 'Charles White',
 'chessman@tux.org' => 'Samuel S. Chessman',
+'chris@qwirx.com' => 'Chris Wilson',
 'chris@wirex.com' => 'Chris Wright',
 'christer@weinigel.se' => 'Christer Weinigel', # from shortlog
 'christopher.leech@intel.com' => 'Christopher Leech',
@@ -173,10 +188,15 @@
 'dalecki@evision.ag' => 'Martin Dalecki',
 'dan.zink@hp.com' => 'Dan Zink',
 'dan@debian.org' => 'Daniel Jacobowitz',
+'dana.lacoste@peregrine.com' => 'Dana Lacoste',
 'danc@mvista.com' => 'Dan Cox', # some CREDITS patch found by google
+'daniel.ritz@gmx.ch' => 'Daniel Ritz',
+'dave@qix.net' => 'Dave Maietta',
 'davej@codemonkey.org.uk' => 'Dave Jones',
 'davej@suse.de' => 'Dave Jones',
+'davej@tetrachloride.(none)' => 'Dave Jones',
 'davem@hera.kernel.org' => 'David S. Miller',
+'davem@kernel.bkbits.net' => 'David S. Miller',
 'davem@nuts.ninka.net' => 'David S. Miller',
 'davem@pizda.ninka.net' => 'David S. Miller', # guessed
 'davem@redhat.com' => 'David S. Miller',
@@ -205,6 +225,8 @@
 'dipankar@in.ibm.com' => 'Dipankar Sarma',
 'dirk.uffmann@nokia.com' => 'Dirk Uffmann',
 'dledford@aladin.rdu.redhat.com' => 'Doug Ledford',
+'dledford@dledford.theledfords.org' => 'Doug Ledford',
+'dledford@flossy.devel.redhat.com' => 'Doug Ledford',
 'dledford@redhat.com' => 'Doug Ledford',
 'dmccr@us.ibm.com' => 'Dave McCracken',
 'dok@directfb.org' => 'Denis Oliver Kropp',
@@ -226,7 +248,9 @@
 'eike@bilbo.math.uni-mannheim.de' => 'Rolf Eike Beer',
 'elenstev@mesatop.com' => 'Steven Cole',
 'engebret@us.ibm.com' => 'Dave Engebretsen',
+'eranian@frankl.hpl.hp.com' => 'Stéphane Eranian',
 'eranian@hpl.hp.com' => 'Stéphane Eranian',
+'erik@aarg.net' => 'Erik Arneson',
 'erik_habbinga@hp.com' => 'Erik Habbinga',
 'eyal@eyal.emu.id.au' => 'Eyal Lebedinsky', # lbdb
 'fbl@conectiva.com.br' => 'Flávio Bruno Leitner', # google
@@ -238,18 +262,23 @@
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
@@ -262,12 +291,16 @@
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
@@ -279,7 +312,9 @@
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
@@ -289,7 +324,6 @@
 'ica2_ts@csv.ica.uni-stuttgart.de' => 'Thiemo Seufer', # google
 'info@usblcd.de' =>  'Adams IT Services',
 'ink@jurassic.park.msu.ru' => 'Ivan Kokshaysky',
-'ink@jurassic.park.msu.ru[rth]' => 'Ivan Kokshaysky',
 'ionut@cs.columbia.edu' => 'Ion Badulescu',
 'ioshadij@hotmail.com' => 'Ishan O. Jayawardena',
 'irohlfs@irohlfs.de' => 'Ingo Rohlfs',
@@ -301,11 +335,13 @@
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
@@ -317,33 +353,45 @@
 'jeb.j.cramer@intel.com' => 'Jeb J. Cramer',
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
@@ -355,13 +403,17 @@
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
@@ -373,6 +425,9 @@
 'komujun@nifty.com' => 'Jun Komuro', # google
 'kraxel@bytesex.org' => 'Gerd Knorr',
 'kraxel@suse.de' => 'Gerd Knorr',
+'krkumar@us.ibm.com' => 'Krishna Kumar',
+'kronos@kronoz.cjb.net' => 'Luca Tettamanti',
+'kuba@mareimbrium.org' => 'Kuba Ober',
 'kuebelr@email.uc.edu' => 'Robert Kuebel',
 'kuznet@mops.inr.ac.ru' => 'Alexey Kuznetsov',
 'kuznet@ms2.inr.ac.ru' => 'Alexey Kuznetsov',
@@ -386,6 +441,7 @@
 'leigh@solinno.co.uk' => 'Leigh Brown', # lbdb
 'levon@movementarian.org' => 'John Levon',
 'linux@brodo.de' => 'Dominik Brodowski',
+'linux@hazard.jcu.cz' => 'Jan Marek',
 'lionel.bouton@inet6.fr' => 'Lionel Bouton',
 'lists@mdiehl.de' => 'Martin Diehl',
 'liyang@nerv.cx' => 'Liyang Hu',
@@ -394,9 +450,11 @@
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
@@ -405,7 +463,9 @@
 'marcelo@conectiva.com.br' => 'Marcelo Tosatti',
 'marcelo@freak.distro.conectiva' => 'Marcelo Tosatti', # guessed
 'marcelo@plucky.distro.conectiva' => 'Marcelo Tosatti',
+'marekm@amelek.gda.pl' => 'Marek Michalkiewicz',
 'mark@alpha.dyndns.org' => 'Mark W. McClelland',
+'mark@hal9000.dyndns.org' => 'Mark W. McClelland',
 'markh@osdl.org' => 'Mark Haverkamp',
 'martin.bligh@us.ibm.com' => 'Martin J. Bligh',
 'martin@bruli.net' => 'Martin Brulisauer',
@@ -416,6 +476,7 @@
 'mauelshagen@sistina.com' => 'Heinz J. Mauelshagen',
 'maxk@qualcomm.com' => 'Maksim Krasnyanskiy',
 'maxk@viper.(none)' => 'Maksim Krasnyanskiy', # from shortlog
+'maxk@viper.qualcomm.com' => 'Maksim Krasnyanskiy',
 'mbligh@aracnet.com' => 'Martin J. Bligh',
 'mcp@linux-systeme.de' => 'Marc-Christian Petersen',
 'mdharm-scsi@one-eyed-alien.net' => 'Matthew Dharm',
@@ -425,11 +486,14 @@
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
@@ -437,6 +501,7 @@
 'mkp@mkp.net' => 'Martin K. Petersen', # lbdb
 'mlang@delysid.org' => 'Mario Lang', # google
 'mlindner@syskonnect.de' => 'Mirko Lindner',
+'mlocke@mvista.com' => 'Montavista Software, Inc.',
 'mmcclell@bigfoot.com' => 'Mark McClelland',
 'mochel@geena.pdx.osdl.net' => 'Patrick Mochel',
 'mochel@osdl.org' => 'Patrick Mochel',
@@ -446,6 +511,7 @@
 'mufasa@sis.com.tw' => 'Mufasa Yang', # sent by himself
 'mulix@actcom.co.il' => 'Muli Ben-Yehuda', # sent by himself
 'mw@microdata-pos.de' => 'Michael Westermann',
+'mzyngier@freesurf.fr' => 'Marc Zyngier',
 'n0ano@n0ano.com' => 'Don Dugger',
 'nahshon@actcom.co.il' => 'Itai Nahshon',
 'nathans@sgi.com' => 'Nathan Scott',
@@ -453,8 +519,10 @@
 'nemosoft@smcc.demon.nl' => 'Nemosoft Unv.',
 'nico@cam.org' => 'Nicolas Pitre',
 'nicolas.aspert@epfl.ch' => 'Nicolas Aspert',
+'nicolas.mailhot@laposte.net' => 'Nicolas Mailhot',
 'nkbj@image.dk' => 'Niels Kristian Bech Jensen',
 'nmiell@attbi.com' => 'Nicholas Miell',
+'nobita@t-online.de' => 'Andreas Busch',
 'okir@suse.de' => 'Olaf Kirch', # lbdb
 'olaf.dietsche#list.linux-kernel@t-online.de' => 'Olaf Dietsche',
 'olaf.dietsche' => 'Olaf Dietsche',
@@ -464,11 +532,14 @@
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
 'paul.mundt@timesys.com' => 'Paul Mundt', # google
 'paulkf@microgate.com' => 'Paul Fulghum',
@@ -491,12 +562,19 @@
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
@@ -505,6 +583,7 @@
 'r.e.wolff@bitwizard.nl' => 'Rogier Wolff', # lbdbq
 'ralf@dea.linux-mips.net' => 'Ralf Bächle',
 'ralf@linux-mips.org' => 'Ralf Bächle',
+'ramune@net-ronin.org' => 'Daniel A. Nobuto',
 'randy.dunlap@verizon.net' => 'Randy Dunlap',
 'ray-lk@madrabbit.org' => 'Ray Lee',
 'rbh00@utsglobal.com' => 'Richard Hitt', # asked him, he prefers Richard
@@ -521,6 +600,7 @@
 'rhw@infradead.org' => 'Riley Williams',
 'richard.brunner@amd.com' => 'Richard Brunner',
 'riel@conectiva.com.br' => 'Rik van Riel',
+'rjweryk@uwo.ca' => 'Rob Weryk',
 'rl@hellgate.ch' => 'Roger Luethi',
 'rlievin@free.fr' => 'Romain Lievin',
 'rmk@arm.linux.org.uk' => 'Russell King',
@@ -531,7 +611,9 @@
 'rohit.seth@intel.com' => 'Rohit Seth',
 'roland@topspin.com' => 'Roland Dreier',
 'romieu@cogenit.fr' => 'François Romieu',
+'romieu@fr.zoreil.com' => 'François Romieu',
 'root@viper.(none)' => 'Maxim Krasnyansky',
+'rread@clusterfs.com' => 'Robert Read',
 'rscott@attbi.com' => 'Rob Scott',
 'rth@are.twiddle.net' => 'Richard Henderson',
 'rth@dorothy.sfbay.redhat.com' => 'Richard Henderson',
@@ -562,6 +644,7 @@
 'sct@redhat.com' => 'Stephen C. Tweedie',
 'sds@tislabs.com' => 'Stephen Smalley',
 'sebastian.droege@gmx.de' => 'Sebastian Dröge',
+'sfbest@us.ibm.com' => 'Steve Best',
 'sfr@canb.auug.org.au' => 'Stephen Rothwell',
 'shaggy@austin.ibm.com' => 'Dave Kleikamp',
 'shaggy@kleikamp.austin.ibm.com' => 'Dave Kleikamp',
@@ -577,13 +660,18 @@
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
@@ -595,6 +683,8 @@
 't-kouchi@mvf.biglobe.ne.jp' => 'Takayoshi Kouchi',
 'tai@imasy.or.jp' => 'Taisuke Yamada',
 'taka@valinux.co.jp' => 'Hirokazu Takahashi',
+'tao@acc.umu.se' => 'David Weinehall', # by himself
+'tao@kernel.org' => 'David Weinehall', # by himself
 'tcallawa@redhat.com' => 'Tom Callaway',
 'tetapi@utu.fi' => 'Tero Pirkkanen', # by Kristian Peters
 'th122948@scl1.sfbay.sun.com' => 'Tim Hockin', # by Duncan Laurie
@@ -604,6 +694,7 @@
 'thockin@sun.com' => 'Tim Hockin',
 'tigran@aivazian.name' => 'Tigran Aivazian',
 'tim@physik3.uni-rostock.de' => 'Tim Schmielau',
+'tmcreynolds@nvidia.com' => 'Tom McReynolds',
 'tmolina@cox.net' => 'Thomas Molina',
 'tomita@cinet.co.jp' => 'Osamu Tomita',
 'tomlins@cam.org' => 'Ed Tomlinson',
@@ -619,13 +710,17 @@
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
+'varenet@parisc-linux.org' => 'Thibaut Varene',
+'vberon@mecano.gme.usherb.ca' => 'Vincent Béron',
 'venkatesh.pallipadi@intel.com' => 'Venkatesh Pallipadi',
 'viro@math.psu.edu' => 'Alexander Viro',
 'vojta@math.berkeley.edu' => 'Paul Vojta',
@@ -633,17 +728,25 @@
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
@@ -977,6 +1080,7 @@
       # resolve the address to a name if possible
       append_item(%$log, @cur); @cur = ();
       $address = lc($1);
+      $address =~ s/\[[^]]+\]$//;
       $name = rmap_address($address);
       if ($name ne $address) {
 	if ($opt{'abbreviate-names'}) {
@@ -1176,6 +1280,38 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
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
1.31
## Wrapped with gzip_uu ##


begin 600 bkpatch22760
M'XL(`('P'#X``\59:V_<N!7]G/D5!+)`6FQ&ED;S;K/0.L[&>3@;V$F,[>YV
M04F<$4<2J9#4C&<0]->V*/8/%/W80W)>MO?1;0O4>=@CWGM)WL>YY\H/R7O-
MU/1!38TI.-4!%;EBK/.0G$MMI@_F]4V0VX^74N+CB6XU.RF9$JPZ.7V%OUW_
MH6NDK'0'@F^IR0JR9$I/'T1!O']BU@V;/KA\]OS]ZR\O.YTG3\C3@HHYNV*&
M/'G2,5(M:97KI&%BWG(1&$6%KIFA02;K3WO93[TP[.%/U(O#X6#RJ3<9#@:?
M6(\-!ED_HNEH/&)9[V"ND#7[15M1U!OU>H-^&'WJ#\9AOW-&<.R(A/%)&)V$
M$Q+VI_UP&@X^#Z-I&)([GDJ\A\CG$>F&G5/R/[['TTY&WC<Y-0R6L3<7VBA&
M:^=@+@4)@V$_Z+PB_4&OU^N\/3BUT_V-7YU.2,/.%^277*<+J4PEY_[T@V@<
MCOJC:/PICD:3P:<9F]!9-@HG-&0Y3?.?\=4M*W$8A9,P[H=A_U,X&?<CEQH[
MB5N9\5^?Y]\W=904430>Q"XIHOM)T?^UI(@GI!O_']/">?1KTE6K&_NW>X,4
MV=WT/\B0%V,2=1X^>/#@`S=LHRNZ)%>T9A7YH[;?$IRD"K+-%YVS*(3D"_?_
M0_+9BWQ*JK*;N6MBZZ"I'B_=(8G-`>=4F(93Q]-!2%A=4_+LIB&?=5Z,(IAX
M1%-=M1F7B6%*.9\%J7I$GGQ!'KVVS\D%S3BK'CW&$4.GD-.FHO"WK`+!C!?]
M4A@IN)#DS"TZ:6^>I2I9V;"T+!#53CI7G&GR+""G2K8KIIS"P"G,5<M$8N$0
M@3[(,ZK)<[N4TJSP"E'4=QJ*ZR2CIF"YHE6%"P52S;>:6#.L)5=,S7&72[E!
M<I2<?,6K0GH;0V]#Y$D*H9H*T<UA)I=J=C@`ELGI=MFKC;Q:*P)=4%73A`O#
M*NN_G4HKR)5;<@J]'NEU'J5(5<6S,EE107,I@]G6UV>MR"@4D.;6>U80-^'R
MAQS7DPFKLX/I,_N(G&XEO/6)/4Z:ZZQHUW72P(Q$--/M^4^I,N2,D2NWO/5>
M[`*$2\N$JK+BHKTY.`Z7%3A\#I=I)DI%F=AL]?I>3U%:)UG5PK]JI@^G>\OP
M`''%LA>/O7B=U*UJBG60E]LM%,>-+]Q#)SEPH<@*&\^/*ZYN#D:?VH?DFE=:
M>O^/7++D\&)0T0P=E0$`%)LK+MBQIP0EK_VZ5QO:*$`-*1TH;C8.4+)B+X[G
MY!+/;0QRNF3)1WYS2/,S/$%!<&:,C^IH[(^Q9`L4$*`G*RJI>,Z"WPDIV.^/
MU%[BL_9*DYU2G?@F'Z1ERHV^M1'/R55`+GA5>;_WPI$[>\7RF51YLOLA0.)O
M?SQ*_#/9SLEK_]C=9:<VJZ36"`);6@^PO*#FR%^WM5[T>NY^#)"*6"4S?"^K
MH&CLOX/6E?FQ`?XP\LS+><V)U^1E0JF:'Z[V#(\("HIM0]GK.UB9B3J9M19B
M@[94^OA4;U`PY"N69P4OO8:K^YG.2I8G,+SDFLJ@V6[PEK:5)!8S?O32SF]S
M6W``@T30<MTV0<TW_#B_*/E&MF+>/;<%9:69+A+3WAC9!,L;+G).`_0`;NA1
MKC]W8N0#54!%11?;NP]Z]GQSX$522\4`C0Y7:;O50IZ2]\!KM8WLT-UGCOY&
M50HH$SFKT(&RXK#3*1.`/RO@-49>0XJ2"[A`Y4M;"H>#,60"0_':=:\Q]AJM
MR`$0K0YX6A_D+S@Z"%+_N5MW"B,7E@).2[(U4`(J&?72+VE-*W*.)0!6Q6V=
MG_7&]M(O[+<8:JR:4S2)678K4TX74@ER[A<?/28/22Z9%H\,`1X:\L^3OUE5
M@4X"SS'.5'?.N$`Y[I'XW*^2"[?ZW*_:B$%-\8\MZP5SF:;VS%E%<W84K/.M
M!'EN!=R9)^[,<>@@:H%&JW^HLYK9;@HF8WS3W>F_M.OD(KMPZ]9'<>B<NDBI
M3>=$SX\RZB73F@&DU;;JX\@5Q((MTD2A]$4`VX`EU.Z:W=WD5!HC:ZPXS9Y+
MC\6<J@VJJ9&IO#G>9S8CS]V2%QYY8<7KNG<OS@`AQ!A+3M9W@$5I$L2+M_KX
M&"BY=R!S5&_+-(YC6T8+B>XK$O_M`#<OW6=$UF4;I%@RXVD(MA</QE$<S#3*
M%.91VSL%9NTKD?H:B&-_28FB:0`CP'-H9!*41AR(P,M_J#EYZY:]DK^L+$0R
M5S2U/QS?M1"V#^W1+.Z['KS0N+\4&AT;@)8SFA_=P[G_R@NXF^R$2[FIY2U4
MORL+^_X.&O655Q;9@SOY[XYT0=72%V7<=QUO8=:HX"3309NI@.7MD?`[N^1D
M!^ZN):UHTJ#)*98YQ-_;?F>#1:XVK/&^&89>7MY)S%>,FX)\O6+"5R#:NR'I
MFA2\UJR:64U7#KXS)?=3U.(K>5JQ&HK^WAZ_RH(6$GXR/-`2D#?C>PY&7K8H
M&4[._UHS)JBG7C%Z.*"B5&5;4W4O55^AXQ=HWZ_LJ@U%";3#9=RW39`MTD-/
M`5.EY)WMRB!HACOI-J5@S8KQ.E6\K0\Q?H45\O4N[\:NA!W[20JZ`>4)%ED+
MJKT+L@L8\\4U<?'"(8,F64GP[D;)!<O,/D$AFG4=63&6W#@N!`=[90<`.""S
MK064^#8"^^?D"CS:BO?#D1?'WG5B9P!6!O.<@N#OMV(E<<!=E9RM>+;Q>N.M
M7HG[5),P#(-\+7)Q1`Z@6I)KD(L,802+%*X\^M%6\Z9,EAQL*OC8T@H'O'7*
M$@5!7BFJQ=I1:0=1_9[KL35'>B)CP%F*C_>;RY5=L+&Q<LRBGZT$\(,;KH^E
M2R_L%IWUV/73&MH\H<#G1M\W;HD2GWM<[L?>U94$0TAJT`-SU!LOI##4/8.S
M9V8%/SXF+T06.-6^=\)F+>;H,*`\B$J+46!'U&V$R9_\JE,8."8J.+`*U,"V
M#'2.I**-)9V'%'WC!2Q[M`)>U8582'`_FIBN%!47]Z>>TQ:LWLD/7?K)BH.(
M)))9+`KLP'V'NW_M!,@;UJ*RO**[%(B?23!X@9WN9:\MOZQ!>?'4B?JIL*&Z
M7"=MMMH7`E(9K)ZVX%!.;A*3/N28*=$K@3P&80ORC`7I?*]0VNE1`,.7-NI;
M645+_ELDT9JJPWE_3M:PCRVO?MDN#NT<V!0V5]`=D1(93GX($G*/D;=NN=E>
MTWFNJ;(*6U1LANK,Z$'A+69.25[+AFVZ3VD*C*NVXV_?EWLCE;'8+H^FB`MJ
M#'GK%JSDP%>ZHG4K7-?K*CM+'W%Y/Y9\&9`W,FV-`\]!SX&T6F!X7I=)NY)[
M=G8I4W)MGSJYV,O)FK,6V1QL0$B/6<U7Z*9_EQBN+IV(UW%XKI!]^4]->-B`
M89Z\Q+(3]_"O9RE#?MV%\2N#20.SLW8I/\#L`\S7&)$P728`IDFW/^I&X^YX
MB&D5O$A9MGS;@A>V[T-:.^';R6MOX2;J#KMAV(W"+NUWQVDW''9GPP`>3OFO
MFI!U,TNXGN]+#H>=`;8O[8([KG^)`0=4=OYI9,/9T91VY9\CEHV7'FZE,3>6
M:7N30S1S^66G]V#1;-5>VT+RL9\XX#04,WB6!6W=!IH=CX#78%0,.%ZY7GW4
MIIW.=GH\RI1?U'DQ#-T)39TIMD99Y#H1T.#T%HU`7[C<+MLS#GO."6:I4$XV
M/_MM4&S1\)U[:%/SO=)MY6G-T'/0)?J23#PVE12#N<'P7VS)S6NJ-YC2/E@9
MKS.VCE@"C+%#TMB7.EGW#K"]*WA*6V/G+4C9&"[MZPO@#\/0)(-YS8)6%TRE
M^V+XP$5F"<[IC\KSV&$\L!NM:`$;J6JS`I0E147L<L"S7G)]$+`;K3!P,W&S
ME[J6U0S=9D[.F"B]71?)5<&-8&L@HBF0T*JTY.G`Z:XI^!RY]D+.+@`CT1)5
MC,HV1T5F@9E3('.`+K5;]ALY2+**Z[OSE466@JWLBQ(@CI/VG'2EJO+7H'_8
M=YUL!2@7(/WW7E'M3G3EU[V*RZ>U!.NC-C4JF@9HYD:WEG\%--LG_3=.AIQS
M)77A&,[$O0<A[NLSFJ/9:4V>_(7HD^^^_?;/WW__^7???W9R\@?WLFU,XI[]
M70E#W]Z]A24_^8;3O>*$Z!NX86L4+!U%\`%--N@\O&,EOF=E-$4D?Z.5GK/2
M.XEZ)S;WA]/!9(J$WEGY4DB$11&#$>E@;4>\[[SQO6\].EBW;SS[,#WM3_;6
M;PW5!"1B35IK'UL2]S)<9XJG+-^_PI8S(((F`KOMH.'^IN'1IK'==!!-43H'
MQ]P8#.\;YLP=+I7S^1Q;R=;\K+<&DR/3@);>-(I@?6_Z6BK`A6Q%/B7:*-[8
M6_#*3OW?&CK_GLP`W/;5?'78]S%1S+7:W&YK.1JK8,I^G<O*V->V@0U$GA,-
MPD3$<5SOGW!\.*%MSH.IO?\A*R[00X_N/./S5OF=?RV6ULAMR^%XBG:[LQR3
M^I;M^P:&.P/1"3(L[$UCZ[^]@=?@M>1.&[AO9'!D9.1^Y8+['4YAW70\.!),
MT.1H;B3(,\P'+HOD2L#W'ULT>+O/_K>26<&R4K?UD_XL3#,VFG3^!;KYH5L2
#'0``
`
end
