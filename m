Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130466AbREEJEX>; Sat, 5 May 2001 05:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130532AbREEJEO>; Sat, 5 May 2001 05:04:14 -0400
Received: from pcow029o.blueyonder.co.uk ([195.188.53.123]:4110 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S130466AbREEJED>;
	Sat, 5 May 2001 05:04:03 -0400
Content-Type: text/plain; charset=US-ASCII
From: Duncan Gauld <duncan@gauldd.freeserve.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Possible README patch
Date: Sat, 5 May 2001 10:04:01 -0400
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01050510040100.05769@pc-62-31-91-153-dn>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Information in the README file says that when patching, the -p0 option is 
used with patch (eg tar xvzf <patch>.tar.gz | patch -p0). However I have 
never got this to work as I always get something like "can't find file to 
patch at line 5". However, replacing -p0 with -p1 seems to work perfectly.
Maybe the penguin doesn't like me, but still, whenever I've downloaded 
patches I had to say -p1, not -p0...

anyone else have to do this? If so, here's a wee patch for it.. (bear with 
me, it's my first one :)

Duncan Gauld
dunkers@blueyonder.co.uk
----------------------------------------------------------------

-- README	Sat May  5 09:51:36 2001
+++ README	Sat May  5 09:52:24 2001
@@ -66,10 +66,10 @@
    install by patching, get all the newer patch files, enter the
    directory in which you unpacked the kernel source and execute:
 
-		gzip -cd patchXX.gz | patch -p0
+		gzip -cd patchXX.gz | patch -p1
 
    or
-		bzip2 -dc patchXX.bz2 | patch -p0
+		bzip2 -dc patchXX.bz2 | patch -p1
 
    (repeat xx for all versions bigger than the version of your current
    source tree, _in_order_) and you should be ok.  You may want to remove
