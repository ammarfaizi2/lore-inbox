Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267235AbUHDFXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267235AbUHDFXp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 01:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267252AbUHDFXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 01:23:45 -0400
Received: from mail5.tpgi.com.au ([203.12.160.101]:11719 "EHLO
	mail5.tpgi.com.au") by vger.kernel.org with ESMTP id S267235AbUHDFXn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 01:23:43 -0400
Subject: Re: MTRR driver model support broken on SMP.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0408040119270.19619@montezuma.fsmlabs.com>
References: <1091585241.3303.6.camel@laptop.cunninghams>
	 <Pine.LNX.4.58.0408040119270.19619@montezuma.fsmlabs.com>
Content-Type: text/plain
Message-Id: <1091596967.3189.86.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 04 Aug 2004 15:22:47 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2004-08-04 at 15:23, Zwane Mwaikambo wrote:
> On Wed, 4 Aug 2004, Nigel Cunningham wrote:
> 
> > MTRR driver support is broken on SMP because it calls smp functions with
> > interrupts disabled, but interrupts should be disabled because it is
> > called via device_power_up.
> >
> > Badness in smp_call_function at arch/i386/kernel/smp.c:565
> >  [<c0107f88>] dump_stack+0x1e/0x20
> >  [<c0116927>] smp_call_function+0x12b/0x137
> >  [<c011063f>] set_mtrr+0x67/0x121
> >  [<c0110c9b>] mtrr_restore+0x4f/0x73
> >  [<c0219c0f>] sysdev_resume+0x6f/0xf0
> >  [<c021d591>] device_power_up+0x8/0xf
> 
> Looking at this i'm really curious as to whether we need to bother at all,
> can you remove the mtrr restore code and then compare /proc/mtrr before
> and after suspending.

I haven't had problems but do remember 2.4 users who had trouble with X
before code to save and restore mtrrs was added.

Regards,

Nigel

