Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129434AbQLEGBs>; Tue, 5 Dec 2000 01:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129588AbQLEGBh>; Tue, 5 Dec 2000 01:01:37 -0500
Received: from smtp02.mrf.mail.rcn.net ([207.172.4.61]:63887 "EHLO
	smtp02.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S129434AbQLEGBX>; Tue, 5 Dec 2000 01:01:23 -0500
Message-ID: <3A2C7D8F.5BC3B33@haque.net>
Date: Tue, 05 Dec 2000 00:30:55 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test12-pre5
In-Reply-To: <Pine.LNX.4.10.10012041906510.2047-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following fixes to many arguments error in fs/udf/inode.c for
test12-pre5

--- fs/udf/inode.c.orig Mon Dec  4 23:34:23 2000
+++ fs/udf/inode.c      Tue Dec  5 00:26:59 2000
@@ -202,7 +202,7 @@
        mark_buffer_dirty(bh);
        udf_release_data(bh);
 
-       inode->i_data.a_ops->writepage(NULL, page);
+       inode->i_data.a_ops->writepage(page);
        UnlockPage(page);
        page_cache_release(page);
 

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
