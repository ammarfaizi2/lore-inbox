Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbTILCoT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 22:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbTILCoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 22:44:19 -0400
Received: from students2.iit.edu ([216.47.143.102]:41215 "EHLO
	students2.iit.edu") by vger.kernel.org with ESMTP id S261258AbTILCoM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 22:44:12 -0400
Date: Thu, 11 Sep 2003 21:44:09 -0500
From: Jesse Yurkovich <yurkjes@iit.edu>
Subject: Re: Bad directories w/Reiserfs on linux-2.6.0-test4
To: linux-kernel@vger.kernel.org
Message-id: <200309112144.09097.yurkjes@iit.edu>
Organization: Illinois Institute of Technology
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

[snip]
 ... 
>> stat64("/usr/kde/3.1/lib/mmx", 0xbfffe8c0) = -1 ENOENT (No such file or directory)
>> open("/usr/kde/3.1/lib/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
>> stat64("/usr/kde/3.1/lib", {st_mode=S_IFDIR|0755, st_size=35768, ...}) = 0

>what kind of system installation do you have, is this intentional? Some kind
>of LD_PRELOAD or other wrappers?

Yeah, I have a LD_LIBRARY_PATH set for development ... etc. etc.

>> unlink("CVS")                           = -1 EISDIR (Is a directory)
>> chdir("CVS")                            = 0
>> open(".", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = 4
>> getdents64(4, /* 0 entries */, 131072)  = 0
>> chdir("..")                             = 0
>> rmdir("CVS")                            = -1 ENOTEMPTY (Directory not empty)

>interesting... do you get the same empty dir (no . and ..) with ls?
Yikes!!! -- hadn't noticed (CVS directory is bad for some reason)

$ cd datatable-backup/CVS
$ ls -la
total 0			<-- not good   . and .. are not there

whoa ... where did my parent go :(

>Greetings
>Bernd

-Jesse
