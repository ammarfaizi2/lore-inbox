Return-Path: <linux-kernel-owner+w=401wt.eu-S1753138AbWLOS2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753138AbWLOS2y (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 13:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753141AbWLOS2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 13:28:54 -0500
Received: from mxout005.mail.hostpoint.ch ([217.26.49.184]:60979 "EHLO
	mxout005.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753140AbWLOS2x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 13:28:53 -0500
X-Greylist: delayed 9529 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Dec 2006 13:28:52 EST
X-Authenticated-Sender-Id: andreas.jaggi@waterwave.ch
Date: Fri, 15 Dec 2006 16:49:46 +0100
From: Andreas Jaggi <andreas.jaggi@waterwave.ch>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] remove ambiguous redefinition of INIT_WORK
Message-ID: <20061215164946.433210e3@localhost>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.19; powerpc-unknown-linux-gnu)
X-Face: ~'tADa1faeey.m~:h}X+Y,gdK*18AQQun"fQ6e-FE@0&cEf&{p1`$bqU[Zr^D]G<fqBU;"P
 2X\'U16EWS^zbPX?:[nRF)evEb_4|[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Removes an unused and ambiguous redefinition of INIT_WORK()

Signed-off-by: Andreas Jaggi <andreas.jaggi@waterwave.ch>

--
diff --git a/drivers/char/mxser.h b/drivers/char/mxser.h
index 7e188a4..9fe2849 100644
--- a/drivers/char/mxser.h
+++ b/drivers/char/mxser.h
@@ -439,12 +439,4 @@
 
 #define READ_MOXA_MUST_GDL(baseio)	inb((baseio)+MOXA_MUST_GDL_REGISTER)
 
-
-#ifndef INIT_WORK
-#define INIT_WORK(_work, _func, _data){	\
-	_data->tqueue.routine = _func;\
-	_data->tqueue.data = _data;\
-	}
-#endif
-
 #endif
diff --git a/drivers/char/mxser_new.h b/drivers/char/mxser_new.h
index a08f0ec..55b34a0 100644
--- a/drivers/char/mxser_new.h
+++ b/drivers/char/mxser_new.h
@@ -439,12 +439,4 @@
 
 #define READ_MOXA_MUST_GDL(baseio)	inb((baseio)+MOXA_MUST_GDL_REGISTER)
 
-
-#ifndef INIT_WORK
-#define INIT_WORK(_work, _func, _data){	\
-	_data->tqueue.routine = _func;\
-	_data->tqueue.data = _data;\
-	}
-#endif
-
 #endif
