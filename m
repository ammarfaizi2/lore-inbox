Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129464AbQLLCAR>; Mon, 11 Dec 2000 21:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129552AbQLLCAH>; Mon, 11 Dec 2000 21:00:07 -0500
Received: from dryline-fw.wireless-sys.com ([216.126.67.45]:21020 "EHLO
	dryline-fw.wireless-sys.com") by vger.kernel.org with ESMTP
	id <S129464AbQLLB7w>; Mon, 11 Dec 2000 20:59:52 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14901.32619.305171.617057@somanetworks.com>
Date: Mon, 11 Dec 2000 20:29:15 -0500 (EST)
From: "Georg Nikodym" <georgn@somanetworks.com>
To: georgn@somanetworks.com
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org,
        greg@wind.enjellic.com, sct@redhat.com,
        Linus Torvalds <torvalds@transmeta.com>,
        "Adam J. Richter" <adam@yggdrasil.com>
Subject: Re: linux-2.4.0-test11 and sysklogd-1.3-31 
In-Reply-To: <14901.31690.961664.201896@somanetworks.com>
In-Reply-To: <14897.3214.38818.625199@somanetworks.com>
	<4977.976313761@ocs3.ocs-net>
	<14901.31690.961664.201896@somanetworks.com>
X-Mailer: VM 6.75 under 21.2  (beta37) "Pan" XEmacs Lucid
Reply-To: georgn@somanetworks.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "GN" == Georg Nikodym <georgn@somanetworks.com> writes:

 GN> Here's a patch (against sysklogd-1.3-31) that completely tear out
 GN> the symbol processing code.

Doh!  Forgot a chunk (to be applied after the others):

diff -Nru a/src/sysklogd-1.3-31/Makefile b/src/sysklogd-1.3-31/Makefile
--- a/src/sysklogd-1.3-31/Makefile	Mon Dec 11 20:28:24 2000
+++ b/src/sysklogd-1.3-31/Makefile	Mon Dec 11 20:28:24 2000
@@ -63,8 +63,8 @@
 syslogd: syslogd.o pidfile.o
 	${CC} ${LDFLAGS} -o syslogd syslogd.o pidfile.o ${LIBS}
 
-klogd:	klogd.o syslog.o pidfile.o ksym.o
-	${CC} ${LDFLAGS} -o klogd klogd.o syslog.o pidfile.o ksym.o ${LIBS}
+klogd:	klogd.o syslog.o pidfile.o
+	${CC} ${LDFLAGS} -o klogd klogd.o syslog.o pidfile.o ${LIBS}
 
 syslog_tst: syslog_tst.o
 	${CC} ${LDFLAGS} -o syslog_tst syslog_tst.o
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
