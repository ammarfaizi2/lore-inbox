Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264669AbSJTXen>; Sun, 20 Oct 2002 19:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264670AbSJTXen>; Sun, 20 Oct 2002 19:34:43 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:40069 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S264669AbSJTXen>; Sun, 20 Oct 2002 19:34:43 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sun, 20 Oct 2002 16:49:24 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Hanna Linder <hannal@us.ibm.com>
cc: Manfred Spraul <manfred@colorfullife.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] use correct wakeups in fs/pipe.c
In-Reply-To: <29540000.1035113292@w-hlinder>
Message-ID: <Pine.LNX.4.44.0210201646160.989-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Oct 2002, Hanna Linder wrote:

> --On Saturday, October 19, 2002 20:12:42 +0200 Manfred Spraul <manfred@colorfullife.com> wrote:
>
> > wake_up_interruptible() and _sync() calls are reversed in pipe_read().
> >
> > The attached patches only calls _sync if a schedule() call follows.
> >
>
> FYI. This patch fixes a hang on pipetest.c with the --epoll option.

Hanna, I'm not sure if your port of the epoll pipe code on 2.5.44 is
correct. That fix shouldn't affect epoll. Try the code I sent you
yesterday or today, it working fine on my machine without the fix.



- Davide


