Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271808AbTHIEaU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 00:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272244AbTHIEaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 00:30:20 -0400
Received: from relais.videotron.ca ([24.201.245.36]:9315 "EHLO
	VL-MO-MR001.ip.videotron.ca") by vger.kernel.org with ESMTP
	id S271808AbTHIEaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 00:30:16 -0400
Date: Sat, 09 Aug 2003 00:27:31 -0400
From: Stephane Ouellette <ouellettes@videotron.ca>
Subject: [PATCH]   2.4.22-rc1-ac1    Missing declaration in
 include/linux/proc_fs.h
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <3F347833.2@videotron.ca>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_vVB/EXpQraN7BqrM+6f2Cw)"
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_vVB/EXpQraN7BqrM+6f2Cw)
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT

Folks,

    the following patch fixes a compile warning about the implicit 
declaration of proc_mkdir_mode() in proc_tty.c.

    The patch applies against 2.4.22-rc1-ac1.

     There is no such function (proc_mkdir_mode()) in 2.6.0-test2, so 
the patch does not apply to it.

Stephane Ouellette.


--Boundary_(ID_vVB/EXpQraN7BqrM+6f2Cw)
Content-type: text/plain; name=proc_fs.h-2.4.22-rc1-ac1.diff; CHARSET=US-ASCII
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=proc_fs.h-2.4.22-rc1-ac1.diff

--- linux-2.4.22-rc1-ac1-orig/include/linux/proc_fs.h	Fri Aug  8 22:47:38 2003
+++ linux-2.4.22-rc1-ac1-fixed/include/linux/proc_fs.h	Sat Aug  9 00:11:16 2003
@@ -143,6 +143,8 @@
 extern struct proc_dir_entry *proc_mknod(const char *,mode_t,
 		struct proc_dir_entry *,kdev_t);
 extern struct proc_dir_entry *proc_mkdir(const char *,struct proc_dir_entry *);
+extern struct proc_dir_entry *proc_mkdir_mode(const char *name, mode_t mode,
+		struct proc_dir_entry *parent);
 
 static inline struct proc_dir_entry *create_proc_read_entry(const char *name,
 	mode_t mode, struct proc_dir_entry *base, 
@@ -192,7 +194,9 @@
 static inline struct proc_dir_entry *proc_mknod(const char *name,mode_t mode,
 		struct proc_dir_entry *parent,kdev_t rdev) {return NULL;}
 static inline struct proc_dir_entry *proc_mkdir(const char *name,
-	struct proc_dir_entry *parent) {return NULL;}
+		struct proc_dir_entry *parent) {return NULL;}
+static inline struct proc_dir_entry *proc_mkdir_mode(const char *name,
+		mode_t mode, struct proc_dir_entry *parent) {return NULL;}
 
 static inline struct proc_dir_entry *create_proc_read_entry(const char *name,
 	mode_t mode, struct proc_dir_entry *base, 

--Boundary_(ID_vVB/EXpQraN7BqrM+6f2Cw)--
