Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261295AbTBJOgs>; Mon, 10 Feb 2003 09:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261426AbTBJOgs>; Mon, 10 Feb 2003 09:36:48 -0500
Received: from mail-07.iinet.net.au ([203.59.3.39]:8464 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id <S261295AbTBJOgr>;
	Mon, 10 Feb 2003 09:36:47 -0500
Subject: 2.4.20 autofs4 changes
From: Ian Kent <raven@themaw.net>
To: linux-kernel@vger.kernel.org
Cc: autofs@linux.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1044888185.10565.36.camel@raven.themaw.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 10 Feb 2003 22:43:05 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

I have written a patch for the autofs4 kernel module (and autofs
4.0.0-pre10 daemon) to deal with ghosting of directories (and to a
limited degree, direct automount maps). Refer to
http://www.themaw.net/includehtml.php?sendit=ians_html/autofs.html for
more information if you wish.

There have been a few changes to the autofs4 module in kernel release
2.4.20 that break this patch. I have looked through the Changelog for
2.4.20 and 2.4.19 and don't see any reference to the changes. I have
also had a brief look through the archives of this list without success.

A first look indicates that the problem for me has been caused by the
removal of the file_operations definition autofs4_dir_operations in
root.c. Then the dcache default file_operations are used for inode
initialization in inode.c instead. My initial impression is that if
there is a specific reason for using the dcache default then I will need
to work on an autofs4 implementation of dcache_dir_lseek. The rest may
be OK.

To save me some time and possible pain I am hoping to find out the
reasoning behind this change from the implementor. Please copy any reply
to my personal email address as I am not subscribed to this list. I
think that the autofs list is closed to people who are not subscribed so
I will forward any replies that don't make it there.

Should notification of these changes be posted to the autofs list?

-- 
Ian Kent <raven@themaw.net>

