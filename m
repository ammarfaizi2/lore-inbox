Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266344AbUGPNwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266344AbUGPNwY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 09:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266349AbUGPNwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 09:52:24 -0400
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:45448 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S266344AbUGPNv5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 09:51:57 -0400
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Fri_Jul_16_13_51_52_UTC_2004_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20040716135152.A786BC3DAB@merlin.emma.line.org>
Date: Fri, 16 Jul 2004 15:51:52 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:
ChangeSet@1.205, 2004-07-16 14:51:37+02:00, matthias.andree@gmx.de
  Bugfix: do not strip Kishore A K -> K A. Reported by vita.

ChangeSet@1.204, 2004-07-16 13:52:51+02:00, matthias.andree@gmx.de
  vita: 11 new addresses

ChangeSet@1.203, 2004-07-12 15:37:44+02:00, matthias.andree@gmx.de
  vita: 2 new addresses, 1 correction

ChangeSet@1.202, 2004-07-12 12:37:38+02:00, matthias.andree@gmx.de
  Fix one address to ISO-8859-1, drop one bogus entry.
  Reported by vita.

ChangeSet@1.201, 2004-07-12 11:04:45+02:00, matthias.andree@gmx.de
  * Implement address precedence logic
  * If the LINUXKERNEL_BK_FMT_DEBUG environment variable is non-empty, enter debug mode.

ChangeSet@1.200, 2004-07-12 10:59:42+02:00, matthias.andree@gmx.de
  Cset exclude: torvalds@ppc970.osdl.org|ChangeSet|20040711182455|01324

Matthias

------------------------------------------------------------------------

### DIFFSTAT ###
 shortlog |  131 +++++++++++++++++++++++++++++++++++++++----------------
 1 files changed, 95 insertions(+), 36 deletions(-)

### GNUPATCH ###
--- 1.172/shortlog	2004-07-11 20:24:55 +02:00
+++ 1.178/shortlog	2004-07-16 14:51:37 +02:00
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.307 2004/07/02 08:59:44 vita Exp $
+# $Id: lk-changelog.pl,v 0.314 2004/07/16 12:51:21 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -68,6 +68,11 @@
 my $debug = 0;
 # --------------------------------------------------------------------
 
