Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751176AbWDEISZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbWDEISZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 04:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWDEISZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 04:18:25 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:17144 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S1751176AbWDEISY (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 04:18:24 -0400
Subject: Re: [OOPS] related to swap?
From: Ian Kumlien <pomac@vapor.com>
Reply-To: pomac@vapor.com
To: nickpiggin@yahoo.com.au
Cc: Linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 05 Apr 2006 08:22:43 +0000
Message-Id: <1144225363.7112.10.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ian Kumlien wrote:
>
> > Yes, i run a tainted kernel! either live with it or ignore this mail
> > =)
>
> > starting swap lead to a deadlock within 15 mins
>
> > I have never had the energy to perform a full memtext86+
>
> It would be useful if you could perform a memtest overnight one night,
> then run a non-patched and non-tained 2.6.16.1 kernel, and try to
> reproduce the problems.

As i said, i really doubt that the memory is at fault here, it has done
several passes over the memory but not all tests. I can give it a go
though, but i really doubt it'll find anything.

The kernel i run is a plain 2.6.16.1 from kernel.org (i have heard that
you can actually compile gentoos own these days)

Since this is my *cough* desktop, running it without that ability is
kinda a show stopper, thats why i included the thing above.

But the thing is, my laptop runs with the same compiler, "same" nvidia
driver and the "same" kernel ("same" as in 32 bit not 64 bit).
Eventhough "same" in this case usually means nothing, i doubt that one
would have a serius bug and the other wouldn't, ie it's most likley a
bug related to 64 bits or one or more of the drivers involved.

The only errors i get in dmesg atm is:
KERNEL: assertion (!sk->sk_forward_alloc) failed at net/core/stream.c
(283)
KERNEL: assertion (!sk->sk_forward_alloc) failed at net/ipv4/af_inet.c
(150)

Which is related to TSO, from what i gather, but i can't turn off tso on
forcedeth... (i suspected this to cause corruption a while back....)

And:
eth0: too many iterations (6) in nv_nic_irq.

Which seems to be a warning of some sort (haven't checked the source
yet).

PS. Reply-to-all is your friend... =)
DS.

-- 
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

