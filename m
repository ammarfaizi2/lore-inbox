Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278075AbRJOU7A>; Mon, 15 Oct 2001 16:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278347AbRJOU6u>; Mon, 15 Oct 2001 16:58:50 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:4358 "EHLO
	deathstar.prodigy.com") by vger.kernel.org with ESMTP
	id <S278075AbRJOU6g>; Mon, 15 Oct 2001 16:58:36 -0400
Date: Mon, 15 Oct 2001 16:59:09 -0400
From: Bill Davidsen <davidsen@deathstar.prodigy.com>
Message-Id: <200110152059.f9FKx9q00507@deathstar.prodigy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: TCP acking too fast
X-Newsgroups: linux.dev.kernel
In-Reply-To: <3BC8DAF0.3D16A546@welho.com>
Organization: Prodigy http://www.prodigy.com/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3BC8DAF0.3D16A546@welho.com> Mika.Liljeberg@welho.com wrote:

>I've already disabled quickacks, replaced the receive MSS estimate with
>advertised MSS in the ack sending policy (two places), and removed one
>dubious "immediate ack" condition from send_delay_ack(). The annoying
>thing is that none of this seem to make any real difference. I must be
>missing something huge that's right in front of my nose, but I'm
>starting to run out of steam.
>
>Any thoughts on this?

The discussion has been most complete, I guess at this point is you
can't fix the sender to stop this anti-social behaviour, you might try
using iptables to "mangle" the PSH off from this host or rate limit the
ACKs, or some other hack. None of which is a "solution," just some
interesting things to try.

As noted, the core problem is that TCP doesn't like really asymmetric
bandwidth.

-- 
bill davidsen <davidsen@tmr.com>
 "If I were a diplomat, in the best case I'd go hungry.  In the worst
  case, people would die."
		-- Robert Lipe
