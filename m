Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161075AbVKDFm7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161075AbVKDFm7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 00:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161076AbVKDFm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 00:42:59 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:51720 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1161075AbVKDFm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 00:42:58 -0500
Date: Fri, 4 Nov 2005 06:30:44 +0100
From: Willy Tarreau <willy@w.ods.org>
To: JaniD++ <djani22@dynamicweb.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Reboot problem.
Message-ID: <20051104053044.GC11266@alpha.home.local>
References: <028901c5e0d7$52fab640$0400a8c0@dcccs>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <028901c5e0d7$52fab640$0400a8c0@dcccs>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Nov 04, 2005 at 01:33:01AM +0100, JaniD++ wrote:
> Hello list,
> 
> Is there any way to force reboot after this:
> 
> Nov  3 21:31:39 192.168.2.50 kernel: ------------[ cut here ]------------
> Nov  3 21:31:39 192.168.2.50 kernel: kernel BUG at mm/highmem.c:183!
> Nov  3 21:31:39 192.168.2.50 kernel: invalid operand: 0000 [#1]
> Nov  3 21:31:39 192.168.2.50 kernel: SMP
> Nov  3 21:31:39 192.168.2.50 kernel: Modules linked in: netconsole
> Nov  3 21:31:39 192.168.2.50 kernel: CPU:    3
(...)
> Nov  3 21:31:39 192.168.2.50 kernel: Code: e8 08 06 00 00 89 c7 e9 38 ff ff
> ff 55 89 e5 53 83 ec 04 89 c3 b8 80 6c 68 c0 e8 3e
> Nov  3 21:31:39 192.168.2.50 kernel:  <0>Fatal exception: panic in 5 seconds
> 
> At this point the system is freez, and only reset can help.

It should have rebooted, but the system is too instable to be able to
do so. In this case, the only thing that can help is a hardware watchdog.
Possibly, you motherboard includes a chipset with a watchdog that you can
simply enable by loading the module and having a simple daemon to ping it
(I have one which takes 12 kB of RAM and which tries mallocs, forks and
FS accesses).

If the daemon stops pinging the hardware watchdog for too long, the chipset
will simply assert the RESET signal and the system will reboot.

> Thanks
> 
> Janos

Regards,
Willy

