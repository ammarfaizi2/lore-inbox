Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317714AbSGVRTX>; Mon, 22 Jul 2002 13:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317716AbSGVRTX>; Mon, 22 Jul 2002 13:19:23 -0400
Received: from node-209-133-23-217.caravan.ru ([217.23.133.209]:64516 "EHLO
	mail.tv-sign.ru") by vger.kernel.org with ESMTP id <S317714AbSGVRTW>;
	Mon, 22 Jul 2002 13:19:22 -0400
Message-ID: <3D3C400E.1BE517EF@tv-sign.ru>
Date: Mon, 22 Jul 2002 21:25:34 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Ingo Molnar <mingo@elte.hu>, george anzinger <george@mvista.com>
Subject: Re: [patch] big IRQ lock removal, 2.5.27-D9
References: <Pine.LNX.4.44.0207221650140.11103-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

> > then preempt_stop (cli) can be killed in entry.S:ret_from_intr()
>
> yes, it can be removed, and i did this.

Sorry, forgot to say that GET_THREAD_INFO(%ebx) can be shifted
from common_interrupt: and BUILD_INTERRUPT() to ret_from_intr:
in entry.s (sorry again, can't make diff).

Oleg.
