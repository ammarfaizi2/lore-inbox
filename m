Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317181AbSFKQuW>; Tue, 11 Jun 2002 12:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317182AbSFKQuV>; Tue, 11 Jun 2002 12:50:21 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:51427 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S317181AbSFKQuV>; Tue, 11 Jun 2002 12:50:21 -0400
Date: Tue, 11 Jun 2002 17:49:51 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Thunder from the hill <thunder@ngforever.de>,
        Dave Jones <davej@suse.de>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        linux-kernel@vger.kernel.org, chaffee@cs.berkeley.edu
Subject: Re: [patch] fat/msdos/vfat crud removal
Message-ID: <20020611174951.A24310@kushida.apsleyroad.org>
In-Reply-To: <200206092104.g59L4JD448386@saturn.cs.uml.edu> <m1vg8rutjm.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> Actually by now most applications have been fixed and do not use
> them.  The policy has been in place for several years now.

I like this policy and understand how to use it, except...

Once upon a time I wrote a program which used O_NOFOLLOW, before Glibc
had support for that flag.

It had to read the kernel headers, as this macro is an
architecture-dependent flag, and I did not want to write a program that
was so non-portable it would only compile on some architectures.

Even if I'd copied all the definitions for all architectures out of the
kernel, that wouldn't do: the program wouldn't compile on architectures
added later, or ones that aren't part of the standard distribution.

So to keep the program relatively portable, it searched for definitions
of O_NOFOLLOW in the kernel headers.  (It was a Glibc/kernel conflict
nightmare).

Please can you suggest how I should write this sort of code, the next
time it occurs?

thanks,
-- Jamie
