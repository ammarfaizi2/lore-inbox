Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288109AbSACCK5>; Wed, 2 Jan 2002 21:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288126AbSACCKs>; Wed, 2 Jan 2002 21:10:48 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:61061
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S288109AbSACCKm>; Wed, 2 Jan 2002 21:10:42 -0500
Date: Wed, 2 Jan 2002 19:10:21 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] C undefined behavior fix
Message-ID: <20020103021021.GW1803@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <E16Lvh8-0006E6-00@the-village.bc.nu> <25193.1010018130@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25193.1010018130@redhat.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2002 at 12:35:30AM +0000, David Woodhouse wrote:
> 
> (cc list trimmed)
> 
> alan@lxorguk.ukuu.org.uk said:
> >  If you want a strcpy that isnt strcpy then change its name or use a
> > different language 8)
> 
> The former is not necessarily sufficient in this case. You've still done the
> broken pointer arithmetic, so even if the function isn't called strcpy() the
> compiler is _still_ entitled to replace it with a call to memcpy() or even
> machine_restart() before sleeping with your mother and starting WW III.
> 
> Granted, it probably _won't_ do any of those today, but you should know
> better than to rely on that.
> 
> What part of 'undefined behaviour' is so difficult for people to understand?

I think it comes down to an expectation that if the behaviour is
undefined, anything _could_ happen, but what should happen is that it
should just be passed along to (in this case) strcpy un-modified.
Anything _could_ happen, but why do something that probably won't help
all the same?

But this is moot anyhow since I _think_ Paul's suggestion of doing RELOC
and friends as asm will work (and echo'd by rth?).

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