+if (defined $ENV{LINUXKERNEL_BK_FMT_DEBUG}
+	and $ENV{LINUXKERNEL_BK_FMT_DEBUG}) {
+    $debug = 1;
+}
+
 # Perl syntax magic here, "=>" is equivalent to ","
 my @addrregexps = (
 [ 'alan@[^.]+\.swansea\.linux\.org\.uk' => 'Alan Cox', ],
@@ -139,6 +144,7 @@
 'a.othieno:bluewin.ch' => 'Arthur Othieno',
 'a.othieno:ch.rmk.(none)' => 'Arthur Othieno',
 'a.wegele:tu-bs.de' => 'Artur Wegele',
+'a1tmblwd:netscape.net' => 'Kam Leo',
 'aaron.baranoff:tsc.tdk.com' => 'Aaron Baranoff',
 'abbotti:mev.co.uk' => 'Ian Abbott',
 'abraham:2d3d.co.za' => 'Abraham van der Merwe',
@@ -197,6 +203,7 @@
 'airlied:pdx.freedesktop.org' => 'Dave Airlie',
 'airlied:starflyer.(none)' => 'Dave Airlie',
 'aj:andaco.de' => 'Andreas Jochens',
+'aj:net-lab.net' => 'Andreas John',
 'ajgrothe:yahoo.com' => 'Aaron Grothe',
 'ajm:sgi.com' => 'Alan Mayer',
 'ajoshi:kernel.crashing.org' => 'Ani Joshi',
@@ -225,6 +232,7 @@
 'alessandro.zummo:towertech.it' => 'Alessandro Zummo',
 'alex.williamson:com.rmk.(none)' => 'Alex Williamson',
 'alex.williamson:hp.com' => 'Alex Williamson',
+'alex:alexdalton.org' => 'Alexandre d\'Alton',
 'alex:clusterfs.com' => 'Alex Tomas',
 'alex:de.rmk.(none)' => 'Alexander Schulz',
 'alex:ssi.bg' => 'Alexander Atanasov',
@@ -321,6 +329,7 @@
 'bart:samwel.tk' => 'Bart Samwel',
 'bbosch:iphase.com' => 'Bradley A. Bosch',
 'bbuesker:qualcomm.com' => 'Brian Buesker',
+'bcasavan:sgi.com' => 'Brent Casavant',
 'bcollins:debian.org' => 'Ben Collins',
 'bcrl:bob.home.kvack.org' => 'Benjamin LaHaise',
 'bcrl:redhat.com' => 'Benjamin LaHaise',
@@ -584,6 +593,7 @@
 'dougg:torque.net' => 'Douglas Gilbert',
 'drb:med.co.nz' => 'Ross Boswell',
 'drepper:redhat.com' => 'Ulrich Drepper',
+'drewie:freemail.hu' => 'Andras Bali',
 'driver:huey.jpl.nasa.gov' => 'Bryan B. Whitehead', # google
 'drow:false.org' => 'Daniel Jacobowitz',
 'drow:nevyn.them.org' => 'Daniel Jacobowitz',
@@ -694,6 +704,7 @@
 'francis.wiran:hp.com' => 'Francis Wiran',
 'frank.a.uepping:t-online.de' => 'Frank A. Uepping',
 'frank.cornelis:elis.ugent.be' => 'Frank Cornelis',
+'frankie:cse.unsw.edu.au' => 'Frank Engel',
 'franz.sirl-kernel:lauterbach.com' => 'Franz Sirl',
 'franz.sirl:lauterbach.com' => 'Franz Sirl',
 'frederik.deweerdt:laposte.net' => 'Frederik Deweerdt',
@@ -945,6 +956,7 @@
 'jh:sgi.com' => 'John Hesterberg',
 'jhammer:us.ibm.com' => 'Jack Hammer',
 'jhartmann:addoes.com' => 'Jeff Hartmann',
+'jheffner:psc.edu' => 'John Heffner',
 'jhf:rivenstone.net' => 'Joseph Fannin',
 'jhh:lucent.com' => 'Jorge Hernandez-Herrero',
 'jholmes:psu.edu' => 'Jason Holmes',
@@ -1075,7 +1087,6 @@
 'kevino:asti-usa.com' => 'Kevin Owen',
 'key:austin.ibm.com' => 'Kent Yoder',
 'khaho:koti.soon.fi' => 'Ari Juhani Hämeenaho',
-'khali at linux-fr dot org' => 'Jean Delvare',
 'khali:linux-fr.org' => 'Jean Delvare', # lbdb
 'khalid:fc.hp.com' => 'Khalid Aziz',
 'khalid_aziz:hp.com' => 'Khalid Aziz',
@@ -1420,6 +1431,7 @@
 'noodles:earth.li' => 'Jonathan McDowell',
 'normalperson:yhbt.net' => 'Eric Wong',
 'not:just.any.name' => 'John Fremlin',
+'notting:redhat.com' => 'Bill Nottingham',
 'nstraz:sgi.com' => 'Nathan Straz',
 'ntfs:flatcap.org' => 'Richard Russon', # lbdb
 'numlock:freesurf.ch' => 'Joël Bourquard',
@@ -1443,6 +1455,7 @@
 'oliver:vermuden.neukum.org' => 'Oliver Neukum',
 'olof:austin.ibm.com' => 'Olof Johansson',
 'omkhar:rogers.com' => 'Omkhar Arasaratnam',
+'orange:fobie.net' => 'Örjan Persson',
 'orjan.friberg:axis.com' => 'Orjan Friberg',
 'os:emlix.com' => 'Oskar Schirmer', # sent by himself
 'ossi:kde.org' => 'Oswald Buddenhagen',
@@ -1520,6 +1533,7 @@
 'peter:chubb.wattle.id.au' => 'Peter Chubb',
 'peterc:chubb.wattle.id.au' => 'Peter Chubb',
 'peterc:gelato.unsw.edu.au' => 'Peter Chubb',
+'peterm:redhat.com' => 'Peter Martuccelli',
 'peterm:remware.demon.co.uk' => 'Peter Milne',
 'peterm:uk.rmk.(none)' => 'Peter Milne',
 'petero2:telia.com' => 'Peter Osterlund',
@@ -1551,7 +1565,7 @@
 'plars:austin.ibm.com' => 'Paul Larson',
 'plars:linuxtestproject.org' => 'Paul Larson',
 'plcl:telefonica.net' => 'Pedro Lopez-Cabanillas',
-'pluto:pld-linux.org' => 'Pawe³ Sikora',
+'pluto:pld-linux.org' => 'Pawel Sikora',
 'pmanolov:lnxw.com' => 'Petko Manolov',
 'pmarques:grupopie.com' => 'Paulo Marques',
 'pmeda:akamai.com' => 'Prasanna Meda',
@@ -1724,6 +1738,7 @@
 'seanlkml:rogers.com' => 'Sean Estabrooks',
 'sebastian.droege:gmx.de' => 'Sebastian Dröge',
 'sebek64:post.cz' => 'Marcel Sebek',
+'sergio.gelato:astro.su.se' => 'Sergio Gelato',
 'set:pobox.com' => 'Paul Thompson',
 'seto.hidetoshi:jp.fujitsu.com' => 'Hidetoshi Seto',
 'sezero:superonline.com' => 'Özkan Sezer',
@@ -1870,6 +1885,7 @@
 'thunder:ngforever.de' => 'Thunder From The Hill',
 'tigran:aivazian.name' => 'Tigran Aivazian',
 'tigran:veritas.com' => 'Tigran Aivazian',
+'tim.chick:conexant.com' => 'Tim Chick',
 'tim:cambrant.com' => 'Tim Cambrant', # lbdb
 'tim:physik3.uni-rostock.de' => 'Tim Schmielau',
 'timw:splhi.com' => 'Tim Wright',
@@ -1881,7 +1897,8 @@
 'tmolina:cablespeed.com' => 'Thomas Molina',
 'tmolina:cox.net' => 'Thomas Molina',
 'tol:stacken.kth.se' => 'Tomas Olsson',
-'tom.l.nguyen:intel.com' => 'Nguyen, Tom L',
+'tom.l.nguyen:intel.com' => 'Tom L. Nguyen',
+'tomd:csds.uidaho.edu' => 'Thomas DuBuisson',
 'tomita:cinet.co.jp' => 'Osamu Tomita',
 'toml:us.ibm.com' => 'Tom Lendacky',
 'tomlins:cam.org' => 'Ed Tomlinson',
@@ -2107,7 +2124,7 @@
 # * $author can be the email address or Joe N. Sixpack II <joe6@example.com>
 #   (ready formatted to print)
 # * $name is the name (Joe N. Sixpack II) or the mail address
-#   (<joe6@example.com>) 
+#   (<joe6@example.com>)
 
 sub get_name()   { return $name; }
 sub get_author() { return $author; }
@@ -2180,7 +2197,7 @@
   croak "do not call removedups() in scalar context" unless wantarray;
   my @u = grep (!$t{lc $_}++, @_);
   return map {
-    $t{lc $_} > 1 ? sprintf("%d x ", $t{lc $_}) . $_ : $_; 
+    $t{lc $_} > 1 ? sprintf("%d x ", $t{lc $_}) . $_ : $_;
   } @u;
 }
 
