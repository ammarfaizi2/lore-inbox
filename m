Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262637AbTDMAnv (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 20:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262633AbTDMAnv (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 20:43:51 -0400
Received: from dsl081-067-005.sfo1.dsl.speakeasy.net ([64.81.67.5]:42958 "EHLO
	renegade") by vger.kernel.org with ESMTP id S262637AbTDMAni (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 20:43:38 -0400
Date: Sat, 12 Apr 2003 17:55:11 -0700
From: Zack Brown <zbrown@tumblerings.org>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lk-changelog.pl 0.93
Message-ID: <20030413005510.GA21855@renegade>
References: <20030405020728.92EC95EE6F@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030405020728.92EC95EE6F@merlin.emma.line.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On Sat, Apr 05, 2003 at 04:07:28AM +0200, Matthias Andree wrote:
> This is a semi-automatic announcement.
> 
> lk-changelog.pl aka. shortlog version 0.93 has been released.

Here's a patch with more names and a few corrections.

Be well,
Zack

--- lk-changelog-0.93.pl	2003-04-12 17:22:32.000000000 -0700
+++ lk-changelog-0.93.pl.zb	2003-04-12 17:44:28.000000000 -0700
@@ -89,23 +89,29 @@
 # Unless otherwise noted, the addresses below have been obtained using
 # lbdb.
 my %addresses = (
+'aaron.baranoff:tsc.tdk.com' => 'Aaron Baranoff',
 'abraham:2d3d.co.za' => 'Abraham van der Merwe',
 'abslucio:terra.com.br' => 'Lucio Maciel',
 'ac9410:attbi.com' => 'Albert Cranford',
+'ac9410:bellsouth.net' => 'Albert Cranford',
 'acher:in.tum.de' => 'Georg Acher',
 'achirica:ttd.net' => 'Javier Achirica',
 'acme:brinquedo.oo.ps' => 'Arnaldo Carvalho de Melo',
 'acme:conectiva.com.br' => 'Arnaldo Carvalho de Melo',
 'acme:dhcp197.conectiva' => 'Arnaldo Carvalho de Melo',
 'acurtis:onz.com' => 'Allen Curtis',
+'adam:kroptech.com' => 'Adam Kropelin',
 'adam:mailhost.nmt.edu' => 'Adam Radford', # google
 'adam:nmt.edu' => 'Adam Radford', # google
+'adam:skullslayer.rod.org' => 'Adam Bernau',
 'adam:yggdrasil.com' => 'Adam J. Richter',
 'adaplas:pol.net' => 'Antonino Daplas',
+'aderesch:fs.tum.de' => 'Andreas Deresch',
 'adilger:clusterfs.com' => 'Andreas Dilger',
 'aebr:win.tue.nl' => 'Andries E. Brouwer',
 'agrover:acpi3.(none)' => 'Andy Grover',
 'agrover:acpi3.jf.intel.com' => 'Andy Grover', # guessed
+'agrover:aracnet.com' => 'Andy Grover',
 'agrover:dexter.groveronline.com' => 'Andy Grover',
 'agrover:groveronline.com' => 'Andy Grover',
 'agruen:suse.de' => 'Andreas Gruenbacher',
@@ -119,14 +125,18 @@
 'ak:muc.de' => 'Andi Kleen',
 'ak:suse.de' => 'Andi Kleen',
 'akpm:digeo.com' => 'Andrew Morton',
+'akpm:reardensteel.com' => 'Andrew Morton',
 'akpm:zip.com.au' => 'Andrew Morton',
 'akropel1:rochester.rr.com' => 'Adam Kropelin', # lbdb
+'alan:hraefn.swansea.linux.org.uk' => 'Alan Cox',
+'alan:irongate.swansea.linux.org.uk' => 'Alan Cox',
 'alan:lxorguk.ukuu.org.uk' => 'Alan Cox',
 'alan:redhat.com' => 'Alan Cox',
 'alex:ssi.bg' => 'Alexander Atanasov',
 'alex_williamson:attbi.com' => 'Alex Williamson', # lbdb
 'alex_williamson:hp.com' => 'Alex Williamson', # google
 'alexander.riesen:synopsys.com' => 'Alexander Riesen',
+'alexander.schulz:innominate.com' => 'Alexander Schulz',
 'alexey:technomagesinc.com' => 'Alex Tomas',
 'alfre:ibd.es' => 'Alfredo Sanjuán',
 'ambx1:neo.rr.com' => 'Adam Belay',
@@ -134,22 +144,27 @@
 'andersen:codepoet.org' => 'Erik Andersen',
 'andersg:0x63.nu' => 'Anders Gustafsson',
 'andmike:us.ibm.com' => 'Mike Anderson', # lbdb
+'andre.breiler:null-mx.org' => 'André Breiler',
 'andrea:suse.de' => 'Andrea Arcangeli',
 'andrew.wood:ivarch.com' => 'Andrew Wood',
 'andries.brouwer:cwi.nl' => 'Andries E. Brouwer',
 'andros:citi.umich.edu' => 'Andy Adamson',
-'andre.breiler:null-mx.org' => 'André Breiler',
 'angus.sawyer:dsl.pipex.com' => 'Angus Sawyer',
 'ankry:green.mif.pg.gda.pl' => 'Andrzej Krzysztofowicz',
 'anton:samba.org' => 'Anton Blanchard',
+'anton:superego.(none)' => 'Anton Blanchard',
+'anton:superego.ozlabs.ibm.com' => 'Anton Blanchard',
+'apolkosnik:directvinternet.com' => 'Adam Polkosnik',
 'aris:cathedrallabs.org' => 'Aristeu Sergio Rozanski Filho',
 'arjan:redhat.com' => 'Arjan van de Ven',
 'arjanv:redhat.com' => 'Arjan van de Ven',
+'arnaud.quette:mgeups.com' => 'Arnaud Quette',
 'arnd:arndb.de' => 'Arnd Bergmann',
 'arnd:bergmann-dalldorf.de' => 'Arnd Bergmann',
 'arndb:de.ibm.com' => 'Arnd Bergmann',
 'arun.sharma:intel.com' => 'Arun Sharma',
 'asit.k.mallick:intel.com' => 'Asit K. Mallick', # by Kristian Peters
+'asl:launay.org' => 'Arnaud S. Launay',
 'axboe:burns.home.kernel.dk' => 'Jens Axboe', # guessed
 'axboe:hera.kernel.org' => 'Jens Axboe',
 'axboe:suse.de' => 'Jens Axboe',
@@ -159,7 +174,9 @@
 'ballabio_dario:emc.com' => 'Dario Ballabio',
 'barrow_dj:yahoo.com' => 'D. J. Barrow',
 'barryn:pobox.com' => 'Barry K. Nathan', # lbdb
+'bart.de.schuyer:pandora.be' => 'Bart De Schuymer',
 'bart.de.schuymer:pandora.be' => 'Bart De Schuymer',
+'bbosch:iphase.com' => 'Bradley A. Bosch',
 'bcollins:debian.org' => 'Ben Collins',
 'bcrl:bob.home.kvack.org' => 'Benjamin LaHaise',
 'bcrl:redhat.com' => 'Benjamin LaHaise',
@@ -171,6 +188,7 @@
 'benh:kernel.crashing.org' => 'Benjamin Herrenschmidt',
 'benh:zion.wanadoo.fr' => 'Benjamin Herrenschmidt',
 'bergner:vnet.ibm.com' => 'Peter Bergner',
+'berny.f:aon.at' => 'Bernhard Fischer',
 'bero:arklinux.org' => 'Bernhard Rosenkraenzer',
 'bfennema:falcon.csc.calpoly.edu' => 'Ben Fennema',
 'bgerst:didntduck.org' => 'Brian Gerst',
@@ -183,6 +201,7 @@
 'blaschke:blaschke3.austin.ibm.com' => 'Dave Blaschke',
 'blueflux:koffein.net' => 'Oskar Andreasson',
 'bmatheny:purdue.edu' => 'Blake Matheny', # google
+'bombe:informatik.tu-muenchen.de' => 'Andreas Bombe',
 'borisitk:fortunet.com' => 'Boris Itkis', # by Kristian Peters
 'braam:clusterfs.com' => 'Peter Braam',
 'brett:bad-sports.com' => 'Brett Pemberton',
@@ -192,16 +211,21 @@
 'bunk:fs.tum.de' => 'Adrian Bunk',
 'buytenh:gnu.org' => 'Lennert Buytenhek',
 'bwa:us.ibm.com' => 'Bruce Allan',
+'bwheadley:earthlink.net' => 'Bryan W. Headley',
 'bwindle:fint.org' => 'Burton N. Windle',
 'bzeeb-lists:lists.zabbadoz.net' => 'Björn A. Zeeb', # lbdb
+'bzzz:gerasimov.net' => 'Alex Tomas',
 'bzzz:tmi.comex.ru' => 'Alex Tomas',
 'c-d.hailfinger.kernel.2002-07:gmx.net' => 'Carl-Daniel Hailfinger',
 'c-d.hailfinger.kernel.2002-q4:gmx.net' => 'Carl-Daniel Hailfinger', # himself
+'cananian:lesser-magoo.lcs.mit.edu' => 'C. Scott Ananian',
 'cattelan:sgi.com' => 'Russell Cattelan', # google
 'ccaputo:alt.net' => 'Chris Caputo',
 'cel:citi.umich.edu' => 'Chuck Lever',
 'celso:bulma.net' => 'Celso González', # google
 'ch:hpl.hp.com' => 'Christopher Hoover', # by Kristian Peters
+'ch:murgatroid.com' => 'Christopher Hoover',
+'chan:aleph1.co.uk' => 'Tak-Shing Chan',
 'charles.white:hp.com' => 'Charles White',
 'chas:cmf.nrl.navy.mil' => 'Chas Williams',
 'chas:locutus.cmf.nrl.navy.mil' => 'Chas Williams',
@@ -210,10 +234,12 @@
 'chris:wirex.com' => 'Chris Wright',
 'christer:weinigel.se' => 'Christer Weinigel', # from shortlog
 'christopher.leech:intel.com' => 'Christopher Leech',
+'christopher:intel.com' => 'Christopher Goldfarb',
 'cip307:cip.physik.uni-wuerzburg.de' => 'Jochen Karrer', # from shortlog
 'ckulesa:as.arizona.edu' => 'Craig Kulesa',
 'clemens:ladisch.de' => 'Clemens Ladisch',
 'cloos:jhcloos.com' => 'James H. Cloos Jr.',
+'cloos:lugabout.jhcloos.org' => 'James H. Cloos Jr.',
 'cminyard:mvista.com' => 'Corey Minyard',
 'cniehaus:handhelds.org' => 'Carsten Niehaus',
 'cobra:compuserve.com' => 'Kevin Brosius',
@@ -225,6 +251,7 @@
 'coughlan:redhat.com' => 'Tom Coughlan',
 'cph:zurich.ai.mit.edu' => 'Chris Hanson',
 'cr:sap.com' => 'Christoph Rohland',
+'craig:homerjay.homelinux.org' => 'Craig Wilkie',
 'cramerj:intel.com' => 'Jeb J. Cramer',
 'cruault:724.com' => 'Charles-Edouard Ruault',
 'ctindel:cup.hp.com' => 'Chad N. Tindel',
@@ -245,11 +272,13 @@
 'dana.lacoste:peregrine.com' => 'Dana Lacoste',
 'danc:mvista.com' => 'Dan Cox', # some CREDITS patch found by google
 'daniel.ritz:gmx.ch' => 'Daniel Ritz',
+'dank:kegel.com' => 'Dan Kegel',
 'dave:qix.net' => 'Dave Maietta',
 'dave:thedillows.org' => 'David Dillow',
 'davej:codemonkey.or' => 'Dave Jones',
 'davej:codemonkey.org.u' => 'Dave Jones',
 'davej:codemonkey.org.uk' => 'Dave Jones',
+'davej:codmonkey.org.uk' => 'Dave Jones',
 'davej:suse.de' => 'Dave Jones',
 'davej:tetrachloride.(none)' => 'Dave Jones',
 'davem:hera.kernel.org' => 'David S. Miller',
@@ -257,7 +286,9 @@
 'davem:nuts.ninka.net' => 'David S. Miller',
 'davem:pizda.ninka.net' => 'David S. Miller', # guessed
 'davem:redhat.com' => 'David S. Miller',
+'david-b:pacbell.com' => 'David Brownell',
 'david-b:pacbell.net' => 'David Brownell',
+'david-b:packbell.net' => 'David Brownell',
 'david.nelson:pobox.com' => 'David Nelson',
 'david:gibson.dropbear.id.au' => 'David Gibson',
 'david_jeffery:adaptec.com' => 'David Jeffery',
@@ -272,15 +303,19 @@
 'ddstreet:us.ibm.com' => 'Dan Streetman',
 'defouwj:purdue.edu' => 'Jeff DeFouw',
 'dent:cosy.sbg.ac.at' => "Thomas 'Dent' Mirlacher",
+'derek:ihtfp.com' => 'Derek Atkins',
 'devel:brodo.de' => 'Dominik Brodowski',
 'devik:cdi.cz' => 'Martin Devera',
 'dgibson:samba.org' => 'David Gibson',
 'dhinds:sonic.net' => 'David Hinds', # google
-'dhollis:davehollis.com' => 'Dave Hollis',
+'dhollis:davehollis.com' => 'David T. Hollis',
 'dhowells:cambridge.redhat.com' => 'David Howells',
 'dhowells:redhat.com' => 'David Howells',
+'dilinger:mp3revolution.net' => 'Andres Salomon',
 'dipankar:in.ibm.com' => 'Dipankar Sarma',
+'dirk.behme:de.bosch.com' => 'Dirk Behme',
 'dirk.uffmann:nokia.com' => 'Dirk Uffmann',
+'dkuhlen:fhm.edu' => 'Dominik Kuhlen',
 'dledford:aladin.rdu.redhat.com' => 'Doug Ledford',
 'dledford:dledford.theledfords.org' => 'Doug Ledford',
 'dledford:flossy.devel.redhat.com' => 'Doug Ledford',
@@ -294,12 +329,13 @@
 'drow:false.org' => 'Daniel Jacobowitz',
 'drow:nevyn.them.org' => 'Daniel Jacobowitz',
 'dsaxena:mvista.com' => 'Deepak Saxena',
+'dsteklof:us.ibm.com' => 'Daniel E. F. Stekloff',
 'duncan.sands:math.u-psud.fr' => 'Duncan Sands',
 'dwmw2:dwmw2.baythorne.internal' => 'David Woodhouse',
 'dwmw2:infradead.org' => 'David Woodhouse',
 'dwmw2:redhat.com' => 'David Woodhouse',
 'dz:cs.unitn.it' => 'Massimo Dal Zotto',
-'ebiederm:xmission.com' => 'Eric Biederman',
+'ebiederm:xmission.com' => 'Eric W. Biederman',
 'ebrower:resilience.com' => 'Eric Brower',
 'ebrower:usa.net' => 'Eric Brower',
 'ecd:skynet.be' => 'Eddie C. Dost',
@@ -309,14 +345,15 @@
 'eike-kernel:sf-tec.de' => 'Rolf Eike Beer', # sent by himself
 'eike:bilbo.math.uni-mannheim.de' => 'Rolf Eike Beer',
 'elenstev:mesatop.com' => 'Steven Cole',
+'eli.kupermann:intel.com' => 'Eli Kupermann',
 'engebret:us.ibm.com' => 'Dave Engebretsen',
 'eranian:frankl.hpl.hp.com' => 'Stéphane Eranian',
 'eranian:hpl.hp.com' => 'Stéphane Eranian',
 'erik:aarg.net' => 'Erik Arneson',
 'erik_habbinga:hp.com' => 'Erik Habbinga',
 'eyal:eyal.emu.id.au' => 'Eyal Lebedinsky', # lbdb
-'falk.hueffner:student.uni-tuebingen.de' => 'Falk Hueffner',
 'faikuygur:ttnet.net.tr' => 'Faik Uygur',
+'falk.hueffner:student.uni-tuebingen.de' => 'Falk Hueffner',
 'fbl:conectiva.com.br' => 'Flávio Bruno Leitner', # google
 'fdavis:si.rr.com' => 'Frank Davis',
 'felipewd:terra.com.br' => 'Felipe Damasio', # by self (did not ask to include the W.)
@@ -324,6 +361,7 @@
 'fero:sztalker.hu' => 'Bakonyi Ferenc',
 'filip.sneppe:cronos.be' => 'Filip Sneppe',
 'fischer:linux-buechse.de' => 'Jürgen E. Fischer',
+'flavien:lebarbe.net' => 'Flavien Lebarbé',
 'fletch:aracnet.com' => 'Martin J. Bligh',
 'flo:rfc822.org' => 'Florian Lohoff',
 'florian.thiel:gmx.net' => 'Florian Thiel', # from shortlog
@@ -332,6 +370,7 @@
 'fokkensr:fokkensr.vertis.nl' => 'Rolf Fokkens',
 'franz.sirl-kernel:lauterbach.com' => 'Franz Sirl',
 'franz.sirl:lauterbach.com' => 'Franz Sirl',
+'frival:zk3.dec.com' => 'Peter Rival',
 'fscked:netvisao.pt' => 'Paulo André',
 'fubar:us.ibm.com' => 'Jay Vosburgh',
 'fw:deneb.enyo.de' => 'Florian Weimer', # lbdb
@@ -342,6 +381,8 @@
 'ganesh:veritas.com' => 'Ganesh Varadarajan',
 'ganesh:vxindia.veritas.com' => 'Ganesh Varadarajan',
 'garloff:suse.de' => 'Kurt Garloff',
+'garyhade:us.ibm.com' => 'Gary Hade',
+'gbarzini:virata.com' => 'Guido Barzini',
 'geert:linux-m68k.org' => 'Geert Uytterhoeven',
 'george:mvista.com' => 'George Anzinger',
 'georgn:somanetworks.com' => 'Georg Nikodym',
@@ -363,6 +404,7 @@
 'green:linuxhacker.ru' => 'Oleg Drokin',
 'green:namesys.com' => 'Oleg Drokin',
 'greg:kroah.com' => 'Greg Kroah-Hartman',
+'greg:soap.kroah.net' => 'Greg Kroah-Hartman',
 'gregkh:kernel.bkbits.net' => 'Greg Kroah-Hartman',
 'gronkin:nerdvana.com' => 'George Ronkin',
 'grundler:cup.hp.com' => 'Grant Grundler',
@@ -371,10 +413,12 @@
 'gtoumi:laposte.net' => 'Ghozlane Toumi',
 'gwehrman:sgi.com' => 'Geoffrey Wehrman',
 'hadi:cyberus.ca' => 'Jamal Hadi Salim',
-'hannal:us.ibm.com' => 'Hanna Linder',
+'hannal:us.ibm.com' => 'Hanna V. Linder',
 'harald:gnumonks.org' => 'Harald Welte',
 'haveblue:us.ibm.com' => 'Dave Hansen',
 'hch:caldera.de' => 'Christoph Hellwig',
+'hch:com.rmk.(none)' => 'Christoph Hellwig',
+'hch:de.rmk.(none)' => 'Christoph Hellwig',
 'hch:dhcp212.munich.sgi.com' => 'Christoph Hellwig',
 'hch:hera.kernel.org' => 'Christoph Hellwig',
 'hch:infradead.org' => 'Christoph Hellwig',
@@ -394,7 +438,7 @@
 'hpa:zytor.com' => 'H. Peter Anvin',
 'hugh:veritas.com' => 'Hugh Dickins',
 'ica2_ts:csv.ica.uni-stuttgart.de' => 'Thiemo Seufer', # google
-'info:usblcd.de' =>  'Adams IT Services',
+'info:usblcd.de' => 'Adams IT Services',
 'ink:jurassic.park.msu.ru' => 'Ivan Kokshaysky',
 'ink:ru.rmk.(none)' => 'Ivan Kokshaysky',
 'ink:undisclosed.(none)' => 'Ivan Kokshaysky',
@@ -402,12 +446,13 @@
 'ionut:cs.columbia.edu' => 'Ion Badulescu',
 'ioshadij:hotmail.com' => 'Ishan O. Jayawardena',
 'irohlfs:irohlfs.de' => 'Ingo Rohlfs',
-'ishikawa:linux.or.jp' => 'Ishikawa Mutsumi',
+'ishikawa:linux.or.jp' => 'Mutsumi Ishikawa',
 'ivangurdiev:linuxfreemail.com' => 'Ivan Gyurdiev',
-'j-nomura:ce.jp.nec.com' => 'Jun\'ichi Nomura',
+'j-nomura:ce.jp.nec.com' => 'Junichi Nomura',
 'j.dittmer:portrix.net' => 'Jan Dittmer',
 'jack:suse.cz' => 'Jan Kara',
 'jack_hammer:adaptec.com' => 'Jack Hammer',
+'jackson:realtek.com.tw' => 'Ian Jackson',
 'jaharkes:cs.cmu.edu' => 'Jan Harkes',
 'jakob.kemi:telia.com' => 'Jakob Kemi',
 'jakub:redhat.com' => 'Jakub Jelínek',
@@ -424,6 +469,7 @@
 'jbarnes:sgi.com' => 'Jesse Barnes',
 'jbglaw:lug-owl.de' => 'Jan-Benedict Glaw',
 'jblack:linuxguru.net' => 'James Blackwell',
+'jbm:joshisanerd.com' => 'Josh Myer',
 'jdavid:farfalle.com' => 'David Ruggiero',
 'jdike:jdike.wstearns.org' => 'Jeff Dike',
 'jdike:karaya.com' => 'Jeff Dike',
@@ -431,6 +477,7 @@
 'jdr:farfalle.com' => 'David Ruggiero',
 'jdthood:yahoo.co.uk' => 'Thomas Hood',
 'jeb.j.cramer:intel.com' => 'Jeb J. Cramer',
+'jef:linuxbe.org' => 'Jean-Francois Dive',
 'jeff.wiedemeier:hp.com' => 'Jeff Wiedemeier',
 'jeffs:accelent.com' => 'Jeff Sutherland', # lbdb
 'jejb:malley.(none)' => 'James Bottomley',
@@ -445,12 +492,15 @@
 'jgarzik:redhat.com' => 'Jeff Garzik',
 'jgarzik:rum.normnet.org' => 'Jeff Garzik',
 'jgarzik:tout.normnet.org' => 'Jeff Garzik',
+'jgmyers:netscape.com' => 'John Myers',
 'jgrimm2:us.ibm.com' => 'Jon Grimm',
 'jgrimm:jgrimm.austin.ibm.com' => 'Jon Grimm', # google
 'jgrimm:touki.austin.ibm.com' => 'Jon Grimm', # google
 'jgrimm:touki.qip.austin.ibm.com' => 'Jon Grimm', # google
 'jh:sgi.com' => 'John Hesterberg',
 'jhammer:us.ibm.com' => 'Jack Hammer',
+'jhartmann:addoes.com' => 'Jeff Hartmann',
+'jkenisto:us.ibm.com' => 'James Keniston',
 'jkt:helius.com' => 'Jack Thomasson',
 'jmcmullan:linuxcare.com' => 'Jason McMullan',
 'jmorris:intercode.com.au' => 'James Morris',
@@ -463,11 +513,14 @@
 'joe:wavicle.org' => 'Joe Burks',
 'joel.buckley:sun.com' => 'Joel Buckley',
 'joergprante:netcologne.de' => 'Jörg Prante',
+'johan.adolfsson:axis.com' => 'Johan Adolfsson',
 'johann.deneux:it.uu.se' => 'Johann Deneux',
+'johann.deneux:laposte.net' => 'Johann Deneux',
 'johannes:erdfelt.com' => 'Johannes Erdfelt',
 'john:deater.net' => 'John Clemens',
 'john:grabjohn.com' => 'John Bradford',
 'john:larvalstage.com' => 'John Kim',
+'johnf:whitsunday.net.au' => 'John W Fort',
 'johnpol:2ka.mipt.ru' => 'Evgeniy Polyakov',
 'johnstul:us.ibm.com' => 'John Stultz',
 'josh:joshisanerd.com' => 'Josh Myer',
@@ -482,7 +535,7 @@
 'jt:hpl.hp.com' => 'Jean Tourrilhes',
 'jtyner:cs.ucr.edu' => 'John Tyner',
 'jun.nakajima:intel.com' => 'Jun Nakajima',
-'jung-ik.lee:intel.com' => 'J.I. Lee',
+'jung-ik.lee:intel.com' => 'Jung-Ik Lee',
 'jwoithe:physics.adelaide.edu.au' => 'Jonathan Woithe',
 'k-suganuma:mvj.biglobe.ne.jp' => 'Kimio Suganuma',
 'k.kasprzak:box43.pl' => 'Karol Kasprzak', # by Kristian Peters
@@ -494,6 +547,7 @@
 'kai:chaos.tp1.ruhr-uni-bochum.de' => 'Kai Germaschewski',
 'kai:tp1.ruhr-uni-bochum.de' => 'Kai Germaschewski',
 'kai:vaio.(none)' => 'Kai Germaschewski',
+'kai:zephyr.physics.uiowa.edu' => 'Kai Germaschewski',
 'kala:pinerecords.com' => 'Tomas Szepe',
 'kanoj:vger.kernel.org' => 'Kanoj Sarcar', # sent by Arnaldo Carvalho de Melo
 'kanojsarcar:yahoo.com' => 'Kanoj Sarcar',
@@ -501,10 +555,12 @@
 'kaos:sgi.com' => 'Keith Owens', # sent by himself
 'kare.sars:lmf.ericsson.se' => 'Kåre Särs',
 'kasperd:daimi.au.dk' => 'Kasper Dupont',
+'kaz:earth.email.ne.jp' => 'Kazuto Miyoshi',
 'keithu:parl.clemson.edu' => 'Keith Underwood',
 'kenneth.w.chen:intel.com' => 'Kenneth W. Chen',
 'kernel:jsl.com' => 'Jeffrey S. Laing',
 'kernel:steeleye.com' => 'Paul Clements',
+'kettenis:gnu.org' => 'Mark Kettenis',
 'key:austin.ibm.com' => 'Kent Yoder',
 'khaho:koti.soon.fi' => 'Ari Juhani Hämeenaho',
 'khalid:fc.hp.com' => 'Khalid Aziz',
@@ -512,6 +568,7 @@
 'khc:pm.waw.pl' => 'Krzysztof Halasa',
 'kiran:in.ibm.com' => 'Ravikiran G. Thirumalai',
 'kisza:sch.bme.hu' => 'Andras Kis-Szabo', # google (netfilter-ext HOWTO)
+'kkeil:isdn4linux.de' => 'Karsten Keil',
 'kkeil:suse.de' => 'Karsten Keil',
 'kmsmith:umich.edu' => 'Kendrick M. Smith',
 'knan:mo.himolde.no' => 'Erik Inge Bolsø',
@@ -539,11 +596,14 @@
 'levon:movementarian.org' => 'John Levon',
 'lfo:polyad.org' => 'Luis F. Ortiz',
 'linux:brodo.de' => 'Dominik Brodowski',
+'linux:de.rmk.(none)' => 'Dominik Brodowski',
 'linux:hazard.jcu.cz' => 'Jan Marek',
 'lionel.bouton:inet6.fr' => 'Lionel Bouton',
 'lists:mdiehl.de' => 'Martin Diehl',
 'liyang:nerv.cx' => 'Liyang Hu',
 'lm:bitmover.com' => 'Larry McVoy',
+'lm:work.bitmover.com' => 'Larry McVoy',
+'lopezp:grupocp.es' => 'Jose A. Lopez',
 'lord:sgi.com' => 'Stephen Lord',
 'louis.zhuang:linux.co.intel.com' => 'Louis Zhuang',
 'louisk:cse.unsw.edu.au' => 'Louis Yu-Kiu Kwan',
@@ -556,6 +616,7 @@
 'maalanen:ra.abo.fi' => 'Marcus Alanen',
 'mac:melware.de' => 'Armin Schindler',
 'macro:ds2.pg.gda.pl' => 'Maciej W. Rozycki',
+'makisara:abies.metla.fi' => 'Kai Makisara',
 'manand:us.ibm.com' => 'Mala Anand',
 'maneesh:in.ibm.com' => 'Maneesh Soni',
 'manfred:colorfullife.com' => 'Manfred Spraul',
@@ -569,12 +630,16 @@
 'marcelo:plucky.distro.conectiva' => 'Marcelo Tosatti',
 'marcus:ingate.com' => 'Marcus Sundberg',
 'marekm:amelek.gda.pl' => 'Marek Michalkiewicz',
+'marijnk:gmx.co.uk' => 'Marijn Kruisselbrink',
 'mark:alpha.dyndns.org' => 'Mark W. McClelland',
 'mark:hal9000.dyndns.org' => 'Mark W. McClelland',
 'markh:osdl.org' => 'Mark Haverkamp',
 'martin.bligh:us.ibm.com' => 'Martin J. Bligh',
+'martin.schwidefsky:debitel.net' => 'Martin Schwidefsky',
 'martin:bruli.net' => 'Martin Brulisauer',
+'martin:mdiehl.de' => 'Martin Diehl',
 'martin:meltin.net' => 'Martin Schwenke',
+'mashirle:us.ibm.com' => 'Shirley Ma',
 'mason:suse.com' => 'Chris Mason',
 'matt_domsch:dell.com' => 'Matt Domsch', # sent by himself
 'matthew:wil.cx' => 'Matthew Wilcox',
@@ -589,9 +654,11 @@
 'mdharm-scsi:one-eyed-alien.net' => 'Matthew Dharm',
 'mdharm-usb:one-eyed-alien.net' => 'Matthew Dharm',
 'mdharm:one-eyed-alien.net' => 'Matthew Dharm',
+'mdiehl:mdiehl.de' => 'Martin Diehl',
 'mec:shout.net' => 'Michael Elizabeth Chastain',
 'meissner:suse.de' => 'Marcus Meissner',
 'mgreer:mvista.com' => 'Mark A. Greer', # lbdb
+'mhopf:innominate.com' => 'Mark-André Hopf',
 'michaelw:foldr.org' => 'Michael Weber', # google
 'michal:harddata.com' => 'Michal Jaegermann',
 'mikael.starvik:axis.com' => 'Mikael Starvik',
@@ -605,8 +672,10 @@
 'miles:megapathdsl.net' => 'Miles Lane',
 'milli:acmeps.com' => 'Michael Milligan',
 'miltonm:bga.com' => 'Milton Miller', # by Kristian Peters
+'mingo:earth2.(none)' => 'Ingo Molnar',
 'mingo:elte.hu' => 'Ingo Molnar',
 'mingo:redhat.com' => 'Ingo Molnar',
+'mitch:sfgoth.com' => 'Mitchell Blank Jr.',
 'miyazawa:linux-ipv6.org' => 'Kazunori Miyazawa',
 'mj:ucw.cz' => 'Martin Mares',
 'mk:linux-ipv6.org' => 'Mitsuru Kanda',
@@ -618,7 +687,9 @@
 'mochel:geena.pdx.osdl.net' => 'Patrick Mochel',
 'mochel:osdl.org' => 'Patrick Mochel',
 'mochel:segfault.osdl.org' => 'Patrick Mochel',
+'mochel:segfault.osdlab.org' => 'Patrick Mochel',
 'mostrows:speakeasy.net' => 'Michal Ostrowski',
+'mostrows:watson.ibm.com' => 'Michal Ostrowski',
 'mporter:cox.net' => 'Matt Porter',
 'msdemlei:cl.uni-heidelberg.de' => 'Markus Demleitner',
 'msw:redhat.com' => 'Matt Wilson',
@@ -638,6 +709,8 @@
 'nico:cam.org' => 'Nicolas Pitre',
 'nicolas.aspert:epfl.ch' => 'Nicolas Aspert',
 'nicolas.mailhot:laposte.net' => 'Nicolas Mailhot',
+'niv:us.ibm.com' => 'Nivedita Singhvi',
+'nivedita:w-nivedita.beaverton.ibm.com' => 'Nivedita Singhvi',
 'nkbj:image.dk' => 'Niels Kristian Bech Jensen',
 'nlaredo:transmeta.com' => 'Nathan Laredo',
 'nmiell:attbi.com' => 'Nicholas Miell',
@@ -662,7 +735,9 @@
 'p.guehring:futureware.at' => 'Philipp Gühring',
 'p2:ace.ulyssis.sutdent.kuleuven.ac.be' => 'Peter De Shrijver',
 'p_gortmaker:yahoo.com' => 'Paul Gortmaker',
+'pablo:menichini.com.ar' => 'Pablo Menichini',
 'pam.delaney:lsil.com' => 'Pamela Delaney',
+'paschal:rcsis.com' => 'David Paschal',
 'pasky:ucw.cz' => 'Petr Baudis',
 'patmans:us.ibm.com' => 'Patrick Mansfield',
 'paubert:iram.es' => 'Gabriel Paubert',
@@ -670,9 +745,11 @@
 'paulkf:microgate.com' => 'Paul Fulghum',
 'paulm:routefree.com' => 'Paul Mielke',
 'paulus:au1.ibm.com' => 'Paul Mackerras',
+'paulus:cargo.(none)' => 'Paul Mackerras',
 'paulus:nanango.paulus.ozlabs.org' => 'Paul Mackerras',
 'paulus:quango.ozlabs.ibm.com' => 'Paul Mackerras',
 'paulus:samba.org' => 'Paul Mackerras',
+'paulus:tango.paulus.ozlabs.org' => 'Paul Mackerras',
 'pavel:janik.cz' => 'Pavel Janík',
 'pavel:suse.cz' => 'Pavel Machek',
 'pavel:ucw.cz' => 'Pavel Machek',
@@ -689,7 +766,9 @@
 'peter:chubb.wattle.id.au' => 'Peter Chubb',
 'peterc:gelato.unsw.edu.au' => 'Peter Chubb',
 'petero2:telia.com' => 'Peter Osterlund',
+'petkan:mastika.' => 'Petko Manolov',
 'petkan:mastika.dce.bg' => 'Petko Manolov',
+'petkan:mastika.lnxw.com' => 'Petko Manolov',
 'petkan:rakia.dce.bg' => 'Petko Manolov',
 'petkan:rakia.hell.org' => 'Petko Manolov',
 'petkan:tequila.dce.bg' => 'Petko Manolov',
@@ -698,8 +777,11 @@
 'petri.koistinen:iki.fi' => 'Petri Koistinen',
 'phillim2:comcast.net' => 'Mike Phillips',
 'pkot:linuxnews.pl' => 'Pawel Kot',
+'pkot:ziew.org' => 'Pawel Kot',
 'plars:austin.ibm.com' => 'Paul Larson',
+'plars:linuxtestproject.org' => 'Paul Larson',
 'plcl:telefonica.net' => 'Pedro Lopez-Cabanillas',
+'pmanolov:lnxw.com' => 'Petko Manolov',
 'pmenage:ensim.com' => 'Paul Menage',
 'porter:cox.net' => 'Matt Porter',
 'prom:berlin.ccc.de' => 'Ingo Albrecht',
@@ -722,6 +804,7 @@
 'reality:delusion.de' => 'Udo A. Steinberg',
 'reiser:namesys.com' => 'Hans Reiser',
 'rem:osdl.org' => 'Bob Miller',
+'rgcrettol@datacomm.ch' => 'Roger Crettol',
 'rgooch:atnf.csiro.au' => 'Richard Gooch',
 'rgooch:ras.ucalgary.ca' => 'Richard Gooch',
 'rgs:linalco.com' => 'Roberto Gordo Saez',
@@ -729,6 +812,7 @@
 'rhw:infradead.org' => 'Riley Williams',
 'richard.brunner:amd.com' => 'Richard Brunner',
 'riel:conectiva.com.br' => 'Rik van Riel',
+'riel:imladris.surriel.com' => 'Rik van Riel',
 'rjweryk:uwo.ca' => 'Rob Weryk',
 'rl:hellgate.ch' => 'Roger Luethi',
 'rlievin:free.fr' => 'Romain Lievin',
@@ -738,11 +822,12 @@
 'rob:osinvestor.com' => 'Rob Radez',
 'robert.olsson:data.slu.se' => 'Robert Olsson',
 'roehrich:sgi.com' => 'Dean Roehrich',
-'rohit.seth:intel.com' => 'Rohit Seth',
+'rohit.seth:intel.com' => 'Seth Rohit',
 'rol:as2917.net' => 'Paul Rolland',
 'roland:frob.com' => 'Roland McGrath',
 'roland:redhat.com' => 'Roland McGrath',
 'roland:topspin.com' => 'Roland Dreier',
+'romain.lievin:esisar.inpg.fr' => 'Romain Lievin',
 'romieu:cogenit.fr' => 'François Romieu',
 'romieu:fr.zoreil.com' => 'François Romieu',
 'root:viper.(none)' => 'Maxim Krasnyansky',
@@ -751,8 +836,10 @@
 'rth:are.twiddle.net' => 'Richard Henderson',
 'rth:dorothy.sfbay.redhat.com' => 'Richard Henderson',
 'rth:dot.sfbay.redhat.com' => 'Richard Henderson',
+'rth:fidel.sfbay.redhat.com' => 'Richard Henderson',
 'rth:kanga.twiddle.net' => 'Richard Henderson',
 'rth:splat.sfbay.redhat.com' => 'Richard Henderson',
+'rth:tigger.twiddle.net' => 'Richard Henderson',
 'rth:twiddle.net' => 'Richard Henderson',
 'rth:vsop.sfbay.redhat.com' => 'Richard Henderson',
 'rui.sousa:laposte.net' => 'Rui Sousa',
@@ -760,6 +847,7 @@
 'rvinson:mvista.com' => 'Randy Vinson',
 'rwhron:earthlink.net' => 'Randy Hron',
 'rz:linux-m68k.org' => 'Richard Zidlicky',
+'s.doyon:videotron.ca' => 'Stéphane Doyon',
 'sabala:students.uiuc.edu' => 'Michal Sabala', # google
 'sailer:scs.ch' => 'Thomas Sailer',
 'sam:mars.ravnborg.org' => 'Sam Ravnborg',
@@ -770,6 +858,7 @@
 'santiago:newphoenix.net' => 'Santiago A. Nullo', # sent by self
 'sarolaht:cs.helsinki.fi' => 'Pasi Sarolahti',
 'sawa:yamamoto.gr.jp' => 'sawa',
+'scameron:quandary.cca.cpqcorp.net' => 'Steve Cameron',
 'schoenfr:gaaertner.de' => 'Erik Schoenfelder',
 'schwab:suse.de' => 'Andreas Schwab',
 'schwidefsky:de.ibm.com' => 'Martin Schwidefsky',
@@ -791,6 +880,7 @@
 'silicon:falcon.sch.bme.hu' => 'Szilárd Pásztor', # google
 'simonb:lipsyncpost.co.uk' => 'Simon Burley',
 'skip.ford:verizon.net' => 'Skip Ford',
+'skyrelighten:yahoo.co.kr' => 'Donggyoo Lee',
 'sl:lineo.com' => 'Stuart Lynne',
 'smurf:osdl.org' => 'Nathan Dabney',
 'snailtalk:linux-mandrake.com' => 'Geoffrey Lee', # by himself
@@ -798,12 +888,14 @@
 'sparker:sun.com' => 'Steven Parker', # by Duncan Laurie
 'sprite:sprite.fr.eu.org' => 'Jeremie Koenig',
 'spse:secret.org.uk' => 'Simon Evans', # by Kristian Peters
+'src:flint.arm.linux.org.uk' => 'Russell King',
 'sri:us.ibm.com' => 'Sridhar Samudrala',
 'sridhar:dyn9-47-18-140.beaverton.ibm.com' => 'Sridhar Samudrala',
 'sridhar:dyn9-47-18-86.beaverton.ibm.com' => 'Sridhar Samudrala',
 'sridhar:x1-6-00-10-a4-8b-06-f6.attbi.com' => 'Sridhar Samudrala',
 'srompf:isg.de' => 'Stefan Rompf',
 'stanley.wang:linux.co.intel.com' => 'Stanley Wang',
+'stefan.eletzhofer:eletztrick.de' => 'Stefan Eletzhofer',
 'steiner:sgi.com' => 'Jack Steiner',
 'stekloff:w-stekloff.beaverton.ibm.com' => 'Daniel Stekloff',
 'stelian.pop:fr.alcove.com' => 'Stelian Pop',
@@ -813,10 +905,12 @@
 'steve.cameron:hp.com' => 'Stephen Cameron',
 'steve:chygwyn.com' => 'Steven Whitehouse',
 'steve:gw.chygwyn.com' => 'Steven Whitehouse',
-'steve:kbuxd.necst.nec.co.jp' => 'SL Baur',
+'steve:kbuxd.necst.nec.co.jp' => 'Steve Baur',
 'stevef:smfhome1.austin.rr.com' => 'Steve French',
 'stevef:steveft21.austin.ibm.com' => 'Steve French',
 'stevef:steveft21.ltcsamba' => 'Steve French',
+'stewart:inverse.wetlogic.net' => 'Paul Stewart',
+'stewart:wetlogic.net' => 'Paul Stewart',
 'stuartm:connecttech.com' => 'Stuart MacDonald',
 'sullivan:austin.ibm.com' => 'Mike Sullivan',
 'suncobalt.adm:hostme.bitkeeper.com' => 'Tim Hockin', # by Duncan Laurie
@@ -827,10 +921,10 @@
 't-kouchi:mvf.biglobe.ne.jp' => 'Takayoshi Kouchi',
 'tai:imasy.or.jp' => 'Taisuke Yamada',
 'taka:valinux.co.jp' => 'Hirokazu Takahashi',
-'tinglett:vnet.ibm.com' => 'Todd Inglett',
 'tao:acc.umu.se' => 'David Weinehall', # by himself
 'tao:kernel.org' => 'David Weinehall', # by himself
-'tcallawa:redhat.com' => 'Tom Callaway',
+'tapio:iptime.fi' => 'Tapio Laxström',
+'tcallawa:redhat.com' => "Tom 'spot' Callaway"
 'tetapi:utu.fi' => 'Tero Pirkkanen', # by Kristian Peters
 'th122948:scl1.sfbay.sun.com' => 'Tim Hockin', # by Duncan Laurie
 'th122948:scl3.sfbay.sun.com' => 'Tim Hockin', # by Duncan Laurie
@@ -838,24 +932,37 @@
 'thockin:freakshow.cobalt.com' => 'Tim Hockin',
 'thockin:sun.com' => 'Tim Hockin',
 'thomas:bender.thinknerd.de' => 'Thomas Walpuski',
+'thunder:ngforever.de' => 'Thunder From The Hill',
 'tigran:aivazian.name' => 'Tigran Aivazian',
 'tim:physik3.uni-rostock.de' => 'Tim Schmielau',
+'timw:splhi.com' => 'Tim Wright',
+'tinglett:vnet.ibm.com' => 'Todd Inglett',
+'tiwai:suse.de' => 'Takashi Iwai',
 'tmcreynolds:nvidia.com' => 'Tom McReynolds',
 'tmolina:cox.net' => 'Thomas Molina',
-'toml:us.ibm.com' => 'Tom Lendacky',
 'tomita:cinet.co.jp' => 'Osamu Tomita',
+'toml:us.ibm.com' => 'Tom Lendacky',
 'tomlins:cam.org' => 'Ed Tomlinson',
 'tony.luck:intel.com' => 'Tony Luck',
 'tony:cantech.net.au' => 'Anthony J. Breeds-Taurima',
+'torvalds:athlon.transmeta.com' => 'Linus Torvalds',
+'torvalds:home.transmeta.com' => 'Linus Torvalds',
+'torvalds:kiwi.transmeta.com' => 'Linus Torvalds',
+'torvalds:linux.local' => 'Linus Torvalds',
+'torvalds:penguin.transmeta.com' => 'Linus Torvalds',
+'torvalds:tove.transmeta.com' => 'Linus Torvalds',
+'torvalds:transmeta.com' => 'Linus Torvalds',
+'trevor.pering:intel.com' => 'Trevor Pering',
 'trini:bill-the-cat.bloom.county' => 'Tom Rini',
 'trini:kernel.crashing.org' => 'Tom Rini',
+'trini:opus.bloom.county' => 'Tom Rini',
 'trond.myklebust:fys.uio.no' => 'Trond Myklebust',
 'tvignaud:mandrakesoft.com' => 'Thierry Vignaud',
 'tvrtko:net4u.hr' => 'Tvrtko A. Ursulin',
 'twaugh:redhat.com' => 'Tim Waugh',
-'tytso:mit.edu' => "Theodore Ts'o", # web.mit.edu/tytso/www/home.html
-'tytso:snap.thunk.org' => "Theodore Ts'o",
-'tytso:think.thunk.org' => "Theodore Ts'o", # guessed
+'tytso:mit.edu' => "Theodore Y. T'so" # web.mit.edu/tytso/www/home.html
+'tytso:snap.thunk.org' => "Theodore Y. T'so"
+'tytso:think.thunk.org' => "Theodore Y. T'so" # guessed
 'urban:teststation.com' => 'Urban Widmark',
 'uzi:uzix.org' => 'Joshua Uziel',
 'valko:linux.karinthy.hu' => 'Laszlo Valko',
@@ -869,9 +976,11 @@
 'vojtech:suse.cz' => 'Vojtech Pavlik',
 'vojtech:twilight.ucw.cz' => 'Vojtech Pavlik',
 'vojtech:ucw.cz' => 'Vojtech Pavlik', # added by himself
+'vs:tribesman.namesys.com' => 'Vladimir Saveliev',
 'wa:almesberger.net' => 'Werner Almesberger',
 'wahrenbruch:kobil.de' => 'Thomas Wahrenbruch',
 'warlord:mit.edu' => 'Derek Atkins',
+'wayne:stallion.oz.au' => 'Wayne Piekarski',
 'wd:denx.de' => 'Wolfgang Denk',
 'weigand:immd1.informatik.uni-erlangen.de' => 'Ulrich Weigand',
 'wes:infosink.com' => 'Wes Schreiner',
@@ -900,8 +1009,10 @@
 'zinx:epicsol.org' => 'Zinx Verituse',
 'zippel:linux-m68k.org' => 'Roman Zippel',
 'zubarev:us.ibm.com' => 'Irene Zubarev', # google
+'zw:superlucidity.net' => 'Zach Welch',
 'zwane:commfireservices.com' => 'Zwane Mwaikambo',
 'zwane:holomorphy.com' => 'Zwane Mwaikambo',
+'zwane:linux.realnet.co.sz' => 'Zwane Mwaikambo',
 'zwane:linuxpower.ca' => 'Zwane Mwaikambo',
 'zwane:mwaikambo.name' => 'Zwane Mwaikambo',
 '~~~~~~thisentrylastforconvenience~~~~~' => 'Cesar Brutus Anonymous'


-- 
Zack Brown
