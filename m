Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264443AbUHGV7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264443AbUHGV7K (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 17:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264419AbUHGV7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 17:59:09 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:18413 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S264389AbUHGV7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 17:59:00 -0400
Subject: Re: [BUG] 2.6.8-rc3 redboot.c tries to kmalloc 256K
From: David Woodhouse <dwmw2@infradead.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       linux-mtd@lists.infradead.org
In-Reply-To: <20040807135056.C2805@flint.arm.linux.org.uk>
References: <20040807135056.C2805@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1091915937.1438.103.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Sat, 07 Aug 2004 22:58:57 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-08-07 at 13:50 +0100, Russell King wrote:
> Hi,
> 
> With 2.6.8-rc3, I'm unable to mount the jffs2 root filesystem on one of
> my test systems.  The system uses redboot, so has a redboot partition
> table.  However, the kernel was not detecting the table.
> 
> After prodding about for a while, I've found that redboot.c seems to
> be trying to kmalloc 256K of memory.   The largest size that kmalloc
> supports is 128K on MMUfull systems.

We can switch to vmalloc().

-- 
dwmw2