@@ -2298,7 +2315,7 @@
 		   compress(map { $_->[0]; } @{$log->{$_}})), "\n"
 		     or write_error();
       } else {
-	print join("\n", map { "$indent1$_ ($a)" } 
+	print join("\n", map { "$indent1$_ ($a)" }
 		   compress(map { $_->[0]; } @{$log->{$_}})), "\n"
 		     or write_error();
       }
@@ -2449,11 +2466,15 @@
     }
 
     if ($havename) {
-	if ($$name =~ /([^,]+),\s*([^(\s]*)\s*(\(.*\))?/) {
+	# Last, First (optional comment)
+	# -> First Last (optional comment)
+	if ($$name =~ /^([^,]+),\s*([^(\s]*)\s*(\(.*\))?/) {
 	    $$name = "$2 $1";
 	    if (defined $3) { $$name .= " " . $3; }
 	}
-	if ($$name =~ /([A-Z]+)\s+([^(\s]*)\s*(\(.*\))?/) {
+	# LAST First (optional comment)
+	# -> First Last (optional comment)
+	if ($$name =~ /^([A-Z]+)\s+([^(\s]*)\s*(\(.*\))?/) {
 	    my ($u, $f) = ($2, $1);
 	    my ($ul) = lc $2;
 	    $ul =~ s/^.//;
@@ -2478,6 +2499,28 @@
     return $author;
 }
 
+# Treat address
+# INPUT: Tuple of Name, Address scalars
+# OUTPUT: Tuple of Name, Address, Author scalars in an array
+sub treat_address($$) {
+    my $n = shift;
+    my $a = lc shift;
+    my $au;
+    my $tmp;
+
+    if (($tmp = rmap_address($a, 0)) eq $a) {
+	if ($n =~ /\s+/) {
+	    # not found, but only add if two words or more in name.
+	    $address_found_in_from{$a} = sprintf "'%s' => '%s',",
+	    obfuscate $a, $n; # FIXME: has this any effect?
+	}
+    } else {
+	$n = $tmp;
+    }
+    $au = treat_addr_name($a, $n);
+    return ($n, $a, $au);
+}
+
 # Read a file and parse it into the %log hash.
 sub parse_file(\%$$ ) {
 # arguments: %log hash
@@ -2494,8 +2537,18 @@
   my @cur = ();
   my $first = 0;
   my $firstpar = 0;
+  my $namepref = 0; # where address is from
+  # 0 - BK; 1 - Signed-off-by; 2 - From
   undef $address;
 
+  ###############################################################
+  # Linus' intended logic is:
+  # - preference is given to From: (namepref 2)
+  # - lacking From:, use the first Signed-off-by: we encounter
+  #   (namepref 1)
+  # - lacking that information, use BK user info (namepref 0)
+  ###############################################################
+
   # now go!
 
   # NOTE: the first @cur item can consist of multiple lines in the
@@ -2531,41 +2584,30 @@
       $address =~ s/\[[^]]+\]$//;
       $name = rmap_address($address, 1);
       $author = treat_addr_name($address, $name);
-      print STDERR "AUTHOR $author\n" if $debug;
       $first = 1;
       $firstpar = 1;
+      print STDERR " BK-CHANGESET $author\n" if $debug;
+      $namepref = 0;
     } elsif (/^\s+From:?\s*"?([^"]*)"?\s+\<(.*)\>\s*$/) {
-      my $tmp;
-      $name = $1;
-      $address = lc $2;
-      if (($tmp = rmap_address($address, 0)) eq $address) {
-	if ($name =~ /\s+/) {
-	  # not found, but only add if two words or more in name.
-	  $address_found_in_from{$address} = sprintf "'%s' => '%s',",
-	  obfuscate $address, $name;
-	}
+      my @nameauthor = treat_address($1, $2);
+      if ($namepref < 2) {
+	  ($name, $address, $author) = @nameauthor;
+	  $namepref = 2;
+	  print STDERR " FROM  $author\n" if $debug;
       } else {
-	$name = $tmp;
+	  print STDERR " SKIPPED FROM  $author\n" if $debug;
       }
-      $author = treat_addr_name($address, $name);
-      print STDERR " FROM  $author\n" if $debug;
     } elsif (/^\s+Signed-off-by:\s*"?([^"]*)"?\s+\<(.*)\>\s*$/i) {
-      my $tmp;
-      $name = $1;
-      $address = lc $2;
-      if (($tmp = rmap_address($address, 0)) eq $address) {
-	if ($name =~ /\s+/) {
-	  # not found, but only add if two words or more in name.
-	  $address_found_in_from{$address} = sprintf "'%s' => '%s',",
-	  obfuscate $address, $name;
-	}
+      my @nameauthor = treat_address($1, $2);
+      if ($namepref < 1) {
+	  ($name, $address, $author) = @nameauthor;
+	  $namepref = 1;
+	  print STDERR " SIGNED-OFF-BY  $author\n" if $debug;
       } else {
-	$name = $tmp;
+	  print STDERR " SKIPPED SIGNED-OFF-BY  $author\n" if $debug;
       }
-#      $author = treat_addr_name($address, $name);
-      print STDERR " SIGNED-OFF-BY  $author\n" if $debug;
     } elsif ($first) {
-      # we have a "first" line after an address, take it, 
+      # we have a "first" line after an address, take it,
       # strip common redundant tags
 
       # kill "PATCH" tag
@@ -2599,7 +2641,7 @@
       # store header before a changelog
       push @prolog, $_;
     }
-  }
+  } # while more lines in file
 
   if ($fh -> error) {
     die "Error while reading from \"$fn\": $!";
@@ -2862,6 +2904,18 @@
 
 Summarizes or reformats BitKeeper ChangeLogs for Linux Kernel 2.X.
 
+Addresses of patch authors are determined with the following precedence:
+
+=over
+
+=item 1. From: line
+
+=item 2. Signed-off-by
+
+=item 3. BK user/host
+
+=back
+
 --mode options are:
 
 =over
@@ -2900,6 +2954,11 @@
 set in this variable on the command line. B<Example:> If you put
 --swap here and --noswap on your command line, --noswap takes
 precedence.
+
+=item LINUXKERNEL_BK_FMT_DEBUG
+
+If this evaluates to "true" when used as Perl expression, i. e. it is a
+nonempty string or a number other than 0, enable debugging.
 
 =back
 



### BK PATCH ###
## Wrapped with gzip_b64 ##
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
TfUkAAA=

