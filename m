Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314096AbSEFFhC>; Mon, 6 May 2002 01:37:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314101AbSEFFhB>; Mon, 6 May 2002 01:37:01 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13329 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314096AbSEFFhB>;
	Mon, 6 May 2002 01:37:01 -0400
Message-ID: <3CD61705.3468C3EB@zip.com.au>
Date: Sun, 05 May 2002 22:39:17 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: thunder7@xs4all.nl
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.13 error:  kswapd: page allocation failure. order:0 mode:0x20
In-Reply-To: <20020506051832.GA8595@alpha.of.nowhere>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jurriaan on Alpha wrote:
> 
> Suddenly, after 36 hours uptime, the console was flooded with this
> message.

36 hours is probably a world record ;)


> May  6 06:54:24 alpha -- MARK --
> May  6 07:11:28 alpha kernel: apd: page allocation failure. order:0, mode:0x20

It's possible that the machine really did run out of memory.  There
are some scenarios with memory-mapped holey files and with swap which
can result in unfreeable memory.  2.5.14 is better.

> May  6 07:11:28 alpha kernel: kswapd: page allocation failure. order:0, mode:0x20
> May  6 07:11:28 alpha last message repeated 296 times

It's just a warning.  2.5.14 will calm it down.

-
