Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266713AbUGQQCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266713AbUGQQCx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 12:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266714AbUGQQCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 12:02:53 -0400
Received: from imo-m15.mx.aol.com ([64.12.138.205]:53711 "EHLO
	imo-m15.mx.aol.com") by vger.kernel.org with ESMTP id S266713AbUGQQCw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 12:02:52 -0400
Date: Sat, 17 Jul 2004 12:02:45 -0400
From: Floydsmith@aol.com
To: linux-kernel@vger.kernel.org
Cc: floydsmith@aol.com
Subject: 2.4.26 vfat mounted fs will not reqcognize 8,3 file IF extention part (ONLY) is lower case.
MIME-Version: 1.0
Message-ID: <3DDFD80E.22916F17.0B512FEB@aol.com>
X-Mailer: Atlas Mailer 2.0
X-AOL-IP: 172.152.176.64
X-AOL-Language: english
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When a ANY linux command (running under 2.4.26) ("ls", "grep", "find", etc) tryies to access a file in a "vfat" mounted fs with a filename such that it meets real mode DOS's "8.3" requirement EXCEPT (under windoze, of course), the file has has ONLY its extention part as lower case (that is, base is all UPPER), then the file will not be accessable (that is, it will appear NOT TO EXIST under linux.)

Here is an example of what I mean.
In one FAT32 dir (say dir1) under REAL MODE DOS we have a file nameed "checkfix.exe". Then a dir executed therein will show:
    CHECKFIX EXE        34,448  05-27-03  3:05a CHECKFIX.EXE
Then all linux commands will be able to see this file (if in a DOS WINDOW, the "dir" command shows EXACTLY the same thing).

But, if in another dir (again in a FAT32 partition) there is a "copy" of the file (EXCEPT it's extention part [ONLY] is lower case), then linux will not be able to access the file (but of course, both REAL MODE DOS and windoze will).
That is, (if while in a windoze (NOT REAL MODE DOS) DOS WINDOW, this other file in shows up as:
    CHECKFIX EXE        34,448  05-27-03  3:05a CHECKFIX.exe
A DOS WINDOW's "dir" command will display the "long filename info" in the 5th column which shows where the problem occurs.

The only workarrond I know of is IN REAL MODE DOS ONLY, copy the the file somewhere else, the copy it back - it will loose its' "long filename" properties, in this case - and will thus become accesible to all.

Please "cc" me, I am NOT on the "list" anymore.

Floyd,


