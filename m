Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbTGGIQB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 04:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262984AbTGGIQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 04:16:01 -0400
Received: from adicia.telenet-ops.be ([195.130.132.56]:41397 "EHLO
	adicia.telenet-ops.be") by vger.kernel.org with ESMTP
	id S261797AbTGGIP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 04:15:59 -0400
Date: Mon, 7 Jul 2003 10:32:52 +0200
From: Vincent Touquet <vincent.touquet@pandora.be>
To: Andrew Morton <akpm@osdl.org>
Cc: vincent.touquet@pandora.be, linux-kernel@vger.kernel.org
Subject: Re: [Bug report] System lockups on Tyan S2469 and lots of io [smp boot time problems too :(]
Message-ID: <20030707083252.GA7233@ns.mine.dnsalias.org>
Reply-To: vincent.touquet@pandora.be
References: <20030706210243.GA25645@lea.ulyssis.org> <20030707003007.GE4675@ns.mine.dnsalias.org> <20030707005449.GF4675@ns.mine.dnsalias.org> <20030706191941.33f9e37a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030706191941.33f9e37a.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 06, 2003 at 07:19:41PM -0700, Andrew Morton wrote:
>The next step would be to try some older versions.  There was a big 3ware
>update between 2.5.64 and 2.5.65.  Can you try both of those?

I'm struggling with the 2.4 series for now :)
Haven't tried 2.5.x yet, as it is a production machine.
I'm compiling 2.4.21 with magic sysreq. support now.

>hmm, I see a "fixme" and an interruptible_sleep_on_timeout() around that
>error message.  Do the hangs happen on uniprocessor, non-preemptible
>kernels?
Yes, the hangs happen on uniprocessor, non-preemptible kernels.
The smp kernels which don't boot bring up that message, which is solved
by adding acpi=off to the kernel command line, acpismp=force does not
seem vital here.

I will see if I can reproduce the hang and get a trace.

regards,

Vincent
