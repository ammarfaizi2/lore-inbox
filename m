Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130781AbRACLDd>; Wed, 3 Jan 2001 06:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130761AbRACLDW>; Wed, 3 Jan 2001 06:03:22 -0500
Received: from [196.38.105.82] ([196.38.105.82]:42254 "EHLO www.webtrac.co.za")
	by vger.kernel.org with ESMTP id <S130306AbRACLDK>;
	Wed, 3 Jan 2001 06:03:10 -0500
Date: Wed, 3 Jan 2001 12:32:30 +0200
From: Craig Schlenter <craig@qualica.com>
To: linux-kernel@vger.kernel.org
Subject: strange swap behaviour - test11pre4
Message-ID: <20010103123230.C23323@qualica.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

This seems strange to me:

(from vmstat 1):

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id

 1  0  0 107252    956    204  44024 2376   4   594     1  256   304  11   4  85
 0  1  0 107272    952    204  43980 2436  60   641    15  284   324   5   7  88
 1  0  0 107308    952    204  43976 2344  68   586    31  256   279   5   9  86
 2  0  0 107284    952    204  43916 1488  24   372     6  199   257   5   6  89
 0  1  0 107268    952    204  43840 2328  12   582    13  259   294   5   2  93
 1  0  0 107252    952    204  43780 2580  32   645     8  272   312  12   1  87
 0  1  0 107220    952    204  43680 2436   4   643     1  290   298  13   3  84
 2  0  0 107176    952    204  43580 2324   0   581    10  273   299  10   3  87
 0  1  0 107216    956    204  43576 2532  84   633    21  296   298   6   5  89
 1  0  0 107172    952    204  43484 1948   0   487     0  251   273   6   2  92
 0  1  0 107152    956    204  43420 2348  24   593     6  266   288   5   5  90

There is a perl program running (80 Meg's in size, 20 Megs resident) that is
chatting to a database and building up a large hash in memory. The machine has
64M of RAM. The bit that doesn't make sense is why the cache is so large -
the VM seems to have got stuck paging in stuff from swap repeatedly (bits of
the perl program it would seem). Surely it should shrink the cache to provide 
more breathing room or am I being an idiot about this?

Should I be running a different kernel? 2.2.19preXXX ? Should I be tuning
vm things in proc and if so how?

Thank you,

--Craig
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
