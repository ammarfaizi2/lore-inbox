Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261632AbTILCLN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 22:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261652AbTILCLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 22:11:13 -0400
Received: from quechua.inka.de ([193.197.184.2]:6324 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261632AbTILCLL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 22:11:11 -0400
From: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Bad directories w/Reiserfs on linux-2.6.0-test4
In-Reply-To: <200309111945.11122.yurkjes@iit.edu>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.19-20030610 ("Darts") (UNIX) (Linux/2.4.20-xfs (i686))
Message-Id: <E19xdOt-0002Jm-00@calista.inka.de>
Date: Fri, 12 Sep 2003 04:11:07 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200309111945.11122.yurkjes@iit.edu> you wrote:
> open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
> open("/usr/qt/3/lib/i686/mmx/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
> stat64("/usr/qt/3/lib/i686/mmx", 0xbfffe8c0) = -1 ENOENT (No such file or directory)
> open("/usr/qt/3/lib/i686/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
> stat64("/usr/qt/3/lib/i686", 0xbfffe8c0) = -1 ENOENT (No such file or directory)
> open("/usr/qt/3/lib/mmx/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
> stat64("/usr/qt/3/lib/mmx", 0xbfffe8c0) = -1 ENOENT (No such file or directory)
> open("/usr/qt/3/lib/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
> stat64("/usr/qt/3/lib", {st_mode=S_IFDIR|0755, st_size=504, ...}) = 0
> open("/usr/kde/3.1/lib/i686/mmx/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
> stat64("/usr/kde/3.1/lib/i686/mmx", 0xbfffe8c0) = -1 ENOENT (No such file or directory)
> open("/usr/kde/3.1/lib/i686/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
> stat64("/usr/kde/3.1/lib/i686", 0xbfffe8c0) = -1 ENOENT (No such file or directory)
> open("/usr/kde/3.1/lib/mmx/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
> stat64("/usr/kde/3.1/lib/mmx", 0xbfffe8c0) = -1 ENOENT (No such file or directory)
> open("/usr/kde/3.1/lib/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
> stat64("/usr/kde/3.1/lib", {st_mode=S_IFDIR|0755, st_size=35768, ...}) = 0

what kind of system installation do you have, is this intentional? Some kind
of LD_PRELOAD or other wrappers?

> unlink("CVS")                           = -1 EISDIR (Is a directory)
> chdir("CVS")                            = 0
> open(".", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = 4
> getdents64(4, /* 0 entries */, 131072)  = 0
> chdir("..")                             = 0
> rmdir("CVS")                            = -1 ENOTEMPTY (Directory not empty)

interesting... do you get the same empty dir (no . and ..) with ls?

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
