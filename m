Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264687AbSJUBjv>; Sun, 20 Oct 2002 21:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264688AbSJUBjv>; Sun, 20 Oct 2002 21:39:51 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:64902 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S264687AbSJUBju>; Sun, 20 Oct 2002 21:39:50 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sun, 20 Oct 2002 18:54:34 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Andrew Morton <akpm@digeo.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sys_epoll ...
In-Reply-To: <3DB34F39.C2923F7B@digeo.com>
Message-ID: <Pine.LNX.4.44.0210201853460.959-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Oct 2002, Andrew Morton wrote:

> +                       if (ep->eventcnt || !timeout)
> +                               break;
> +                       if (signal_pending(current)) {
> +                               res = -EINTR;
> +                               break;
> +                       }
> +
> +                       set_current_state(TASK_INTERRUPTIBLE);
> +
> +                       write_unlock_irqrestore(&ep->lock, flags);
> +                       timeout = schedule_timeout(timeout);
>
> You should set current->state before performing the checks.

Why this Andrew ?



- Davide


