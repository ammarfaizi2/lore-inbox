Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263244AbVCKKWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263244AbVCKKWa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 05:22:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263256AbVCKKWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 05:22:30 -0500
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:41151 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S263244AbVCKKVn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 05:21:43 -0500
MIME-Version: 1.0
To: torvalds@osdl.org
Subject: BK-kernel-tools/shortlog update
CC: matthias.andree@gmx.de, samel@mail.cz, linux-kernel@vger.kernel.org
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Fri,_11_Mar_2005_10_21_37_+0000_0@merlin.emma.line.org>
Content-Type: text/plain; charset=US-ASCII
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 7BIT
Message-Id: <20050311102137.4D8C088D96@merlin.emma.line.org>
Date: Fri, 11 Mar 2005 11:21:37 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK parent: http://bktools.bkbits.net/bktools

Patch description:
ChangeSet@1.289, 2005-03-11 11:18:49+01:00, matthias.andree@gmx.de
  add 8 new address -> name pairs, change 2 names

ChangeSet@1.288, 2005-03-11 11:12:45+01:00, matthias.andree@gmx.de
  tighten up regexp matching

ChangeSet@1.287, 2005-03-11 11:06:19+01:00, matthias.andree@gmx.de
  Cset exclude: samel@mail.cz|ChangeSet|20050310150048|63716

ChangeSet@1.286, 2005-03-10 17:39:07+01:00, samel@mail.cz
  shortlog: add one address -> name translation

ChangeSet@1.285, 2005-03-10 17:37:51+01:00, samel@mail.cz
  shortlog: fix davej's regexp

ChangeSet@1.284, 2005-03-10 16:00:48+01:00, samel@mail.cz
  shortlog: change @addrregexps to match exactly the whole address

ChangeSet@1.283, 2005-03-10 15:55:43+01:00, samel@mail.cz
  shortlog: move davem@(.*).davemloft.net addresses into regexps

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
 shortlog |   22 ++++++++++++++--------
 1 files changed, 14 insertions(+), 8 deletions(-)

##### GNUPATCH #####
--- 1.247/shortlog	2005-03-09 11:11:20 +01:00
+++ 1.255/shortlog	2005-03-11 11:18:49 +01:00
@@ -77,8 +77,9 @@
 [ 'alan@[^.]+\.swansea\.linux\.org\.uk' => 'Alan Cox', ],
 [ 'bos@([^.]+\.)?serpentine\.com' => 'Bryan O\'Sullivan', ],
 [ 'chas@([^.]+\.)*nrl\.navy\.mil' => 'Chas Williams', ],
-[ 'davej@(.*\.)?codemonkey\W' => 'Dave Jones', ],
+[ 'davej@(.*\.)?codemonkey\.or(g\.uk?)?' => 'Dave Jones', ],
 [ 'davem@[^.]+\.ninka\.net' => 'David S. Miller', ],
+[ 'davem@([^.]+\.)*davemloft\.net' => 'David S. Miller', ],
 [ 'kuznet@[^.]+\.inr\.ac\.ru' => 'Alexey Kuznetsov', ],
 [ 'torvalds@([^.]+\.)?transmeta\.com' => 'Linus Torvalds', ],
 [ 'torvalds@([^.]+\.)?osdl\.org' => 'Linus Torvalds', ],
@@ -178,8 +179,9 @@
 'adam:os.inf.tu-dresden.de' => 'Adam Lackorzynski',
 'adam:skullslayer.rod.org' => 'Adam Bernau',
 'adam:yggdrasil.com' => 'Adam J. Richter',
-'adaplas:hotpop.com' => 'Antonino Daplas',
-'adaplas:pol.net' => 'Antonino Daplas',
+'adaplas:gawab.com' => 'Antonino A. Daplas', # guessed
+'adaplas:hotpop.com' => 'Antonino A. Daplas',
+'adaplas:pol.net' => 'Antonino A. Daplas',
 'aderesch:fs.tum.de' => 'Andreas Deresch',
 'adi:drcomp.erfurt.thur.de' => 'Adrian Knoth',
 'adilger:clusterfs.com' => 'Andreas Dilger',
@@ -233,6 +235,7 @@
 'akpm:osdl.org' => 'Andrew Morton', # guessed
 'akpm:reardensteel.com' => 'Andrew Morton',
 'akpm:zip.com.au' => 'Andrew Morton',
