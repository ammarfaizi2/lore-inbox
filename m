Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316896AbSHGEjA>; Wed, 7 Aug 2002 00:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316996AbSHGEjA>; Wed, 7 Aug 2002 00:39:00 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:33996 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S316896AbSHGEi7>; Wed, 7 Aug 2002 00:38:59 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Ivan Gyurdiev <ivangurdiev@attbi.com>
Reply-To: ivangurdiev@attbi.com
Organization: ( )
To: LKML <linux-kernel@vger.kernel.org>
Subject: OT: Authentication question...
Date: Tue, 6 Aug 2002 00:48:07 -0400
User-Agent: KMail/1.4.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200208060048.07267.ivangurdiev@attbi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is off-topic, but since people on this list 
are so much better educated than myself on Linux issues,
I thought I could seek help.

My system will reject any attempt
to login as a user other than root:

[root@cobra root]# su phantom
could not open session
[root@cobra root]# su ftp
could not open session
[root@cobra root]# su lp
could not open session
[root@cobra root]# su root
[root@cobra root]# 

An strace showed the following notable difference between a working backup 
system and the broken one:

Broken:
setfsuid32(0x1f4)                       = 0                                     
setfsgid32(0x1f4)                       = 0
open("/etc/passwd", O_RDONLY)           = -1 EACCES (Permission denied)

Working:
setfsuid32(0x1f4)                       = 0
setfsgid32(0x1f4)                       = 0
open("/etc/passwd", O_RDONLY)           = 3

Which makes me very confused, since /etc/passwd is a world-readable file.
Any ideas what could be the problem?
 
Thank you for any help in advance...
