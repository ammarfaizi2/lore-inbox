Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263743AbTGCTNx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 15:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263990AbTGCTNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 15:13:53 -0400
Received: from air-2.osdl.org ([65.172.181.6]:1682 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263743AbTGCTNu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 15:13:50 -0400
Date: Thu, 3 Jul 2003 12:22:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Boszormenyi Zoltan <zboszor@freemail.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.74-mm1
Message-Id: <20030703122243.51a6d581.akpm@osdl.org>
In-Reply-To: <3F042AEE.2000202@freemail.hu>
References: <3F0407D1.8060506@freemail.hu>
	<3F042AEE.2000202@freemail.hu>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Boszormenyi Zoltan <zboszor@freemail.hu> wrote:
>
> Hi,
> 
> I actually tried it. It seems that although I compiled an SMP kernel, it 
> does not use both CPUs.

You're right.  The kernel sort-of saw the second CPU but it appears to have
not come up.

Have you used any other 2.5 kernels?  Are you able to pinpoint and
particular kernel version at which this started to happen?

If not then I'd appreciate it if you could test stock 2.4.74.

> I got one oops on boot.

That's a warning, not an oops.  The ACPI IRQ handler claims that it's not
handling the IRQ all the time.  That's a fairly, err, mature problem
actually.


> I was doing two "find / | xargs cat >/dev/null" on two terminals and I 
> didn't notice them.

Well that's nice.  We have a fancy I/O scheduler in there.

> Tried recompiling the .74-mm1 tree with "make -j2" and my xmms does not 
> skip at all
> but my mozilla windows are slowly refreshing, even the compose window is 
> reacting
> slowly. Somehow it's understandable. :-) The machine is a dual P3/500
> with 512MB memory.

Thanks for the feedback.
