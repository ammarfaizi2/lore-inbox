Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266202AbUFULrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266202AbUFULrg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 07:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266200AbUFULrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 07:47:36 -0400
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:27984 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266206AbUFULrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 07:47:00 -0400
Message-ID: <40D6CAF0.2020402@yahoo.fr>
Date: Mon, 21 Jun 2004 13:48:00 +0200
From: Eric BEGOT <eric_begot@yahoo.fr>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm1
References: <20040620174632.74e08e09.akpm@osdl.org>
In-Reply-To: <20040620174632.74e08e09.akpm@osdl.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm1/
>
>
>- Added a new vm tunable: /proc/sys/vm/vfs-cache-pressure.
>
>  This allows tuning of the kernel's preference for reclaiming VFS caches
>  versus pagecache.
>
>  vfs-cache-pressure=0: dentry and inode caches aren't reclaimed at all
>  vfs-cache-pressure=100: default - current behaviour
>  vfs-cache-pressure > 100: reclaim the VFS caches harder.
>
>  It seems that large values of vfs-cache-pressure are needed to make much
>  difference: 1000 or more.
>
>- Under some circumstances the current page reclaim code can hold
>  interrupts off for a long time.  That is fixed here.
>
>- I went through and dropped a bunch of patches which don't seem to be very
>  useful now - mainly debug stuff.
>
>- Various driver updates and random fixes
>
>  
>
I can't compile 2.6.7-mm1. here are the errors :

CC      security/selinux/hooks.o

security/selinux/hooks.c:4129: error: `selinux_netlink_send' undeclared here (not in a function)

security/selinux/hooks.c:4129: error: initializer element is not constant

security/selinux/hooks.c:4129: error: (near initialization for `selinux_ops.netlink_send')

security/selinux/hooks.c:4130: error: `selinux_netlink_recv' undeclared here (not in a function)

security/selinux/hooks.c:4130: error: initializer element is not constant

security/selinux/hooks.c:4130: error: (near initialization for `selinux_ops.netlink_recv')

make[2]: *** [security/selinux/hooks.o] Error 1

make[1]: *** [security/selinux] Error 2

make: *** [security] Error 2


With the same config, the 2.6.7 compiles perfectly. I join my .config.

Regards
