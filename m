Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262717AbUKESOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262717AbUKESOA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 13:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262739AbUKESN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 13:13:59 -0500
Received: from brown.brainfood.com ([146.82.138.61]:6784 "EHLO
	gradall.private.brainfood.com") by vger.kernel.org with ESMTP
	id S262715AbUKESNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 13:13:47 -0500
Date: Fri, 5 Nov 2004 12:13:14 -0600 (CST)
From: Adam Heath <doogie@debian.org>
X-X-Sender: adam@gradall.private.brainfood.com
To: Ingo Molnar <mingo@elte.hu>
cc: Amit Shah <amitshah@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: RT-preempt-2.6.10-rc1-mm2-V0.7.11 hang
In-Reply-To: <20041105134639.GA14830@elte.hu>
Message-ID: <Pine.LNX.4.58.0411051210280.1237@gradall.private.brainfood.com>
References: <200411051837.02083.amitshah@gmx.net> <20041105134639.GA14830@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Nov 2004, Ingo Molnar wrote:

>
> * Amit Shah <amitshah@gmx.net> wrote:
>
> > Hi Ingo,
> >
> > I'm trying out the RT preempt patch on a P4 HT machine, I get the following
> > message:
> >
> > e1000_xmit_frame+0x0/0x83b [e1000]
>
> hm, does this happen with -V0.7.13 too? (note that it's against
> 2.6.10-rc1-mm3, a newer -mm tree.)

adam@gradall:/home.local/adam/kernel/gradall/rt/tmp$ tar xf ../linux-2.6.10-rc1.tar
adam@gradall:/home.local/adam/kernel/gradall/rt/tmp$ mv linux-2.6.10-rc1/ linux-2.6.10-rc1-mm3-RT-V0.7.13
adam@gradall:/home.local/adam/kernel/gradall/rt/tmp$ cd linux-2.6.10-rc1-mm3-RT-V0.7.13/
adam@gradall:/home.local/adam/kernel/gradall/rt/tmp/linux-2.6.10-rc1-mm3-RT-V0.7.13$ patch -p1 < ../../2.6.10-rc1-mm3 >> ../patch.log 2>&1
adam@gradall:/home.local/adam/kernel/gradall/rt/tmp/linux-2.6.10-rc1-mm3-RT-V0.7.13$ patch -p1 --dry-run < ../../realtime-preempt-2.6.10-rc1-mm3-V0.7.13 >> ../patch.log 2>&1
adam@gradall:/home.local/adam/kernel/gradall/rt/tmp/linux-2.6.10-rc1-mm3-RT-V0.7.13$ grep FAILED ../patch.log
Hunk #2 FAILED at 1545.
1 out of 2 hunks FAILED -- saving rejects to file mm/mmap.c.rej