+'akropel:rochester.rr.com' => 'Adam Kropelin', # guessed
 'akropel1:rochester.rr.com' => 'Adam Kropelin', # lbdb
 'al.fracchetti:tin.it' => 'Alessandro Fracchetti',
 'alain.knaff:lll.lu' => 'Alain Knaff',
@@ -673,12 +676,9 @@
 'davej:suse.de' => 'Dave Jones',
 'davej:tetrachloride.(none)' => 'Dave Jones',
 'davem:cheetah.(none)' => 'David S. Miller',
-'davem:davemloft.net' => 'David S. Miller',
 'davem:hera.kernel.org' => 'David S. Miller',
 'davem:kernel.bkbits.net' => 'David S. Miller',
 'davem:netfilter.org' => 'David S. Miller',
-'davem:northbeach.davemloft.net.davemloft.net' => 'David S. Miller',
-'davem:nuts.davemloft.net' => 'David S. Miller',
 'davem:redhat.co' => 'David S. Miller',
 'davem:redhat.com' => 'David S. Miller',
 'david-b:net.rmk.(none)' => 'David Brownell',
@@ -727,10 +727,12 @@
 'devenyga:mcmaster.ca' => 'Gabriel Devenyi',
 'devik:cdi.cz' => 'Martin Devera',
 'dfages:arkoon.net' => 'Daniel Fages',
+'dfarnsworth.adm:bkbits.net' => 'Dale Farnsworth', # guessed
 'dfarnsworth:mvista.com' => 'Dale Farnsworth',
 'dfries:mail.win.org' => 'David Fries',
 'dgc:sgi.com' => 'David Chinner',
 'dgibson:samba.org' => 'David Gibson',
+'dgoeddel:trustedcs.com' => 'Darrel Goeddel',
 'dhinds:sonic.net' => 'David Hinds', # google
 'dhollis:davehollis.com' => 'David T. Hollis',
 'dhowells:cambridge.redhat.com' => 'David Howells',
@@ -953,6 +955,7 @@
 'galak:freescale.com' => 'Kumar Gala',
 'galak:linen.sps.mot.com' => 'Kumar Gala',
 'galak:somerset.sps.mot.com' => 'Kumar Gala',
+'gam3:gam3.net' => 'G. Allen Morris III',
 'gamal:alternex.com.br' => 'Haroldo Gamal',
 'ganadist:nakyup.mizi.com' => 'Cha Young-Ho',
 'gandalf:netfilter.org' => 'Martin Josefsson',
@@ -1483,6 +1486,7 @@
 'kirillx:7ka.mipt.ru' => 'Kirill Korotaev',
 'kishoreak:myw.ltindia.com' => 'Kishore A K',
 'kisza:sch.bme.hu' => 'Andras Kis-Szabo', # google (netfilter-ext HOWTO)
+'kjhall:us.ibm.com' => 'Kylene Hall',
 'kkeil:isdn4linux.de' => 'Karsten Keil',
 'kkeil:suse.de' => 'Karsten Keil',
 'kkourt:cslab.ece.ntua.gr' => 'Kornilios Kourtis',
@@ -1636,6 +1640,8 @@
 'luc.vanoostenryck:easynet.be' => 'Luc Van Oostenryck', # lbdb
 'luca.risolia:studio.unibo.it' => 'Luca Risolia',
 'luca:libero.it' => 'Luca Risolia',
+'lucasvr:gobolinux.org' => 'Lucas Correia Villa Real',
+'lucasvr:org.rmk.(none)' => 'Lucas Correia Villa Real',
 'lucasvr:terra.com.br' => 'Lucas Correia Villa Real', # google
 'luming.yu:intel.com' => 'Luming Yu',
 'lunz:falooley.org' => 'Jason Lunz',
@@ -2871,7 +2877,7 @@
     # try matching against all regexps in listed order
     # return result if any
     foreach my $ar (@addrregexps) {
-	if ($in =~ m/$ar->[0]/) {
+	if ($in =~ m/^$ar->[0]$/) {
 	    return $ar->[1];
 	}
     }
@@ -3453,7 +3459,7 @@
     }
     foreach my $address (unveil keys %addresses) {
 	foreach my $ar (@addrregexps) {
-	    if ($address =~ m/$ar->[0]/) {
+	    if ($address =~ m/^$ar->[0]$/) {
 		print STDERR "Warning: address '$address'\n";
 		print STDERR "  shadows regexp '$ar->[0]'\n";
 		$rc = 1;



##### BKPATCH #####

## Wrapped with gzip_b64 ##
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
+wf7LhpILB0AAA==

