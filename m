Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268282AbTBYRyE>; Tue, 25 Feb 2003 12:54:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268284AbTBYRyD>; Tue, 25 Feb 2003 12:54:03 -0500
Received: from p50831A1E.dip.t-dialin.net ([80.131.26.30]:41423 "EHLO
	extern.mail.waldi.eu.org") by vger.kernel.org with ESMTP
	id <S268282AbTBYRyB> convert rfc822-to-8bit; Tue, 25 Feb 2003 12:54:01 -0500
Date: Tue, 25 Feb 2003 19:04:13 +0100
From: Bastian Blank <waldi@debian.org>
To: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH] s390 - dasd with devfs
Message-ID: <20030225180413.GA30801@wavehammer.waldi.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi folks

this patch fixes s390 dasd with devfs

bastian

diff -ru linux-2.5.63.orig/drivers/s390/block/dasd.c linux-2.5.63/drivers/s390/block/dasd.c
--- linux-2.5.63.orig/drivers/s390/block/dasd.c	2003-02-24 20:05:31.000000000 +0100
+++ linux-2.5.63/drivers/s390/block/dasd.c	2003-02-25 18:51:34.000000000 +0100
@@ -2077,7 +2077,7 @@
 
 	DBF_EVENT(DBF_EMERG, "%s", "debug area created");
 
-	if (devfs_mk_dir(NULL, "dasd", NULL)) {
+	if (!devfs_mk_dir(NULL, "dasd", NULL)) {
 		DBF_EVENT(DBF_ALERT, "%s", "no devfs");
 		rc = -ENOSYS;
 		goto failed;

-- 
Men of peace usually are [brave].
		-- Spock, "The Savage Curtain", stardate 5906.5
