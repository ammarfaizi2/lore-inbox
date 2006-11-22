Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967047AbWKVDg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967047AbWKVDg1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 22:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967049AbWKVDg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 22:36:27 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:42992 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S967047AbWKVDg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 22:36:26 -0500
Date: Tue, 21 Nov 2006 19:34:54 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       linux-kernel@vger.kernel.org, Nigel Cunningham <nigel@suspend2.net>,
       pavel@suse.cz, linux-pm@osdl.org
Subject: Re: 2.6.19-rc5-mm2: suspend related BLOCK=n compile error
Message-Id: <20061121193454.728e1bbd.randy.dunlap@oracle.com>
In-Reply-To: <20061122032341.GV5200@stusta.de>
References: <20061114014125.dd315fff.akpm@osdl.org>
	<20061122032341.GV5200@stusta.de>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2006 04:23:41 +0100 Adrian Bunk wrote:

> swsusp-freeze-filesystems-during-suspend-rev-2.patch causes the 
> following compile error with CONFIG_BLOCK=n:
> 
> <--  snip  -->
> 
> ...
>   CC      kernel/power/process.o
> /home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/kernel/power/process.c: In function 'freeze_processes':
> /home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/kernel/power/process.c:124: error: implicit declaration of function 'freeze_filesystems'
> /home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/kernel/power/process.c: In function 'thaw_processes':
> /home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/kernel/power/process.c:189: error: implicit declaration of function 'thaw_filesystems'
> make[3]: *** [kernel/power/process.o] Error 1

Yes, I sent a patch for that, but Pavel said that they will be
removing/dropping that code anyway.

---
~Randy
