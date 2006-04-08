Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751366AbWDHAEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbWDHAEp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 20:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbWDHAEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 20:04:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26582 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751366AbWDHAEo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 20:04:44 -0400
Date: Fri, 7 Apr 2006 17:07:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jim Cromie <jim.cromie@gmail.com>
Cc: linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: Re: 2.6.17-rc1-mm1 - detects buggy TSC on GEODE
Message-Id: <20060407170706.1ae11ea1.akpm@osdl.org>
In-Reply-To: <4436D275.2010402@gmail.com>
References: <20060404014504.564bf45a.akpm@osdl.org>
	<4436D275.2010402@gmail.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Cromie <jim.cromie@gmail.com> wrote:
>
> 
> FYI, 
> 
> as the 2 syslog extracts show;
> 1.   the new kernel is now detecting the buggy TSC on the GEODE-sc1100
> 2.    the bug is apparently correctable by passing 'idle=poll' on kernel 
> boot-line.
> 
> Heres one vendor's bug/erratta description:
>     http://soekris.com/Issue0003.htm
> 
> 
> Apr  7 11:42:01 truck kernel: [   19.160016] Kernel command line: 
> console=ttyS0,115200n81 root=/dev/nfs 
> nfsroot=192.168.42.1:/nfshost/soekris 
> nfsaddrs=192.168.42.100:192.168.42.1:192.168.42.1:255.255.255.0:soekris:eth0 
> panic=5   BOOT_IMAGE=vmlinuz-2.6.17-rc1-mm1-sk
> Apr  7 11:42:01 truck kernel: [   24.314851] Time: tsc clocksource has 
> been installed.
> Apr  7 11:42:01 truck kernel: [   29.977802] TSC appears to be running 
> slowly. Marking it as unstable
> Apr  7 11:42:01 truck kernel: [   20.460000] Time: pit clocksource has 
> been installed.
> 
> 
> Apr  7 12:35:56 truck kernel: [   21.562573] Kernel command line: 
> console=ttyS0,115200n81 root=/dev/nfs 
> nfsroot=192.168.42.1:/nfshost/soekris 
> nfsaddrs=192.168.42.100:192.168.42.1:192.168.42.1:255.255.255.0:soekris:eth0 
> panic=5  idle=poll BOOT_IMAGE=vmlinuz-2.6.17-rc1-mm1-sk
> Apr  7 12:35:56 truck kernel: [   21.563049] using polling idle threads.
> Apr  7 12:35:56 truck kernel: [   28.393469] Time: tsc clocksource has 
> been installed.
> 
> 
> Its nice to see the buggy TSC detector detect, and the work-around work.

hm.

John, does this mean that enable-tsc-for-amd-geode-gx-lx.patch is only safe
to merge after all your time-management patches have gone in?
