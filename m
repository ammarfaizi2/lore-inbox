Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263403AbSJ3DyC>; Tue, 29 Oct 2002 22:54:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263491AbSJ3DyB>; Tue, 29 Oct 2002 22:54:01 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:21151 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S263403AbSJ3DyB>; Tue, 29 Oct 2002 22:54:01 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 29 Oct 2002 20:09:54 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Andrew Morton <akpm@digeo.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sys_epoll 0.14 ...
In-Reply-To: <3DBF581E.EAFA478A@digeo.com>
Message-ID: <Pine.LNX.4.44.0210292008370.1457-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2002, Andrew Morton wrote:

> I was referring to these guys:
>
> +#define list_first(head)	(((head)->next != (head)) ? (head)->next: (struct list_head *) 0)
> +#define list_last(head)	(((head)->prev != (head)) ? (head)->prev: (struct list_head *) 0)
> +#define list_next(pos, head)	(((pos)->next != (head)) ? (pos)->next: (struct list_head *) 0)
> +#define list_prev(pos, head)	(((pos)->prev != (head)) ? (pos)->prev: (struct list_head *) 0)
>
> if we are to add such things to list.h then lots of people need
> to hum and hah over them first and ask questions like "why doesn't
> it use list_empty?"  ;)
>
> It would be better to recode epoll's list walks to use the existing
> list accessors.

Andrew, don't they better describe what you're actually doing instead of
the list_empty() trick ?



- Davide


