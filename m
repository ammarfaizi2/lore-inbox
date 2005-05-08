Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262833AbVEHJeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262833AbVEHJeo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 05:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262830AbVEHJeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 05:34:44 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:1705 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262828AbVEHJel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 05:34:41 -0400
Date: Sun, 8 May 2005 11:34:40 +0200
From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
To: LKML <linux-kernel@vger.kernel.org>, GIT <git@vger.kernel.org>
Subject: [PATCH] Really *do* nothing in while loop
Message-ID: <20050508093440.GA9873@cip.informatik.uni-erlangen.de>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>,
	GIT <git@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-URL: http://wwwcip.informatik.uni-erlangen.de/~sithglan/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Really *do* nothing in while loop

Signed-Off-by: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>

--- a/sha1_file.c
+++ b/sha1_file.c
@@ -335,7 +335,7 @@
 	stream.next_in = hdr;
 	stream.avail_in = hdrlen;
 	while (deflate(&stream, 0) == Z_OK)
-		/* nothing */
+		/* nothing */;
 
 	/* Then the data itself.. */
 	stream.next_in = buf;
