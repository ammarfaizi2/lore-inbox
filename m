Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262176AbUEWD0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbUEWD0r (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 23:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbUEWD0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 23:26:47 -0400
Received: from cathy.bmts.com ([216.183.128.202]:948 "EHLO cathy.bmts.com")
	by vger.kernel.org with ESMTP id S262176AbUEWD0q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 23:26:46 -0400
Date: Sat, 22 May 2004 23:26:28 -0400
From: Mike Houston <mikeserv@bmts.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.6-bk9 - compile failure if sysfs disabled
Message-Id: <20040522232628.7599ae93.mikeserv@bmts.com>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-bmts-MailScanner: Found to be clean
X-bmts-MailScanner-SpamCheck: 
X-MailScanner-From: mikeserv@bmts.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If sysfs is disabled in the config under pseudo filesystems,

lib/kobject.c: In function `kobject_rename':
lib/kobject.c:395: error: void value not ignored as it ought to be
make[1]: *** [lib/kobject.o] Error 1
make: *** [lib] Error 2

Line 395 is this:
error = sysfs_rename_dir(kobj, new_name);

Now, before anyone chides me for blindly disabling sysfs, I only came across this in helping someone else, who erroneously disabled it, solve this build failure :-)

My apologies if this is already known or expected. It just seems to me that it ought not to end in a build failure and is possibly something you folks would like to know about.

Note that I'm not saying this started in -bk9 because I've never previously compiled one without sysfs. This is, however, what the original user was building.

Thanks folks (for everything you do),
Mike
