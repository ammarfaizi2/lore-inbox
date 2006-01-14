Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751570AbWANXTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751570AbWANXTr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 18:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751572AbWANXTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 18:19:47 -0500
Received: from pilet.ens-lyon.fr ([140.77.167.16]:28901 "EHLO
	pilet.ens-lyon.fr") by vger.kernel.org with ESMTP id S1751567AbWANXTq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 18:19:46 -0500
Date: Sun, 15 Jan 2006 00:15:58 +0100
From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Steve French <smfrench@austin.rr.com>, linux-kernel@vger.kernel.org
Subject: [patch 2.6.15-mm4] fix warning in fs/cifs/cifssmb.c
Message-ID: <20060114230707.GD26443@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following warning, (i couldn't find where 'struct sec_desc' was
defined).

fs/cifs/cifssmb.c: In function jCIFSSMBGetCIFSACL':
fs/cifs/cifssmb.c:2573: warning: passing argument 1 of 'parse_sec_desc' from incompatible pointer type

Signed-off-by: Benoit Boissinot <benoit.boissinot@ens-lyon.org>


--- a/fs/cifs/cifssmb.c	2006-01-14 23:53:45.000000000 +0100
+++ b/fs/cifs/cifssmb.c.new	2006-01-14 23:53:37.000000000 +0100
@@ -2542,7 +2542,7 @@
 	if (rc) {
 		cFYI(1, ("Send error in QuerySecDesc = %d", rc));
 	} else {                /* decode response */
-		struct sec_desc * psec_desc;
+		struct cifs_sid * psec_desc;
 		__le32 * parm;
 		int parm_len;
 		int data_len;
