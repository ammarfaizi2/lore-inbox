Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261889AbVDVN4Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbVDVN4Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 09:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbVDVN4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 09:56:16 -0400
Received: from mail3.utc.com ([192.249.46.192]:50891 "EHLO mail3.utc.com")
	by vger.kernel.org with ESMTP id S261889AbVDVN4L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 09:56:11 -0400
Message-ID: <42690274.5040005@cybsft.com>
Date: Fri, 22 Apr 2005 08:56:04 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: fix ultrastor.c compile error
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------060805000800040409040509"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060805000800040409040509
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This simple patch fixes a compile error in the ultrastor driver. Patch 
was originally submitted by Barry K. Nathan as referenced here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=111391774018717&w=2
I just regenerated it against your current git tree. Please apply.

-- 
    kr

Signed-off-by: K.R. Foley <kr@cybsft.com>

--------------060805000800040409040509
Content-Type: text/x-patch;
 name="ultrafix2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ultrafix2.patch"

--- linux.test/drivers/scsi/ultrastor.c.orig	2005-04-22 08:38:06.000000000 -0500
+++ linux.test/drivers/scsi/ultrastor.c	2005-04-22 08:38:12.000000000 -0500
@@ -945,7 +945,7 @@
 	       config.mscp[mscp_index].SCint, SCpnt);
 #endif
     if (config.mscp[mscp_index].SCint == 0)
-	return FAILURE;
+	return FAILED;
 
     if (config.mscp[mscp_index].SCint != SCpnt) panic("Bad abort");
     config.mscp[mscp_index].SCint = NULL;

--------------060805000800040409040509--
