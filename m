Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263172AbUDAVyG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 16:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbUDAVwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 16:52:45 -0500
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:21889 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S263301AbUDAVsv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 16:48:51 -0500
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Thu_Apr__1_21_48_47_UTC_2004_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20040401214848.09714106E@merlin.emma.line.org>
Date: Thu,  1 Apr 2004 23:48:48 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:
ChangeSet@1.148, 2004-04-01 23:48:33+02:00, matthias.andree@gmx.de
  If a From: header contains a known address, use the known name instead
  of the name from the From: line, so as to have consistent names that can
  be grouped.

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
# shortlog |   12 +++++++++---
# 1 files changed, 9 insertions(+), 3 deletions(-)

##### GNUPATCH #####
# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/04/01 23:48:33+02:00 matthias.andree@gmx.de 
#   If a From: header contains a known address, use the known name instead
#   of the name from the From: line, so as to have consistent names that can
#   be grouped.
# 
# shortlog
#   2004/04/01 23:48:33+02:00 matthias.andree@gmx.de +9 -3
#   If a From: header contains a known address, use the known name instead
#   of the name from the From: line, so as to have consistent names that can
#   be grouped.
# 
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Thu Apr  1 23:48:47 2004
+++ b/shortlog	Thu Apr  1 23:48:47 2004
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.257 2004/03/30 14:04:33 emma Exp $
+# $Id: lk-changelog.pl,v 0.258 2004/04/01 21:48:00 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -1588,6 +1588,7 @@
 'vandrove:vc.cvut.cz' => 'Petr Vandrovec',
 'vanl:megsinet.net' => 'Martin H. VanLeeuwen',
 'varenet:parisc-linux.org' => 'Thibaut Varene',
+'vatsa:in.ibm.com' => 'Srivatsa Vaddagiri',
 'vberon:mecano.gme.usherb.ca' => 'Vincent Béron',
 'venkatesh.pallipadi:intel.com' => 'Venkatesh Pallipadi',
 'vherva:niksula.hut.fi' => 'Ville Herva',
@@ -2166,12 +2167,17 @@
       $first = 1;
       $firstpar = 1;
     } elsif (/^\s+From:\s*"?([^"]*)"?\s+\<(.*)\>\s*$/) {
+      my $tmp;
       $name = $1;
       $address = lc $2;
-      if (rmap_address($address, 0) eq $address and $name =~ /\s+/) {
+      if (($tmp = rmap_address($address, 0)) eq $address) {
+	if ($name =~ /\s+/) {
 	  # not found, but only add if two words or more in name.
 	  $address_found_in_from{$address} = sprintf "'%s' => '%s',",
-	    obfuscate $address, $name;
+	  obfuscate $address, $name;
+	}
+      } else {
+	$name = $tmp;
       }
       $author = treat_addr_name($address, $name);
       print STDERR " FROM  $author\n" if $debug;

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.148
## Wrapped with gzip_uu ##


M'XL( #^.;$   ^5576^;,!1]CG_%E1HIK1J(;2 D5%1=UVZ+.FE5J^YITN3 
M): $G&$G336ZWSY#/KI4ZT.WO0TLX'X=7]]S) [@3F$9M'*A=9H)98LB+A')
M 7R02@>M2;ZRX]J\D=*8/;50V)MB6>"L=WYEEK4V+"WE3!&3>"UTE,(22Q6T
MF.WL//IACD'KYO+]W<<W-X2$(;Q-13'!6]00AD3+<BEFL3J;8S%99(6M2U&H
M'+6P(YE7N]R*4\K-S;A#^]ZPXL.^YU7(T?,BEXFQ/_ QXN39><[6Y]B'<:GC
M4.92U^,596SHD M@-G,'0-U>O1AP)W '@>,<4QY0"K]'A6,&%B7G\(_/\)9$
M,$I P+M2Y@&D*&(L(9*%%EFAC']:R/L"1&QZ4:H+AAK0*6[<A<@13)XV909(
M)DVL\28&K['6P+.LP"XH"4*9(T JEECOHC)36^BFQ 12H2$2A8$:(TQ*N9AC
M;),K8)Q1<OU$)K%>>1%"!26G3]-+98[/1J=26>J9G*PGY[$!]5V?#2J'^4.O
M2G HDLBG0T$Q%N/X!9[V4 SM9OZ&;,>IF-/O^XTDMQE[BOSK?EY2XWX_OXBQ
M;S[78N3LU6(<@N7\MV)LF/P$5GF_JI>U,M+<COD/E'G!&# R:IX'T![%IL&I
M%36S,XCV?-9= K6Y-X":PRU1K";*4(1Y+N!R-8>VP?"&U*!TED(K$1@^LG%>
M,]&!\!0ZMV76!."SF:"89&76Z9(19_V!J8'FRA^@K?/Y";G@S&_::MY\$\X2
M.#RL$R"$,A?SKQLJ#ML[3NC1$> WV#J.X#MIU67MAHCP!_2^J.->[:ZW<#=;
MN."2%H <)PL5"8WP!-@4GI#6XZ:'1\"9X=W ;B W'>]^ E&*T50M\C 9)SQF
,?8?\!%??E0V!!@  
 

