Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276968AbRJHQBg>; Mon, 8 Oct 2001 12:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272818AbRJHQB3>; Mon, 8 Oct 2001 12:01:29 -0400
Received: from znx208-2-156-006.znyx.com ([208.2.156.6]:39698 "EHLO
	rollsroyce.znyx.com") by vger.kernel.org with ESMTP
	id <S276966AbRJHQBQ>; Mon, 8 Oct 2001 12:01:16 -0400
Message-ID: <3BC1CEB5.8060703@znyx.com>
Date: Mon, 08 Oct 2001 09:05:09 -0700
From: Bob Miller <bob.miller@znyx.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.17-21mdk i686; en-US; rv:0.9) Gecko/20010507
X-Accept-Language: en
MIME-Version: 1.0
To: torvalds@transmeta.com, kaos@ocs.com.au
CC: linux-kernel@vger.kernel.org, jamal.hadi@znyx.com
Subject: Possible change to ./scripts/split-include.c
X-MIMETrack: Itemize by SMTP Server on rollsroyce/Znyx(Release 5.0.7 |March 21, 2001) at
 10/08/2001 09:04:52 AM,
	Serialize by Router on rollsroyce/Znyx(Release 5.0.7 |March 21, 2001) at 10/08/2001
 09:04:56 AM,
	Serialize complete at 10/08/2001 09:04:56 AM
Content-Type: multipart/mixed;
 boundary="------------080701070201080606040908"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080701070201080606040908
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-15; format=flowed

We are using CVS to keep track of the Linux kernels.  I am trying to 
solve a problem where split-include clobbers our CVS directory under 
./include/config.  I made a small change to split-include.c that only 
finds files that are header files(.h).   However, I am unsure of the 
history of split-include, and am concerned about possible side effects.

If this change is reasonable, could you consider merging it into future 
kernels.  Attached is a diff -u for the change to split-include.c


Thanks,
Bob Miller
bobm@znyx.com





--------------080701070201080606040908
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
 name="afile-1"
Content-Disposition: inline;
 filename="afile-1"

--- split-include.c,orig	Fri Oct  5 08:34:34 2001
+++ split-include.c	Fri Oct  5 08:42:53 2001
@@ -188,7 +188,7 @@
      * So by having an initial \n, strstr will find exact matches.
      */
 
-    fp_find = popen("find * -type f -print", "r");
+    fp_find = popen("find * -type f -name \"*.h\" -print", "r");
     if (fp_find == 0)
 	ERROR_EXIT( "find" );
 


--------------080701070201080606040908--

