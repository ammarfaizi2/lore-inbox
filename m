Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268390AbTBSMhC>; Wed, 19 Feb 2003 07:37:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268391AbTBSMhB>; Wed, 19 Feb 2003 07:37:01 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:10161 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S268390AbTBSMhA>; Wed, 19 Feb 2003 07:37:00 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.4.21-pre4|BK] remove /proc/meminfo:MemShared
Date: Wed, 19 Feb 2003 13:42:34 +0100
User-Agent: KMail/1.4.3
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
MIME-Version: 1.0
Message-Id: <200302191333.43875.m.c.p@wolk-project.de>
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_YA3KAF1JD1M0ZZP4S1RT"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_YA3KAF1JD1M0ZZP4S1RT
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Marcelo,

it seems to have been displaying zero for the past several years.

Same as in 2.5, by AKPM.

See here:=20
http://linux.bkbits.net:8080/linux-2.5/cset@1.838.103.37?nav=3Dindex.html=
|ChangeSet@-8w

ciao, Marc
--------------Boundary-00=_YA3KAF1JD1M0ZZP4S1RT
Content-Type: text/x-diff;
  charset="us-ascii";
  name="memshared-remove.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="memshared-remove.patch"

--- a/fs/proc/proc_misc.c	2003-02-19 13:29:12.000000000 +0100
+++ b/fs/proc/proc_misc.c	2003-02-19 13:30:01.000000000 +0100
@@ -180,7 +180,6 @@ static int meminfo_read_proc(char *page,
 	len += sprintf(page+len,
 		"MemTotal:     %8lu kB\n"
 		"MemFree:      %8lu kB\n"
-		"MemShared:    %8lu kB\n"
 		"Buffers:      %8lu kB\n"
 		"Cached:       %8lu kB\n"
 		"SwapCached:   %8lu kB\n"
@@ -194,7 +193,6 @@ static int meminfo_read_proc(char *page,
 		"SwapFree:     %8lu kB\n",
 		K(i.totalram),
 		K(i.freeram),
-		K(i.sharedram),
 		K(i.bufferram),
 		K(pg_size - swapper_space.nrpages),
 		K(swapper_space.nrpages),

--------------Boundary-00=_YA3KAF1JD1M0ZZP4S1RT--


