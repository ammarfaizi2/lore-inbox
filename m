Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280588AbRKFV3Z>; Tue, 6 Nov 2001 16:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280587AbRKFV3G>; Tue, 6 Nov 2001 16:29:06 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:31484 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S280581AbRKFV2z>; Tue, 6 Nov 2001 16:28:55 -0500
Message-ID: <3BE855D6.15E16626@redhat.com>
Date: Tue, 06 Nov 2001 16:27:50 -0500
From: Bob Matthews <bmatthews@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.14-pre8 stress testing
In-Reply-To: <3BE85187.B9454EA2@colorfullife.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> 
> >  Magic Sysrq doesn't give me anything except the name of the
> > corresponding command.  The machine does not appear to have generated
> > any oops output.
> 
> Was just one command name printed, or multiple commands?
> The sysrq handlers are protected by a spinlock.
> If multiple command names were printed it means that the sysrq handlers
> themself returned, and that printk works.

Multiple command names were printed, i.e.

<alt><SysRq>T produces SysRq: Show State, but nothing more
<alt><SysRq>P produces SysRq: Show Regs, but nothing else, etc.

> 
> I bet that the console loglevel got corrupted.
> The sysrq handler should run with forced loglevel 7, like the print of
> the command name.
> 
> Did you try SysRQ+7?

I tried resetting the loglevel to 7.  Same results.


-- 
Bob Matthews
Red Hat, Inc.
