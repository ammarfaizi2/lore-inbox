Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266778AbTGGCFP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 22:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266783AbTGGCFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 22:05:14 -0400
Received: from air-2.osdl.org ([65.172.181.6]:59058 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266778AbTGGCFJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 22:05:09 -0400
Date: Sun, 6 Jul 2003 19:19:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: vincent.touquet@pandora.be
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Bug report] System lockups on Tyan S2469 and lots of io [smp
 boot time problems too :(]
Message-Id: <20030706191941.33f9e37a.akpm@osdl.org>
In-Reply-To: <20030707005449.GF4675@ns.mine.dnsalias.org>
References: <20030706210243.GA25645@lea.ulyssis.org>
	<20030707003007.GE4675@ns.mine.dnsalias.org>
	<20030707005449.GF4675@ns.mine.dnsalias.org>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vincent Touquet <vincent.touquet@pandora.be> wrote:
>
> On Mon, Jul 07, 2003 at 02:30:07AM +0200, Vincent Touquet wrote:
> >PS: will test if the system still locks up soon, I hope not...
> 
> So it does lock up again :(((
> 
> But now I was able to quickly switch to console and grab the contents of
> /var/log/messages before it totally hanged. I can usually tell when the
> hang is going to happen: activity on the array stops, then I have a few
> more seconds till it hangs completely ....
> 
> The message was:
> 
> Jul 7 02:45:36 kalimero kernel: 3w-xxxx: scsi0: Unit #0:
> command (f7618800) timed out, resetting card.
> 
> Then of course, the system totally hangs.

The next step would be to try some older versions.  There was a big 3ware
update between 2.5.64 and 2.5.65.  Can you try both of those?

hmm, I see a "fixme" and an interruptible_sleep_on_timeout() around that
error message.  Do the hangs happen on uniprocessor, non-preemptible
kernels?

