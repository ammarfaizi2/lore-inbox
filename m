Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317528AbSFRSAq>; Tue, 18 Jun 2002 14:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317529AbSFRSAq>; Tue, 18 Jun 2002 14:00:46 -0400
Received: from nycsmtp3fa.rdc-nyc.rr.com ([24.29.99.79]:38668 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S317528AbSFRSAo>;
	Tue, 18 Jun 2002 14:00:44 -0400
Date: Tue, 18 Jun 2002 13:51:54 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com, <torvalds@transmeta.com>
Subject: [PATCH] 2.5.22 : include/linux/intermezzo_psdev.h
Message-ID: <Pine.LNX.4.44.0206181349330.1658-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
   The following patch fixes a compile error regarding a name change 
within task_struct, which affects ISLENTO() . Please review for inclusion.
Regards,
Frank

--- include/linux/intermezzo_psdev.h.old	Tue Jun 18 13:47:15 2002
+++ include/linux/intermezzo_psdev.h	Tue Jun 18 13:47:03 2002
@@ -47,7 +47,7 @@
 };
 
 #define ISLENTO(minor) (current->pid == upc_comms[minor].uc_pid \
-                || current->p_pptr->pid == upc_comms[minor].uc_pid)
+                || current->parent->pid == upc_comms[minor].uc_pid)
 
 extern struct upc_comm upc_comms[MAX_PRESTODEV];
 



