Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279717AbRKFVJ4>; Tue, 6 Nov 2001 16:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280554AbRKFVJp>; Tue, 6 Nov 2001 16:09:45 -0500
Received: from colorfullife.com ([216.156.138.34]:11013 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S279717AbRKFVJa>;
	Tue, 6 Nov 2001 16:09:30 -0500
Message-ID: <3BE85187.B9454EA2@colorfullife.com>
Date: Tue, 06 Nov 2001 22:09:28 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Bob Matthews <bmatthews@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.14-pre8 stress testing
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  Magic Sysrq doesn't give me anything except the name of the
> corresponding command.  The machine does not appear to have generated
> any oops output.

Was just one command name printed, or multiple commands?
The sysrq handlers are protected by a spinlock.
If multiple command names were printed it means that the sysrq handlers
themself returned, and that printk works.

I bet that the console loglevel got corrupted.
The sysrq handler should run with forced loglevel 7, like the print of
the command name.

Did you try SysRQ+7?

--
	Manfred
