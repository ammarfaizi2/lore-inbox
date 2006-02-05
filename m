Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751749AbWBEM4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbWBEM4N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 07:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751754AbWBEM4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 07:56:13 -0500
Received: from cantor2.suse.de ([195.135.220.15]:1765 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751749AbWBEM4M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 07:56:12 -0500
Date: Sun, 5 Feb 2006 13:56:10 +0100
From: Olaf Hering <olh@suse.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>
Subject: Re: [PATCH] Fix build failure in recent pm_prepare_* changes.
Message-ID: <20060205125610.GA26337@suse.de>
References: <200602032312.k13NCDAc012658@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <200602032312.k13NCDAc012658@hera.kernel.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Fri, Feb 03, Linux Kernel Mailing List wrote:

> tree 8f70444139c8564c0f1e88e1f33adda036ae6a96
> parent 278ff9537030bbb292b33504f5e1f6e0126793eb
> author Dave Jones <davej@redhat.com> Fri, 03 Feb 2006 19:03:44 -0800
> committer Linus Torvalds <torvalds@g5.osdl.org> Sat, 04 Feb 2006 00:32:00 -0800
> 
> [PATCH] Fix build failure in recent pm_prepare_* changes.
> 
> kernel/power/power.h:49: error: static declaration of 'pm_prepare_console' follows non-static declaration
> include/linux/suspend.h:46: error: previous declaration of 'pm_prepare_console' was here
> kernel/power/power.h:50: error: static declaration of 'pm_restore_console' follows non-static declaration
> include/linux/suspend.h:47: error: previous declaration of 'pm_restore_console' was here
> 
> Signed-off-by: Dave Jones <davej@redhat.com>

this one is not correct, please have a closer look at
f7b8988ff50d99c99746f65f420364e91362c065

  CC      drivers/macintosh/via-pmu.o
drivers/macintosh/via-pmu.c: In function 'pmac_suspend_devices':
drivers/macintosh/via-pmu.c:2078: error: implicit declaration of function 'pm_prepare_console'
drivers/macintosh/via-pmu.c: In function 'pmac_wakeup_devices':
drivers/macintosh/via-pmu.c:2194: error: implicit declaration of function 'pm_restore_console'
make[2]: *** [drivers/macintosh/via-pmu.o] Error 1



-- 
short story of a lazy sysadmin:
 alias appserv=wotan
