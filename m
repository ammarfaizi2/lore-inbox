Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266132AbUBQMXy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 07:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266142AbUBQMXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 07:23:54 -0500
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:61589 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S266132AbUBQMXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 07:23:50 -0500
Date: Tue, 17 Feb 2004 13:23:47 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: sri@us.ibm.com, lksctp-developers@lists.sourceforge.net
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Subject: [PATCH] net/sctp/Config.in make oldconfig compatibility (bash)
Message-ID: <20040217122347.GA15213@merlin.emma.line.org>
Mail-Followup-To: sri@us.ibm.com,
	lksctp-developers@lists.sourceforge.net,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've needed the patch enclosed below the signature to remove some "make
oldconfig" complaints in the current Linux-2.4 BK version.

Please Cc: feedback to my sender address unless you are including
linux-kernel; I'm not subscribed to lksctp-developers.

Matthias Andree



You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.1317, 2004-02-16 13:04:03+01:00, matthias.andree@gmx.de
  Fix "make oldconfig" (bash 2) by inserting leading space before closing bracket.
  Add leading space for some choice options for consistent formatting.


 Config.in |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)


diff -Nru a/net/sctp/Config.in b/net/sctp/Config.in
--- a/net/sctp/Config.in	Tue Feb 17 13:12:46 2004
+++ b/net/sctp/Config.in	Tue Feb 17 13:12:46 2004
@@ -15,26 +15,26 @@
    bool '    SCTP: Debug messages' CONFIG_SCTP_DBG_MSG
    bool '    SCTP: Debug object counts' CONFIG_SCTP_DBG_OBJCNT
 fi
-if [ "$CONFIG_CRYPTO_HMAC" = "n"]; then
+if [ "$CONFIG_CRYPTO_HMAC" = "n" ]; then
   choice 'SCTP: Cookie HMAC Algorithm' \
         "HMAC-NONE		CONFIG_SCTP_HMAC_NONE" HMAC-NONE
 else
-  if [ "$CONFIG_CRYPTO_MD5" = "n" -a "$CONFIG_CRYPTO_SHA1" = "n"]; then
+  if [ "$CONFIG_CRYPTO_MD5" = "n" -a "$CONFIG_CRYPTO_SHA1" = "n" ]; then
     choice 'SCTP: Cookie HMAC Algorithm' \
         "HMAC-NONE		CONFIG_SCTP_HMAC_NONE" HMAC-NONE
   else
-    if [ "$CONFIG_CRYPTO_MD5" != "n" -a "$CONFIG_CRYPTO_SHA1" != "n"]; then
-      choice 'SCTP: Cookie HMAC Algorithm' \
+    if [ "$CONFIG_CRYPTO_MD5" != "n" -a "$CONFIG_CRYPTO_SHA1" != "n" ]; then
+      choice '    SCTP: Cookie HMAC Algorithm' \
         "HMAC-NONE		CONFIG_SCTP_HMAC_NONE \
-         HMAC-SHA1              CONFIG_SCTP_HMAC_SHA1 \
+         HMAC-SHA1		CONFIG_SCTP_HMAC_SHA1 \
          HMAC-MD5		CONFIG_SCTP_HMAC_MD5"	HMAC-SHA1
     else
       if [ "$CONFIG_CRYPTO_MD5" != "n" ]; then
-        choice 'SCTP: Cookie HMAC Algorithm' \
+        choice '    SCTP: Cookie HMAC Algorithm' \
         "HMAC-NONE		CONFIG_SCTP_HMAC_NONE \
          HMAC-MD5		CONFIG_SCTP_HMAC_MD5"	HMAC-MD5
       else
-        choice 'SCTP: Cookie HMAC Algorithm' \
+        choice '    SCTP: Cookie HMAC Algorithm' \
         "HMAC-NONE		CONFIG_SCTP_HMAC_NONE \
          HMAC-SHA1		CONFIG_SCTP_HMAC_SHA1"	HMAC-SHA1
       fi

===================================================================


This BitKeeper patch contains the following changesets:
1.1317

# User:	matthias.andree
# Host:	gmx.de
# Root:	/suse/kernel/BK/linux-2.4

# Patch vers:	1.3
# Patch type:	REGULAR

== ChangeSet ==
torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
marcelo@logos.cnet|ChangeSet|20040215224359|07068
D 1.1317 04/02/16 13:04:03+01:00 matthias.andree@gmx.de +1 -0
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Fix "make oldconfig" (bash 2) by inserting leading space before closing bracket.
c Add leading space for some choice options for consistent formatting.
K 7892
P ChangeSet
------------------------------------------------

0a0
> damien.morange@hp.com|net/sctp/Config.in|20030919112027|12961|ee6ef1685a9ff3d6 matthias.andree@gmx.de|net/sctp/Config.in|20040216120146|33591

== net/sctp/Config.in ==
damien.morange@hp.com|net/sctp/Config.in|20030919112027|12961|ee6ef1685a9ff3d6
sri@us.ibm.com|net/sctp/Config.in|20040213003652|33541
D 1.3 04/02/16 13:01:46+01:00 matthias.andree@gmx.de +7 -7
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Fix "make oldconfig" (bash 2) by inserting leading space before closing bracket.
c Add leading space for some choice options for consistent formatting.
K 33591
O -rw-rw-r--
P net/sctp/Config.in
------------------------------------------------

D18 1
I18 1
if [ "$CONFIG_CRYPTO_HMAC" = "n" ]; then
D22 1
I22 1
  if [ "$CONFIG_CRYPTO_MD5" = "n" -a "$CONFIG_CRYPTO_SHA1" = "n" ]; then
D26 2
I27 2
    if [ "$CONFIG_CRYPTO_MD5" != "n" -a "$CONFIG_CRYPTO_SHA1" != "n" ]; then
      choice '    SCTP: Cookie HMAC Algorithm' \
D29 1
I29 1
         HMAC-SHA1		CONFIG_SCTP_HMAC_SHA1 \
D33 1
I33 1
        choice '    SCTP: Cookie HMAC Algorithm' \
D37 1
I37 1
        choice '    SCTP: Cookie HMAC Algorithm' \

# Patch checksum=3b6cedb7
