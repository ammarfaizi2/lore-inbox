Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262531AbSJGQtV>; Mon, 7 Oct 2002 12:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262526AbSJGQtU>; Mon, 7 Oct 2002 12:49:20 -0400
Received: from auto-matic.ca ([216.209.85.42]:57092 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S262531AbSJGQtT>;
	Mon, 7 Oct 2002 12:49:19 -0400
Date: Mon, 7 Oct 2002 12:53:45 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: "David S. Miller" <davem@redhat.com>
Cc: nico@cam.org, rmk@arm.linux.org.uk, simon@baydel.com,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: The end of embedded Linux?
Message-ID: <20021007165345.GA3068@mark.mielke.cc>
References: <20021007125755.A5381@flint.arm.linux.org.uk> <Pine.LNX.4.44.0210071148450.913-100000@xanadu.home> <20021007.090233.107701780.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021007.090233.107701780.davem@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2002 at 09:02:33AM -0700, David S. Miller wrote:
>    From: Nicolas Pitre <nico@cam.org>
>    Date: Mon, 7 Oct 2002 12:05:16 -0400 (EDT)
>    2) Not inlining inb() and friend reduce the bloat but then you further 
>       impact performances on CPUs which are generally many order of
>       magnitude slower than current desktop machines.
> I don't buy this one.  You are saying that the overhead of a procedure
> call is larger than the overhead of going out over the I/O bus to
> touch a device?

I think the key phrase is 'further impact'.

If anything, the procedure call increases latency.

Although... I don't see why CONFIG_TINY wouldn't be able to decide whether
inb() should be inlined or not...

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

