Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267524AbUG2Wrj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267524AbUG2Wrj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 18:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262906AbUG2Wpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 18:45:32 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:4044 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267467AbUG2WlI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 18:41:08 -0400
Message-ID: <b71082d80407291541f9d6f93@mail.gmail.com>
Date: Fri, 30 Jul 2004 00:41:03 +0200
From: Bart Alewijnse <scarfboy@gmail.com>
To: netdev@oss.sgi.com
Subject: Re: gigabit trouble
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040729210401.A32456@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <b71082d8040729094537e59a11@mail.gmail.com> <20040729210401.A32456@electric-eye.fr.zoreil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was going to do an exhaustive test, but because my computer stopped
running completely, I'll reply to the one or two bits I can now.

On Thu, 29 Jul 2004 21:04:01 +0200, Francois Romieu
<romieu@fr.zoreil.com> wrote:
> Bart Alewijnse <scarfboy@gmail.com> :
> [...]
> > I run gentoo on both, which until yesterday was 2.6.7-ck5 (on both),
> > and currently run 2.6.7-mm6 (again, both), as I saw the suggestion
> > somewhere it had better support for the card - something about a new
> > net card inferface that's nicer to interrupts.
> 
> NAPI support for r8169 is available in recent -mm kernel and there is
> a small (though noticeable) optimization wrt to interrupt disabling.
Well, I noticed a max of 6500 interrupts/s on eth1 on both computers, with or
without napi - and that 6500 is also the figure of packets per second.
So I'm slightly dubious. (notice 6500 *1500 bytes is about 10MB/s)

> [...]
> > So, question one - how do I see the link speed under linux, and how,
> > if at all, do I control it?
> 
> ethtool
Thanks. That wasn't the problem - the line speed's a gbit.

> [...]
> > Disturbingly, in such a linux-to-linux speed test, my new computer
> > froze.As in, in text mode, have the screen freeze and apparently be
> > half written full of nonsense.
> 
> These messages would be welcome (pen/paper/serial line/image/log file
> or whatever).

No messages, no oops, no log messages that I noticed. 
It was video memory corruption in text mode.

As to the rest, I'll do it when I revive my computer. Right now, I'm
thinking the power supply may be dodgy. I'll see if I can get
a minimum to run off my even older 235Watt. But as a note,
with two cards, two cdroms and a hard drive less, it was still
making the noise. I think it still is now, but since no OS actually
boots completely right now, I can't say for sure.
I'll do a memtest, that makes sense.

--Bart
