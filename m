Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315630AbSECLJz>; Fri, 3 May 2002 07:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315631AbSECLJy>; Fri, 3 May 2002 07:09:54 -0400
Received: from scaup.mail.pas.earthlink.net ([207.217.120.49]:22184 "EHLO
	scaup.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S315630AbSECLJx>; Fri, 3 May 2002 07:09:53 -0400
Date: Fri, 3 May 2002 07:09:25 -0400
To: linux-kernel@vger.kernel.org
Cc: marcelo@conectiva.com.br
Subject: Linux 2.4.19-pre8
Message-ID: <20020503070925.A27180@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.19-pre8 make bzImage gave this:

ips.c: In function `ips_setup':
ips.c:547: parse error before `static'
ips.c: At top level:
ips.c:505: warning: `ips_setup' defined but not used
make[3]: *** [ips.o] Error 1

The diff below based on 2.4.19-pre7-ac2 worked for me.

--- linux/drivers/scsi/ips.c    Fri May  3 03:25:16 2002
+++ linux-2.4.19-pre7-ac2/drivers/scsi/ips.c    Fri Apr 19 18:55:47 2002
@@ -543,7 +543,8 @@
    }

    return (1);
-
+}
+
 __setup("ips=", ips_setup);

 #else
@@ -579,10 +580,10 @@
          }
       }
    }
+}

 #endif

-}

 /****************************************************************************/
 /*                                                                          */


-- 
Randy Hron

