Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264030AbTEON7X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 09:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264035AbTEON7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 09:59:23 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:14862 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S264030AbTEON7M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 09:59:12 -0400
MIME-Version: 1.0
To: torvalds@transmeta.com
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Thu_May_15_14_11_53_UTC_2003_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20030515141153.EE3BB88318@merlin.emma.line.org>
Date: Thu, 15 May 2003 16:11:53 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use bk receive to patch this mail, you can pull from
bk://krusty.dt.e-technik.uni-dortmund.de  (NOTE: no trailing slash)
or you can apply the patch below.

Patch description:
Another set of 35 new addresses. Please merge.

Matthias
##### DIFFSTAT #####
# shortlog |   78 +++++++++++++++++++++++++++++++++++++++++--
# 1 files changed, 75 insertions(+), 3 deletions(-)

##### GNUPATCH #####
# This is a BitKeeper generated patch for the following project:
# Project Name: BK kernel tools
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.51    -> 1.52   
#	            shortlog	1.25    -> 1.26   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/15	matthias.andree@gmx.de	1.52
# 35 new addresses.
# added comment about the addresses_handled_in_regexp
# report status of selftest
# (upstream udpate 0.106->0.116)
# --------------------------------------------
#
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Thu May 15 16:11:53 2003
+++ b/shortlog	Thu May 15 16:11:53 2003
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.106 2003/04/28 23:00:49 emma Exp $
+# $Id: lk-changelog.pl,v 0.116 2003/05/15 08:52:06 vita Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -99,7 +99,11 @@
 'torvalds:transmeta.com' => 'Linus Torvalds',
 '###############################' => '###############'
 );
