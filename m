Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263561AbTJQR0c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 13:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263562AbTJQR0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 13:26:32 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:31466 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S263561AbTJQR02
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 13:26:28 -0400
Message-ID: <02b901c394d3$96c662e0$890010ac@edumazet>
From: "dada1" <dada1@cosmosbay.com>
To: "David S. Miller" <davem@redhat.com>
Cc: <lm@bitmover.com>, <albert@users.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
References: <1066356438.15931.125.camel@cube><20031017023437.GB28158@work.bitmover.com><01e601c39484$f3fa31c0$890010ac@edumazet> <20031017021040.4964309a.davem@redhat.com>
Subject: Re: /proc reliability & performance
Date: Fri, 17 Oct 2003 19:24:56 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "David S. Miller" <davem@redhat.com>
> "dada1" <dada1@cosmosbay.com> wrote:
>
> > A "cat /proc/net/tcp" takes too much time to even try it. :(
> >
> > tools like "netstat" or "lsof", (even with -n flag) are just unusable.
>
> Because they don't use the netlink TCP socket dumping
> facility which is made to handle such things much better
> than procfs ever can.

Thanks David for the hint. :) I buy it.

I found that the ss command from iproute2 package does use the 'netlink TCP
dumping' you mention (how many people on earth heard about that ?)

Instead of 15 minutes for a 'netstat -n > FILE', my server takes now 6
seconds with 'ss -n > FILE', with 200000 sockets opened.

Eric

