Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131004AbRBEQkZ>; Mon, 5 Feb 2001 11:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135342AbRBEQkF>; Mon, 5 Feb 2001 11:40:05 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:16649 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S131004AbRBEQj4>; Mon, 5 Feb 2001 11:39:56 -0500
From: Peter Samuelson <peter@cadcamlab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14974.55089.437251.315406@wire.cadcamlab.org>
Date: Mon, 5 Feb 2001 10:39:13 -0600 (CST)
To: Ishikawa <ishikawa@yk.rim.or.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /usr/src/linux/scripts/ver_linux prints out incorrect info when "ls" 
 is aliased.
In-Reply-To: <3A7D7210.EA87572A@yk.rim.or.jp>
	<20010205073929.A32155@cadcamlab.org>
	<3A7ED185.B9AEB000@yk.rim.or.jp>
X-Mailer: VM 6.75 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
X-Face: ?*2Jm8R'OlE|+C~V>u$CARJyKMOpJ"^kNhLusXnPTFBF!#8,jH/#=Iy(?ehN$jH
        }x;J6B@[z.Ad\Be5RfNB*1>Eh.'R%u2gRj)M4blT]vu%^Qq<t}^(BOmgzRrz$[5
        -%a(sjX_"!'1WmD:^$(;$Q8~qz\;5NYji]}f.H*tZ-u1}4kJzsa@id?4rIa3^4A$
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Ishikawa <ishikawa@yk.rim.or.jp>]
> I have no idea why I invoked ver_linux using "." : I must have seen
> it somewhere and just followed it somehow.

Who knows.  Anyway, the following works in 'bash' at least -- don't
know about other shells -- but it's quite a hack....

Peter

--- scripts/ver_linux~	Tue Sep 19 22:28:37 2000
+++ scripts/ver_linux	Mon Feb  5 10:38:21 2001
@@ -4,6 +4,15 @@
 # /bin /sbin /usr/bin /usr/sbin /usr/local/bin, but it may
 # differ on your system.
 #
+case "$_" in /*/sh|/*/bash|sh|bash) ;; *)
+  echo '*** Warning: you appear to have used the dreaded'
+  echo '***   . /path/to/ver_linux'
+  echo '*** syntax -- I hope you don'\''t have any aliases set'
+  echo '*** that might affect this script.'
+  echo '*** Recommended syntax is:'
+  echo '***   sh /path/to/ver_linux'
+  ;;
+esac
 PATH=/sbin:/usr/sbin:/bin:/usr/bin:$PATH
 echo '-- Versions installed: (if some fields are empty or look'
 echo '-- unusual then possibly you have very old versions)'
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