-
+# Above is the list of addresses that are now matched by regexps,
+# it is not used by _this_ script (ourselves), but Zack Brown has
+# scripts that parse this code to get developer addresses, so we keep
+# them around. As we don't need it, we just kill it. (We use the same
+# syntax as for the regular address hash for ease of use.)
 undef @addresses_handled_in_regexp;
 
 my %addresses = (
@@ -147,9 +151,11 @@
 'alborchers:steinerpoint.com' => 'Al Borchers',
 'alex:ssi.bg' => 'Alexander Atanasov',
 'alex_williamson:attbi.com' => 'Alex Williamson', # lbdb
+'alex_williamson:com.rmk.(none)' => 'Alex Williamson',
 'alex_williamson:hp.com' => 'Alex Williamson', # google
 'alexander.riesen:synopsys.com' => 'Alexander Riesen',
 'alexander.schulz:innominate.com' => 'Alexander Schulz',
+'alexander.schulz:com.rmk.(none)' => 'Alexander Schulz',
 'alexey:technomagesinc.com' => 'Alex Tomas',
 'alfre:ibd.es' => 'Alfredo Sanjuán',
 'ambx1:neo.rr.com' => 'Adam Belay',
@@ -180,6 +186,7 @@
 'arun.sharma:intel.com' => 'Arun Sharma',
 'asit.k.mallick:intel.com' => 'Asit K. Mallick', # by Kristian Peters
 'asl:launay.org' => 'Arnaud S. Launay',
+'atulm:lsil.com' => 'Atul Mukker',
 'axboe:burns.home.kernel.dk' => 'Jens Axboe', # guessed
 'axboe:hera.kernel.org' => 'Jens Axboe',
 'axboe:suse.de' => 'Jens Axboe',
@@ -203,8 +210,10 @@
 'beattie:beattie-home.net' => 'Brian Beattie', # from david.nelson
 'benh:kernel.crashing.org' => 'Benjamin Herrenschmidt',
 'benh:zion.wanadoo.fr' => 'Benjamin Herrenschmidt',
+'bergner:brule.rchland.ibm.com' => 'Peter Bergner',
 'bergner:cannon.rchland.ibm.com' => 'Peter Bergner',
 'bergner:vnet.ibm.com' => 'Peter Bergner',
+'bernhard.kaindl:gmx.de' => 'Bernhard Kaindl',
 'berny.f:aon.at' => 'Bernhard Fischer',
 'bero:arklinux.org' => 'Bernhard Rosenkraenzer',
 'bfennema:falcon.csc.calpoly.edu' => 'Ben Fennema',
@@ -240,6 +249,7 @@
 'cananian:lesser-magoo.lcs.mit.edu' => 'C. Scott Ananian',
 'cattelan:sgi.com' => 'Russell Cattelan', # google
 'ccaputo:alt.net' => 'Chris Caputo',
+'ccheney:cheney.cx' => 'Christopher L. Cheney',
 'cel:citi.umich.edu' => 'Chuck Lever',
 'celso:bulma.net' => 'Celso González', # google
 'ch:com.rmk.(none)' => 'Christopher Hoover',
@@ -293,6 +303,7 @@
 'dana.lacoste:peregrine.com' => 'Dana Lacoste',
 'danc:mvista.com' => 'Dan Cox', # some CREDITS patch found by google
 'daniel.ritz:gmx.ch' => 'Daniel Ritz',
+'daniel:osdl.org' => 'Daniel McNeil',
 'dank:kegel.com' => 'Dan Kegel',
 'dave:qix.net' => 'Dave Maietta',
 'dave:thedillows.org' => 'David Dillow',
@@ -322,6 +333,7 @@
 'dbrownell:users.sourceforge.net' => 'David Brownell',
 'ddstreet:ieee.org' => 'Dan Streetman',
 'ddstreet:us.ibm.com' => 'Dan Streetman',
+'dean:arctic.org' => 'Dean Gaudet',
 'defouwj:purdue.edu' => 'Jeff DeFouw',
 'dent:cosy.sbg.ac.at' => "Thomas 'Dent' Mirlacher",
 'derek:ihtfp.com' => 'Derek Atkins',
@@ -344,6 +356,7 @@
 'dledford:redhat.com' => 'Doug Ledford',
 'dlstevens:us.ibm.com' => 'David Stevens',
 'dmccr:us.ibm.com' => 'Dave McCracken',
+'dmo:osdl.org' => 'Dave Olien',
 'dok:directfb.org' => 'Denis Oliver Kropp',
 'dougg:torque.net' => 'Douglas Gilbert',
 'drepper:redhat.com' => 'Ulrich Drepper',
@@ -405,6 +418,7 @@
 'ganadist:nakyup.mizi.com' => 'Cha Young-Ho',
 'gandalf:netfilter.org' => 'Martin Josefsson',
 'gandalf:wlug.westbo.se' => 'Martin Josefsson',
+'ganesh.venkatesan:intel.com' => 'Ganesh Venkatesan',
 'ganesh:tuxtop.vxindia.veritas.com' => 'Ganesh Varadarajan',
 'ganesh:veritas.com' => 'Ganesh Varadarajan',
 'ganesh:vxindia.veritas.com' => 'Ganesh Varadarajan',
@@ -420,6 +434,7 @@
 'gibbs:overdrive.btc.adaptec.com' => 'Justin T. Gibbs',
 'gibbs:scsiguy.com' => 'Justin T. Gibbs',
 'gilbertd:treblig.org' => 'Dr. David Alan Gilbert',
+'gj:pointblue.com.pl' => 'Grzegorz Jaskiewicz',
 'gl:dsa-ac.de' => 'Guennadi Liakhovetski',
 'glee:gnupilgrims.org' => 'Geoffrey Lee', # lbdb
 'gnb:alphalink.com.au' => 'Greg Banks',
@@ -455,6 +470,7 @@
 'hch:pentafluge.infradead.org' => 'Christoph Hellwig',
 'hch:sb.bsdonline.org' => 'Christoph Hellwig', # by Kristian Peters
 'hch:sgi.com' => 'Christoph Hellwig',
+'heiko.carstens:de.ibm.com' => 'Heiko Carstens',
 'helgaas:fc.hp.com' => 'Bjorn Helgaas', # doesn't want ø/å
 'henning:meier-geinitz.de' => 'Henning Meier-Geinitz',
 'henrique2.gobbi:cyclades.com' => 'Henrique Gobbi',
@@ -488,6 +504,7 @@
 'jamagallon:able.es' => 'J. A. Magallon',
 'james.bottomley:steeleye.com' => 'James Bottomley',
 'james:cobaltmountain.com' => 'James Mayer',
+'james:superbug.demon.co.uk' => 'James Courtier-Dutton',
 'james_mcmechan:hotmail.com' => 'James McMechan',
 'jamey.hicks:hp.com' => 'Jamey Hicks',
 'jamey:crl.dec.com' => 'Jamey Hicks',
@@ -526,6 +543,8 @@
 'jgarzik:tout.normnet.org' => 'Jeff Garzik',
 'jgmyers:netscape.com' => 'John Myers',
 'jgrimm2:us.ibm.com' => 'Jon Grimm',
+'jgrimm:death.austin.ibm.com' => 'Jon Grimm',
+'jgrimm:jgrimm.(none)' => 'Jon Grimm',
 'jgrimm:jgrimm.austin.ibm.com' => 'Jon Grimm', # google
 'jgrimm:touki.austin.ibm.com' => 'Jon Grimm', # google
 'jgrimm:touki.qip.austin.ibm.com' => 'Jon Grimm', # google
@@ -589,6 +608,7 @@
 'kare.sars:lmf.ericsson.se' => 'Kåre Särs',
 'kasperd:daimi.au.dk' => 'Kasper Dupont',
 'kaz:earth.email.ne.jp' => 'Kazuto Miyoshi',
+'kazunori:miyazawa.org' => 'Kazunori Miyazawa',
 'keithu:parl.clemson.edu' => 'Keith Underwood',
 'kenneth.w.chen:intel.com' => 'Kenneth W. Chen',
 'kernel:jsl.com' => 'Jeffrey S. Laing',
@@ -616,6 +636,7 @@
 'kunihiro:ipinfusion.com' => 'Kunihiro Ishiguro',
 'kuznet:mops.inr.ac.ru' => 'Alexey Kuznetsov',
 'kuznet:ms2.inr.ac.ru' => 'Alexey Kuznetsov',
+'l.s.r:web.de' => 'René Scharfe',
 'ladis:psi.cz' => 'Ladislav Michl',
 'laforge:gnumonks.org' => 'Harald Welte',
 'laforge:netfilter.org' => 'Harald Welte',
@@ -632,6 +653,7 @@
 'linux:brodo.de' => 'Dominik Brodowski',
 'linux:de.rmk.(none)' => 'Dominik Brodowski',
 'linux:hazard.jcu.cz' => 'Jan Marek',
+'linux-usb:gemeinhardt.info' => 'Lars Gemeinhardt',
 'lionel.bouton:inet6.fr' => 'Lionel Bouton',
 'lists:mdiehl.de' => 'Martin Diehl',
 'liyang:nerv.cx' => 'Liyang Hu',
@@ -700,6 +722,7 @@
 'mikael.starvik:axis.com' => 'Mikael Starvik',
 'mikal:stillhq.com' => 'Michael Still',
 'mike:aiinc.ca' => 'Michael Hayes',
+'mikenc:us.ibm.com' => 'Mike Christie',
 'mikep:linuxtr.net' => 'Mike Phillips',
 'mikpe:csd.uu.se' => 'Mikael Pettersson',
 'mikpe:user.it.uu.se' => 'Mikael Pettersson',
@@ -747,6 +770,7 @@
 'nico:cam.org' => 'Nicolas Pitre',
 'nico:org.rmk.(none)' => 'Nicolas Pitre',
 'nicolas.aspert:epfl.ch' => 'Nicolas Aspert',
+'nicolas:dupeux.net' => 'Nicolas Dupeux',
 'nicolas.mailhot:laposte.net' => 'Nicolas Mailhot',
 'niv:us.ibm.com' => 'Nivedita Singhvi',
 'nivedita:w-nivedita.beaverton.ibm.com' => 'Nivedita Singhvi',
@@ -754,6 +778,7 @@
 'nlaredo:transmeta.com' => 'Nathan Laredo',
 'nmiell:attbi.com' => 'Nicholas Miell',
 'nobita:t-online.de' => 'Andreas Busch',
+'nstraz:sgi.com' => 'Nathan Straz',
 'okir:suse.de' => 'Olaf Kirch', # lbdb
 'okurth:gmx.net' => 'Oliver Kurth',
 'olaf.dietsche#list.linux-kernel:t-online.de' => 'Olaf Dietsche',
@@ -766,6 +791,7 @@
 'oliver:neukum.name' => 'Oliver Neukum',
 'oliver:neukum.org' => 'Oliver Neukum',
 'oliver:oenone.homelinux.org' => 'Oliver Neukum',
+'olof:austin.ibm.com' => 'Olof Johansson',
 'orjan.friberg:axis.com' => 'Orjan Friberg',
 'os:emlix.com' => 'Oskar Schirmer', # sent by himself
 'osst:riede.org' => 'Willem Riede',
@@ -797,6 +823,7 @@
 'pdelaney:lsil.com' => 'Pam Delaney',
 'pe1rxq:amsat.org' => 'Jeroen Vreeken',
 'pekon:informatics.muni.cz' => 'Petr Konecny',
+'per.winkvist:telia.com' => 'Per Winkvist',
 'perex:perex.cz' => 'Jaroslav Kysela',
 'perex:pnote.perex-int.cz' => 'Jaroslav Kysela',
 'perex:suse.cz' => 'Jaroslav Kysela',
@@ -814,6 +841,8 @@
 'petkan:users.sourceforge.net' => 'Petko Manolov',
 'petr:vandrovec.name' => 'Petr Vandrovec',
 'petri.koistinen:iki.fi' => 'Petri Koistinen',
+'petrides:redhat.com' => 'Ernie Petrides',
+'philipp:void.at' => 'Philipp Friedrich',
 'phillim2:comcast.net' => 'Mike Phillips',
 'pkot:linuxnews.pl' => 'Pawel Kot',
 'pkot:ziew.org' => 'Pawel Kot',
@@ -823,15 +852,18 @@
 'pmanolov:lnxw.com' => 'Petko Manolov',
 'pmenage:ensim.com' => 'Paul Menage',
 'porter:cox.net' => 'Matt Porter',
+'ppc64:brule.rchland.ibm.com' => 'Peter Bergner',
 'prom:berlin.ccc.de' => 'Ingo Albrecht',
 'proski:gnu.org' => 'Pavel Roskin',
 'proski:org.rmk.(none)' => 'Pavel Roskin',
 'pwaechtler:mac.com' => 'Peter Wächtler',
 'quinlan:transmeta.com' => 'Daniel Quinlan',
 'quintela:mandrakesoft.com' => 'Juan Quintela',
+'r.a.mercer:blueyonder.co.uk' => 'Adam Mercer',
 'r.e.wolff:bitwizard.nl' => 'Rogier Wolff', # lbdbq
 'ralf:dea.linux-mips.net' => 'Ralf Bächle',
 'ralf:linux-mips.org' => 'Ralf Bächle',
+'ralphs:org.rmk.(none)' => 'Ralph Siemsen',
 'ramune:net-ronin.org' => 'Daniel A. Nobuto',
 'randolph:tausq.org' => 'Randolph Chung',
 'randy.dunlap:verizon.net' => 'Randy Dunlap',
@@ -879,6 +911,7 @@
 'rth:are.twiddle.net' => 'Richard Henderson',
 'rth:dorothy.sfbay.redhat.com' => 'Richard Henderson',
 'rth:dot.sfbay.redhat.com' => 'Richard Henderson',
+'rth:eeyore.twiddle.net' => 'Richard Henderson',
 'rth:fidel.sfbay.redhat.com' => 'Richard Henderson',
 'rth:kanga.twiddle.net' => 'Richard Henderson',
 'rth:splat.sfbay.redhat.com' => 'Richard Henderson',
@@ -886,6 +919,7 @@
 'rth:twiddle.net' => 'Richard Henderson',
 'rth:vsop.sfbay.redhat.com' => 'Richard Henderson',
 'rui.sousa:laposte.net' => 'Rui Sousa',
+'rusty:linux.co.intel.com' => 'Rusty Lynch',
 'rusty:rustcorp.com.au' => 'Rusty Russell',
 'rvinson:mvista.com' => 'Randy Vinson',
 'rwhron:earthlink.net' => 'Randy Hron',
@@ -926,6 +960,7 @@
 'skip.ford:verizon.net' => 'Skip Ford',
 'skyrelighten:yahoo.co.kr' => 'Donggyoo Lee',
 'sl:lineo.com' => 'Stuart Lynne',
+'smb:smbnet.de' => 'Stefan M. Brandl',
 'smurf:osdl.org' => 'Nathan Dabney',
 'snailtalk:linux-mandrake.com' => 'Geoffrey Lee', # by himself
 'solar:openwall.com' => 'Solar Designer',
@@ -994,6 +1029,7 @@
 'tomlins:cam.org' => 'Ed Tomlinson',
 'tony.luck:intel.com' => 'Tony Luck',
 'tony:cantech.net.au' => 'Anthony J. Breeds-Taurima',
+'torben.mathiasen:hp.com' => 'Torben Mathiasen',
 'torvalds:linux.local' => 'Linus Torvalds',
 'trevor.pering:intel.com' => 'Trevor Pering',
 'trini:bill-the-cat.bloom.county' => 'Tom Rini',
@@ -1008,12 +1044,14 @@
 'tytso:think.thunk.org' => "Theodore Y. T'so", # guessed
 'urban:teststation.com' => 'Urban Widmark',
 'uzi:uzix.org' => 'Joshua Uziel',
+'valdis.kletnieks:vt.edu' => 'Valdis Kletnieks',
 'valko:linux.karinthy.hu' => 'Laszlo Valko',
 'vandrove:vc.cvut.cz' => 'Petr Vandrovec',
 'vanl:megsinet.net' => 'Martin H. VanLeeuwen',
 'varenet:parisc-linux.org' => 'Thibaut Varene',
 'vberon:mecano.gme.usherb.ca' => 'Vincent Béron',
 'venkatesh.pallipadi:intel.com' => 'Venkatesh Pallipadi',
+'vinay-rc:naturesoft.net' => 'Vinay K. Nallamothu',
 'viro:math.psu.edu' => 'Alexander Viro',
 'viro:parcelfarce.linux.theplanet.co.uk' => 'Alexander Viro',
 'viro:www.linux.org.uk' => 'Alexander Viro',
@@ -1025,6 +1063,7 @@
 'wa:almesberger.net' => 'Werner Almesberger',
 'wahrenbruch:kobil.de' => 'Thomas Wahrenbruch',
 'warlord:mit.edu' => 'Derek Atkins',
+'warp:mercury.d2dc.net' => 'Zephaniah E. Hull',
 'wayne:stallion.oz.au' => 'Wayne Piekarski',
 'wd:denx.de' => 'Wolfgang Denk',
 'weigand:immd1.informatik.uni-erlangen.de' => 'Ulrich Weigand',
@@ -1034,6 +1073,7 @@
 'whitney:math.berkeley.edu' => 'Wayne Whitney',
 'whydoubt:yahoo.com' => 'Jeff Smith',
 'will:sowerbutts.com' => 'William R. Sowerbutts',
+'willschm:us.ibm.com' => 'Will Schmidt',
 'willy:debian.org' => 'Matthew Wilcox',
 'willy:fc.hp.com' => 'Matthew Wilcox',
 'willy:w.ods.org' => 'Willy Tarreau',
@@ -1597,7 +1637,9 @@
 }
 
 if ($opt{selftest}) {
-    exit selftest;
+    my $rc = selftest();
+    printf "selftest %s.\n", $rc ? "failed" : "passed";
+    exit $rc;
 }
 
 # Main program
