Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136194AbRD0TeX>; Fri, 27 Apr 2001 15:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136192AbRD0TeL>; Fri, 27 Apr 2001 15:34:11 -0400
Received: from maniola.plus.net.uk ([195.166.135.195]:62207 "HELO
	mail.plus.net.uk") by vger.kernel.org with SMTP id <S136191AbRD0TeC>;
	Fri, 27 Apr 2001 15:34:02 -0400
Content-Type: Multipart/Mixed;
  charset="iso-8859-1";
  boundary="------------Boundary-00=_XAUG8AXX8XYK9S4EE0KL"
From: "D.W.Howells" <dhowells@astarte.free-online.co.uk>
To: torvalds@transmeta.com
Subject: [PATCH] rw_semaphores, exported symbol non-versioning
Date: Fri, 27 Apr 2001 20:32:57 +0100
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org, dhowells@redhat.com
MIME-Version: 1.0
Message-Id: <01042720325700.06424@orion.ddi.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_XAUG8AXX8XYK9S4EE0KL
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

This patch (made against linux-2.4.4-pre8) turns off module export versioning 
on the rwsem symbols called from inline assembly.

David

--------------Boundary-00=_XAUG8AXX8XYK9S4EE0KL
Content-Type: text/plain;
  charset="iso-8859-1";
  name="rwsem-exp.diff"
Content-Transfer-Encoding: 8bit
Content-Description: rw-semaphore patch, exported symbol versioning
Content-Disposition: attachment; filename="rwsem-exp.diff"

diff -uNr linux-2.4.4-pre8/lib/rwsem.c linux-rwsem/lib/rwsem.c
--- linux-2.4.4-pre8/lib/rwsem.c	Fri Apr 27 20:10:11 2001
+++ linux-rwsem/lib/rwsem.c	Fri Apr 27 20:27:03 2001
@@ -202,9 +202,9 @@
 	return sem;
 }
 
-EXPORT_SYMBOL(rwsem_down_read_failed);
-EXPORT_SYMBOL(rwsem_down_write_failed);
-EXPORT_SYMBOL(rwsem_wake);
+EXPORT_SYMBOL_NOVERS(rwsem_down_read_failed);
+EXPORT_SYMBOL_NOVERS(rwsem_down_write_failed);
+EXPORT_SYMBOL_NOVERS(rwsem_wake);
 #if RWSEM_DEBUG
 EXPORT_SYMBOL(rwsemtrace);
 #endif

--------------Boundary-00=_XAUG8AXX8XYK9S4EE0KL--
