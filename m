Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262035AbTHTVRI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 17:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262217AbTHTVRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 17:17:08 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:20402
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S262035AbTHTVRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 17:17:04 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Wiktor Wodecki <wodecki@gmx.de>
Subject: Re: [PATCH] O17int
Date: Thu, 21 Aug 2003 07:23:42 +1000
User-Agent: KMail/1.5.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <200308200102.04155.kernel@kolivas.org> <20030820162736.GA711@gmx.de>
In-Reply-To: <20030820162736.GA711@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308210723.42789.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Aug 2003 02:27, Wiktor Wodecki wrote:
> On Wed, Aug 20, 2003 at 01:01:28AM +1000, Con Kolivas wrote:
> > Food for the starving masses.
>
> snip
>
> Sorry, but I still have the starving problem. the more I use O16/O17 the
> more problems I encounter. xterms sometimes wake up after half a second
> for another half a second and falls asleep for a whole second then.
> after that, it's fully interactive. io-load seems to produce the
> problem. a simple tar xf linux-2.6.0-test3.tar seems to halt the system.

I can't reproduce your problem here until I hit swap hard. You sure that's not 
happening? Kernel threads do get slight extra priority over regular threads 
by now which should help throughput under load. Perhaps this has tipped the 
balance on your machine when you hit swap pressure hard. Do a vmstat run 
while you can reproduce the problem.

> new processes take ages to start. This also happend to me on O16.2.

But not in 16.3?

> Maybe it's because some AS patches are missing in vanilla but are in
> 2.6.0-test3-mm?

As Nick said, no this isn't the case.

Con

