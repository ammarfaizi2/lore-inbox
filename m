Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315708AbSGJMbd>; Wed, 10 Jul 2002 08:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315717AbSGJMbc>; Wed, 10 Jul 2002 08:31:32 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:41919 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S315708AbSGJMbb> convert rfc822-to-8bit; Wed, 10 Jul 2002 08:31:31 -0400
Content-Type: text/plain; charset=US-ASCII
From: Erich Focht <efocht@ess.nec.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: O(1) scheduler "complex" macros
Date: Wed, 10 Jul 2002 14:34:07 +0200
X-Mailer: KMail [version 1.4]
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ia64 <linux-ia64@linuxia64.org>
References: <Pine.LNX.4.44.0207111111280.6835-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0207111111280.6835-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207101434.07804.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

> there is one more detail - wait_task_inactive() needs to consider the
> ->switch_lock as well - otherwise exit() might end up freeing the
> pagetables earlier than the context-switch has truly finished. The
> udelay(100) test should trigger this race.
>
> i've fixed this and uploaded the -A8 patch:
>
>         http://redhat.com/~mingo/O(1)-scheduler/sched-2.5.25-A8
>
> does this fix the ia64 crashes? you need to define an ia64-specific

looks good! Rock solid despite udelay. Though a bit slower than before...

Thanks a lot for the help!

Erich

