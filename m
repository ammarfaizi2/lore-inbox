Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263754AbUDPVNy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 17:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263756AbUDPVNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 17:13:54 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:56990 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263754AbUDPVNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 17:13:53 -0400
Date: Fri, 16 Apr 2004 22:12:37 +0100
From: Dave Jones <davej@redhat.com>
To: Steven French <sfrench@us.ibm.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: CIFS thinko ?
Message-ID: <20040416211237.GE25240@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Steven French <sfrench@us.ibm.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This code looks odd. Maybe this is needed ?

		Dave

--- linux-2.6.5/fs/cifs/cifssmb.c~	2004-04-16 22:10:46.000000000 +0100
+++ linux-2.6.5/fs/cifs/cifssmb.c	2004-04-16 22:11:20.000000000 +0100
@@ -69,7 +69,7 @@
 		return rc;
 
 	*request_buf = buf_get();
-	if (request_buf == 0) {
+	if (*request_buf == 0) {
 		return -ENOMEM;
 	}
     /* Although the original thought was we needed the response buf for  */
