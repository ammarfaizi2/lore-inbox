Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317902AbSFNMaH>; Fri, 14 Jun 2002 08:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317908AbSFNMaG>; Fri, 14 Jun 2002 08:30:06 -0400
Received: from apollo.sot.fi ([195.74.13.237]:8201 "EHLO vscan.sot.com")
	by vger.kernel.org with ESMTP id <S317902AbSFNMaF>;
	Fri, 14 Jun 2002 08:30:05 -0400
Message-ID: <3D09F128.5050208@sot.com>
Date: Fri, 14 Jun 2002 15:35:36 +0200
From: Yaroslav Popovitch <yp@sot.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4.1) Gecko/20020314 Netscape6/6.2.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.19-pre10, there is still bug in mkdep.c
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell sent a patch which fix PATH_MAX bug, but I checked and 
found that patch for mkdep.c was not applied
For more info see:
http://www.cs.helsinki.fi/linux/linux-kernel/2002-02/0242.html


--- linux/scripts/mkdep.c       Thu Jun 13 22:01:57 2002
+++ linux/scripts/mkdep.c.mod   Fri Jun 14 15:30:56 2002
@@ -218,7 +218,7 @@
 void add_path(const char * name)
 {
        struct path_struct *path;
-       char resolved_path[PATH_MAX+1];
+       char resolved_path[PATH_MAX];
        const char *name2;
 
        if (strcmp(name, ".")) {

Cheers,YP
-- 
Mr. Yaroslav Popovitch     			- tel. +372 6419975
SOT Finnish Software Engineering Ltd.   	- fax  +372 6419876
Kreutzwaldi 7-4, 10124  TALLINN         	- http://www.sot.com/
ESTONIA                                 	- http://sotlinux.net/