@@ -1648,6 +1690,36 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.116  2003/05/15 08:52:06  vita
+# added 4 names for new addresses
+#
+# Revision 0.115  2003/05/12 10:16:48  vita
+# added 3 names for new addresses
+#
+# Revision 0.114  2003/05/08 10:35:41  vita
+# added 5 names for new addresses
+#
+# Revision 0.113  2003/05/07 09:30:03  vita
+# added 3 names for new addresses
+#
+# Revision 0.112  2003/05/06 15:46:15  vita
+# added 3 names for new addresses
+#
+# Revision 0.111  2003/05/05 08:55:16  vita
+# added 3 names for new addresses
+#
+# Revision 0.110  2003/05/02 14:53:22  vita
+# added 6 names for new addresses
+#
+# Revision 0.109  2003/04/29 10:20:09  vita
+# added 8 names for new addresses
+#
+# Revision 0.108  2003/04/28 23:26:08  emma
+# Add explanation why we define an array just to undefine it right away.
+#
+# Revision 0.107  2003/04/28 23:18:37  emma
+# Report status of selftest.
+#
 # Revision 0.106  2003/04/28 23:00:49  emma
 # Correct Vincent Legoll's name (was confused with somebody else).
 #

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.52
## Wrapped with gzip_uu ##


begin 600 bkpatch13935
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
K.[IO-LI8,MJ:O?S6MR-'M?VO"8UZ^=RT]4F23K-!'(UZ?P.\^K-QLA$`````
`
end

