Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbTEIAEw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 20:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262189AbTEIAEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 20:04:52 -0400
Received: from ns.suse.de ([213.95.15.193]:7944 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262170AbTEIAEv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 20:04:51 -0400
Date: Fri, 9 May 2003 02:17:28 +0200 (CEST)
From: Bernhard Kaindl <bk@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.4] cleanup ptrace secfix and fix most side effects
In-Reply-To: <Pine.LNX.4.44.0305090033240.12720-100000@wotan.suse.de>
Message-ID: <Pine.LNX.4.44.0305090210360.12720-100000@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:
> Thinking about this harder
>
> A ptraced thread cannot go setuid since we don't permit the exec to do
> it
>
> A setuid thread marks the mm dumpable so no thread can be ptraced (since
> all threads inheriting the mm inherit it from the exec)

Agreed, this is the short form of what I tried to say.

> So ignore my earlier message

Thanks,
Bernd

On Fri, 9 May 2003, Bernhard Kaindl wrote:
>
> a) setuid requires execve() which decouples from the other thread
>    and also gives the new thread a newly allocated task->mm.
>
> b) If the thread which calls execve() is being traced, execve ignores
>    setuid.
>
> c) If the thread which calls execve() is being not traced, a tracer has
>    to attach first, otherwise
...
> d)
...

