Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266534AbUGKJqc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266534AbUGKJqc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 05:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266536AbUGKJqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 05:46:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:35268 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266534AbUGKJqb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 05:46:31 -0400
Date: Sun, 11 Jul 2004 02:45:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, arjanv@redhat.com,
       linux-audio-dev@music.columbia.edu
Subject: Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-Id: <20040711024518.7fd508e0.akpm@osdl.org>
In-Reply-To: <20040711093209.GA17095@elte.hu>
References: <20040709182638.GA11310@elte.hu>
	<20040710222510.0593f4a4.akpm@osdl.org>
	<20040711093209.GA17095@elte.hu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> For all the
>  other 200 might_sleep() points it doesnt matter much.

Sorry, but an additional 100 might_sleep()s is surely excessive for
debugging purposes, and unneeded for latency purposes: all these sites are
preemptible anyway.

Let me repeat that I am unconvinced as to the diagnosis of the current
audio problems - more analysis might prove me wrong of course.

And I'm unconvinced that we need to do anything apart from identifying and
fixing the remaining spinlocks which are holding off preemption for too
long.

IOW, I am questioning the very need for a "voluntary preemption" feature
at all when "involuntary preemption" works perfectly well.

