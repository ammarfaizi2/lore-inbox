Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261972AbUJZBUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261972AbUJZBUj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 21:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbUJZBUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 21:20:22 -0400
Received: from zeus.kernel.org ([204.152.189.113]:4051 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261909AbUJZBSI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 21:18:08 -0400
Date: Mon, 25 Oct 2004 16:32:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christian Leber <christian@leber.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] trivial sysrq addon
Message-Id: <20041025163215.458356af.akpm@osdl.org>
In-Reply-To: <20041023194239.GA21432@core.home>
References: <20041023194239.GA21432@core.home>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Leber <christian@leber.de> wrote:
>
> Hello,
> 
> my box (2.6.9-final) was yesterday completly stalled (mouse movable and
> stupid loadmeter was still working) after starting mutt and was swapping
> for half an hour until I sent SIGTERM to all processes.
> I suspect it was a 2 GB big galeon process that was the problem.

heh, fair enough.

> I think sysrq needs a key to call oom_kill manually.
> 

I'm wondering how you chose 'f'.

> --- linux-2.6.10-rc1.orig/drivers/char/sysrq.c	2004-10-22 23:40:06.000000000 +0200
> +++ linux-2.6.10-rc1/drivers/char/sysrq.c	2004-10-23 18:02:18.000000000 +0200
> @@ -35,6 +35,7 @@
>  #include <linux/spinlock.h>
>  
>  #include <asm/ptrace.h>
> +extern void oom_kill(void);

Well you'll never go to heaven.  I'll move this declaration to mm.h.

