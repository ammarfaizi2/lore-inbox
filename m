Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314554AbSEKQNZ>; Sat, 11 May 2002 12:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316233AbSEKQNY>; Sat, 11 May 2002 12:13:24 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:29700 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314554AbSEKQNY>; Sat, 11 May 2002 12:13:24 -0400
Date: Sat, 11 May 2002 17:10:24 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: george anzinger <george@mvista.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 64-bit jiffies, a better solution take 2
Message-ID: <20020511171024.D1574@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.33.0205101538400.25826-100000@penguin.transmeta.com> <3CDC6906.B0288387@mvista.com> <20020511092935.A16828@flint.arm.linux.org.uk> <3CDD324E.4E1C4FB6@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 11, 2002 at 08:01:34AM -0700, george anzinger wrote:
> #ifdef __ARMEB__
> #include <linux/byteorder/big_endian.h>
> #else
> #include <linux/byteorder/little_endian.h>
> #endif
> 
> So, yes, given no hints on who or what configures __ARMEB__.
> Is it always little endian?

Most sane people use ARM in little endian mode.  However, there are a few
insane people (mostly from the Telecoms sector) who like to put the chips
into the (broken) big endian mode.

We don't fully support big endian in the -rmk kernel (and therefore Linus'
kernel) yet.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

