Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262215AbUEWEid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262215AbUEWEid (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 00:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262238AbUEWEid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 00:38:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:39558 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262215AbUEWEic (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 00:38:32 -0400
Date: Sat, 22 May 2004 21:35:25 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Mike Houston <mikeserv@bmts.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-bk9 - compile failure if sysfs disabled
Message-Id: <20040522213525.31be9c82.rddunlap@osdl.org>
In-Reply-To: <20040522232628.7599ae93.mikeserv@bmts.com>
References: <20040522232628.7599ae93.mikeserv@bmts.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 May 2004 23:26:28 -0400 Mike Houston <mikeserv@bmts.com> wrote:

| If sysfs is disabled in the config under pseudo filesystems,
| 
| lib/kobject.c: In function `kobject_rename':
| lib/kobject.c:395: error: void value not ignored as it ought to be
| make[1]: *** [lib/kobject.o] Error 1
| make: *** [lib] Error 2
| 
| Line 395 is this:
| error = sysfs_rename_dir(kobj, new_name);

Fix was posted Friday 2004-05-21 at 14:55 by Maneesh Soni.
Please check your favorite lkml archive for the patch.

| Now, before anyone chides me for blindly disabling sysfs, I only came across this in helping someone else, who erroneously disabled it, solve this build failure :-)
| 
| My apologies if this is already known or expected. It just seems to me that it ought not to end in a build failure and is possibly something you folks would like to know about.
| 
| Note that I'm not saying this started in -bk9 because I've never previously compiled one without sysfs. This is, however, what the original user was building.

BTW, please tell your sylpheed client to wrap lines around 70 characters
each instead of flowing them longer.

--
~Randy
