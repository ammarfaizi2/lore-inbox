Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263723AbTDXPx3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 11:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263726AbTDXPx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 11:53:29 -0400
Received: from chaos.analogic.com ([204.178.40.224]:47497 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263723AbTDXPx2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 11:53:28 -0400
Date: Thu, 24 Apr 2003 11:59:16 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: Jens Axboe <axboe@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.21-rc1 pointless IDE noise reduction
In-Reply-To: <200304241128_MC3-1-35DA-F3DA@compuserve.com>
Message-ID: <Pine.LNX.4.53.0304241147420.32073@chaos>
References: <200304241128_MC3-1-35DA-F3DA@compuserve.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Apr 2003, Chuck Ebbert wrote:

> Jens Axboe wrote:
>
>
> >> +	return((drive->id->cfs_enable_1 & 0x0400) ? 1 : 0);
> >>  }
> >
> > Seconded, it causes a lot more confusion than it does good.
>
>   The return looks like a function call in that last line.
>
>   That's one of the few things I find really annoying -- extra parens
> are fine when they make code clearer, but not there.
>
>
> -------
>  Chuck [ C Style Police, badge #666 ]

return((drive->id->cfs_enable_1 & 0x0400) ? 1 : 0);
                                  ^^^^^^|__________ wtf?
These undefined numbers in the code are much more annoying to me...
but I don't have a C Style Police Badge.

Also, whatever that is, 0x400, I'll call it MASK, can have shorter
code like:

   return (drive->id->cfs_enable_1 && MASK); // TRUE/FALSE
... for pedantics...
   return (int) (drive->id->cfs_enable_1 && MASK);

Okay, gimmie a C Police Badge.......

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

