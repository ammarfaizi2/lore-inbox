Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbTLUDTf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 22:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbTLUDTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 22:19:35 -0500
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:21167 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262116AbTLUDTc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 22:19:32 -0500
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Sun_Dec_21_03_19_29_UTC_2003_0@merlin.emma.line.org>
Content-Type: text/plain; charset=US-ASCII
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 7BIT
Message-Id: <20031221031929.5B1C99D6AD@merlin.emma.line.org>
Date: Sun, 21 Dec 2003 04:19:29 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:
ChangeSet@1.107, 2003-12-21 04:12:57+01:00, matthias.andree@gmx.de
  Deprecate --ignoremerge.
  Remove documentation, warn user if used, pointing him/her to
  bk changes -d with $unless(:MERGE:).

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
# shortlog |   12 +++++++++---
# 1 files changed, 9 insertions(+), 3 deletions(-)

##### GNUPATCH #####
# This is a BitKeeper generated patch for the following project:
# Project Name: BK kernel tools
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.106   -> 1.107  
#	            shortlog	1.79    -> 1.80   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/12/21	matthias.andree@gmx.de	1.107
# Deprecate --ignoremerge.
# Remove documentation, warn user if used, pointing him/her to
# bk changes -d with $unless(:MERGE:).
# --------------------------------------------
#
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Sun Dec 21 04:19:28 2003
+++ b/shortlog	Sun Dec 21 04:19:28 2003
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.206 2003/12/20 23:32:45 emma Exp $
+# $Id: lk-changelog.pl,v 0.207 2003/12/21 03:10:50 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -2061,6 +2061,11 @@
 # --count implies --compress
 if ($opt{count}) { $opt{compress} = 1; }
 
+# --ignoremerge is deprecated
+print STDERR "--ignoremerge is deprecated and will be removed. Replacement:\n"
+   . 'bk changes -d\'$unless(:MERGE:){<:P:@:HOST:>\n $each(:C:){\t(:C:)\n}\n\''
+   . "\n";
+
 # Set the sort function
 $namesortfunc = \&caseicmp;
 if ($opt{'by-surname'}) { $namesortfunc = \&caseicmpbysurname; }
@@ -2149,6 +2154,9 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.207  2003/12/21 03:10:50  emma
+# Mark --ignoremerge deprecated, point towards bk changes -d'$unless(:MERGE:)' instead.
+#
 # Revision 0.206  2003/12/20 23:32:45  emma
 # Resolve conflict with Linus' version.
 #
@@ -2873,8 +2881,6 @@
                      omit "email address" when a name is known
      --[no]obfuscate
                      obfuscate "email address" in output
-     --[no]ignoremerge
-                     suppress "Merge bk://..." changelogs.
 
      --mode=MODE     specify the output format (use --man to find out more)
      --width[=WIDTH] specify the line length, if omitted: $COLUMNS or 80.

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.107
## Wrapped with gzip_uu ##


M'XL( $ 1Y3\  ]V576_:,!2&K^M?<520Z-0FV XAX(VJ:T%MU56MTO:.&Y.<
MDHC$0;&A3&/_?09*$;3=M(^K)58LQR='YSSOFZ0"#QI+L9=+8Y)4:E>JN$0D
M%;@HM!%[PWSFQHME6!1V6=<3C?41E@JS^NF5'<YJX9BBR#2Q@;?21 E,L=1B
MC[G>RQWS=8QB+^R=/WSY'!+2Z<!9(M40[]! IT-,44YE%NN3,:KA)%6N*:72
M.1KI1D4^?XF=<TJY/1GW:--OSWF[Z?MSY.C[48/)0= *,.)DIY^351_;:3S&
M.;-7QMG<YJ.4=(&YC 9 O3KC=<Z -@3CP@\.*1.4PMM9X9"!0\DI_.,>SD@$
M71R7&$F#X#CI4!4EYE@.T;5;(>;%%"$NHDF.RDB3%NH(GF2IP(I40OJXF.,C
M&!>I,JD:0I+F]<3NF,(^/AA!M"Q(@Q/#4VH2J$Y4AEH?B.M>>-X3'UQR!98+
M([<;K8CSFP<A5%)RO(&3%#GND-%)49JL&*[ ^*Q%@T; 6G./!6U__HAM^1@%
MM"TIQG(0OR/#5I:UMMQOSAM>0!M+QZTCM@SWU_6\9[:WZEEXC?-6L[7T6HN^
MLEKS%U9K@^/]IU9;Z70#3ODT6PQG9HVWAO@'ONLR!HQ<+J\5J%[& K*1LZK$
M9G3'V=$4J,OM"[]0:*V#)Q@5/@7,<PF]V1BJY)+3I@>^S;*%!E(-\9I:3,:E
M;1[N[KN],(3]GT2"U=1BR#(8()1+MK%K(8\S&>$"L.BK?0( +M2VV/5KN]R^
M?1*WXD1<W-S=B^.^@BK**#D09W:G;Y9S7WWOJWZMMLJW;S-_)'W;$?,9++[.
M(4Y3;?5\)O$FBB4+&WLMR]$.@DU7S^I;R:TQ8KVM^JO":Y J;5#&+JF0+F\%
;3>";WT>48#32D[Q#[5N&-.;D![O7D ZI!@  
 

