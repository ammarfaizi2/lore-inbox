Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131953AbRAZPPY>; Fri, 26 Jan 2001 10:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132147AbRAZPPO>; Fri, 26 Jan 2001 10:15:14 -0500
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:27408 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S131953AbRAZPPF>; Fri, 26 Jan 2001 10:15:05 -0500
Date: Fri, 26 Jan 2001 10:15:02 -0500 (EST)
From: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux Post codes during runtime, possibly OT
In-Reply-To: <Pine.LNX.3.95.1010126095653.762A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.10.10101261012010.18973-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  #ifdef SLOW_IO_BY_JUMPING
>  #define __SLOW_DOWN_IO "\njmp 1f\n1:\tjmp 1f\n1:"
>  #else
> -#define __SLOW_DOWN_IO "\noutb %%al,$0x80"
> +#define __SLOW_DOWN_IO "\noutb %%al,$0x19"

this is nutty: why can't udelay be used here?  empirical measurements
in the thread show the delay is O(2us).

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
