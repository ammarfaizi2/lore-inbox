Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbTJMQfM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 12:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbTJMQfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 12:35:12 -0400
Received: from imladris.surriel.com ([66.92.77.98]:32705 "EHLO
	imladris.surriel.com") by vger.kernel.org with ESMTP
	id S261914AbTJMQfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 12:35:08 -0400
Date: Mon, 13 Oct 2003 12:34:52 -0400 (EDT)
From: Rik van Riel <riel@surriel.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][TRIVIAL] silence warning in reiserfs_ioctl
Message-ID: <Pine.LNX.4.55L.0310131233460.27244@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gcc is afraid we might fall off the end of the function without returning.

diff -urNp linux-5110/fs/reiserfs/ioctl.c linux-10010/fs/reiserfs/ioctl.c
--- linux-5110/fs/reiserfs/ioctl.c
+++ linux-10010/fs/reiserfs/ioctl.c
@@ -84,6 +84,7 @@ int reiserfs_ioctl (struct inode * inode
 	default:
 		return -ENOTTY;
 	}
+	return 0;
 }

 /*
