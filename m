Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310438AbSCGSmx>; Thu, 7 Mar 2002 13:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310443AbSCGSmm>; Thu, 7 Mar 2002 13:42:42 -0500
Received: from guardian.hermes.si ([193.77.5.150]:5899 "EHLO
	guardian.hermes.si") by vger.kernel.org with ESMTP
	id <S310438AbSCGSmf>; Thu, 7 Mar 2002 13:42:35 -0500
From: Damjan Lango <damjan.lango@hermes.si>
Message-Id: <200203071842.TAA22197@akira.hermes.si>
Subject: patch-kernel script usage help
To: linux-kernel@vger.kernel.org
Date: Thu, 7 Mar 2002 19:42:09 +0100 (MET)
Cc: torvalds@transmeta.com, marcelo@conectiva.com.br
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Would you consider applying this patch that adds a little usage help
to the patch-kernel script if the Makefile isn't found or if it is
given -h or --help options:

ciao
Damjan

diff -u patch-kernel-orig patch-kernel
--- patch-kernel-orig	Tue Feb 26 11:15:53 2002
+++ patch-kernel	Tue Feb 26 11:31:42 2002
@@ -46,6 +46,15 @@
 patchdir=${2-.}
 stopvers=${3-imnotaversion}
 
+if [ "$1" = -h -o "$1" = --help -o ! -r "$sourcedir/Makefile" ]; then
+cat << USAGE
+usage: patch-kernel [-h] [ sourcedir [ patchdir [ stopversion ] [ -acxx ] ] ]
+  The source directory defaults to /usr/src/linux, and
+  the patch directory defaults to the current directory.
+USAGE
+exit 1
+fi
+
 # See if we have any -ac options
 for PARM in $*
 do



