Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261373AbVFVOal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbVFVOal (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 10:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261335AbVFVO1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 10:27:45 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:54158 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261316AbVFVO1R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 10:27:17 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17081.30020.691009.994275@tut.ibm.com>
Date: Wed, 22 Jun 2005 09:27:16 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.12-mm1] relayfs: function docfix
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds missing documentation to the subbuf_start() callback.
Thanks to Mathieu Desnoyers for pointing it out.

Tom

Signed-off-by: Tom Zanussi <zanussi@us.ibm.com>

diff -urpN -X dontdiff linux-2.6.12-mm1/include/linux/relayfs_fs.h linux-2.6.12-mm1-cur/include/linux/relayfs_fs.h
--- linux-2.6.12-mm1/include/linux/relayfs_fs.h	2005-06-22 11:16:23.000000000 -0500
+++ linux-2.6.12-mm1-cur/include/linux/relayfs_fs.h	2005-06-22 11:44:46.000000000 -0500
@@ -88,6 +88,9 @@ struct rchan_callbacks
 	 * @prev_subbuf_idx: the previous sub-buffer's index
 	 * @prev_subbuf: the start of the previous sub-buffer
 	 *
+	 * The client should return the number of bytes it reserves at
+	 * the beginning of the sub-buffer, 0 if none.
+	 *
 	 * NOTE: subbuf_start will also be invoked when the buffer is
 	 *       created, so that the first sub-buffer can be initialized
 	 *       if necessary.  In this case, prev_subbuf will be NULL.


