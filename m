Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265517AbTBPAxi>; Sat, 15 Feb 2003 19:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265532AbTBPAxi>; Sat, 15 Feb 2003 19:53:38 -0500
Received: from c16639.thoms1.vic.optusnet.com.au ([210.49.244.5]:28548 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id <S265517AbTBPAxh>;
	Sat, 15 Feb 2003 19:53:37 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: 2.5.61-mm1
Date: Sun, 16 Feb 2003 12:03:31 +1100
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <20030214231356.59e2ef51.akpm@digeo.com> <200302152227.03979.kernel@kolivas.org> <20030215154154.1fcb9737.akpm@digeo.com>
In-Reply-To: <20030215154154.1fcb9737.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302161203.31899.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Feb 2003 10:41 am, Andrew Morton wrote:
> Con Kolivas <kernel@kolivas.org> wrote:
> > I'm getting the same problem as 2.5.60-mm2 during boot:
> >
> > bad: scheduling while atomic!
> > Call Trace:
> >  [<c0112ab1>] do_schedule+0x3d/0x2f4
> >  [<c0112fb5>] wait_for_completion+0x8d/0xd0
> >  [<c0112dac>] default_wake_function+0x0/0x1c
> >  [<c0112dac>] default_wake_function+0x0/0x1c
> >  [<c0122219>] create_workqueue+0x125/0x178
> >  [<c010508e>] init+0x2a/0x17c
> >  [<c0105064>] init+0x0/0x17c
> >  [<c0106e5d>] kernel_thread_helper+0x5/0xc
>
> This appears to be due to smalldevfs disagreeing with dcache_rcu over
> dcache_lock conventions.
>
> I'll drop out smalldevfs until Adam returns, and has time to look at it,

Backing out that patch fixes it thanks.

Con
