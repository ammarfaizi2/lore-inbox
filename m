Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbUBZPsM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 10:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbUBZPsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 10:48:12 -0500
Received: from 0x50c49cd1.adsl-fixed.tele.dk ([80.196.156.209]:8718 "EHLO
	redeeman") by vger.kernel.org with ESMTP id S262169AbUBZPsI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 10:48:08 -0500
Message-ID: <3614.192.168.1.7.1077810486.squirrel@mail.redeeman.linux.dk>
Date: Thu, 26 Feb 2004 16:48:06 +0100 (CET)
Subject: sysctl error in 2.6.3-bk8
From: "Redeeman" <redeeman@metanurb.dk>
To: linux-kernel@vger.kernel.org
Reply-To: redeeman@metanurb.dk
User-Agent: SquirrelMail/1.4.2
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_redeeman-10380-1077810486-0001-2"
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_redeeman-10380-1077810486-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 0.44

hi guys, i took the patch marc made against 2.6.3-mm4, but it didnt apply
clean on 2.6.3-bk8, so i fixed it, i have attached a working patch.

--
Regards.
Redeeman
--=_redeeman-10380-1077810486-0001-2
Content-Type: text/x-diff; name="sysctl-errors.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="sysctl-errors.patch"
X-Mime-Autoconverted: from 8bit to 7bit by courier 0.44

--- old/fs/locks.c	2004-02-26 01:29:14.000000000 +0100
+++ new/fs/locks.c	2004-02-26 08:27:02.000000000 +0100
@@ -1699,6 +1699,8 @@ void locks_remove_posix(struct file *fil
 	unlock_kernel();
 }
 
+EXPORT_SYMBOL(locks_remove_posix);
+
 /*
  * This function is called on the last close of an open file.
  */
--- old/fs/dquot.c	2004-02-26 05:12:21.000000000 +0100
+++ new/fs/dquot.c	2004-02-26 08:28:26.000000000 +0100
@@ -1672,3 +1672,4 @@ EXPORT_SYMBOL(unregister_quota_format);
 EXPORT_SYMBOL(dqstats);
 EXPORT_SYMBOL(dq_list_lock);
 EXPORT_SYMBOL(dq_data_lock);
+EXPORT_SYMBOL(mark_info_dirty);
 EXPORT_SYMBOL(init_dquot_operations);
--- old/net/core/sock.c	2004-02-26 05:12:22.000000000 +0100
+++ new/net/core/sock.c	2004-02-26 08:30:01.000000000 +0100
@@ -1198,4 +1198,5 @@ EXPORT_SYMBOL(sock_wmalloc);
 #ifdef CONFIG_SYSCTL
 EXPORT_SYMBOL(sysctl_rmem_max);
 EXPORT_SYMBOL(sysctl_wmem_max);
+EXPORT_SYMBOL(sysctl_optmem_max);
 #endif
--=_redeeman-10380-1077810486-0001-2--
