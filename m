Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265402AbRGJD2H>; Mon, 9 Jul 2001 23:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265405AbRGJD15>; Mon, 9 Jul 2001 23:27:57 -0400
Received: from sync.nyct.net ([216.44.109.250]:64527 "HELO sync.nyct.net")
	by vger.kernel.org with SMTP id <S265402AbRGJD1z>;
	Mon, 9 Jul 2001 23:27:55 -0400
Date: Mon, 9 Jul 2001 23:29:03 -0400
From: Michael Bacarella <mbac@nyct.net>
To: jlnance@intrex.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: What is the truth about Linux 2.4's RAM limitations?
Message-ID: <20010709232903.A29136@sync.nyct.net>
In-Reply-To: <Pine.LNX.4.32.0107091250170.25061-100000@maus.spack.org> <20010709230151.A13704@bessie.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010709230151.A13704@bessie.localdomain>; from jlnance@intrex.net on Mon, Jul 09, 2001 at 11:01:51PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2001 at 11:01:51PM -0400, jlnance@intrex.net wrote:
> Next I patched the hoard allocator so that instead of calling mmap(0, ...)
> it would call it as something like mmap(0x10000000, ...) which causes it
> to start allocating memory that would normally be reserved for sbrk().
> I think I could get close to 2.5G from the hoard malloc after this patch.
> This change got incorporated into the latest hoard, but I had problems
> building the latest hoard, so you may want to wait for a future release.
> 
> Anyway, I just wanted to let you know that there are some glibc issues that
> are more restrictive than the kernel issues.

dietlibc is pretty funky:

http://www.fefe.de/dietlibc/

I'm not sure if it's memory usage patterns are all that different from
glibc (as I haven't checked). If so, it may still be easier to
hack than something as uh.. established.. as glibc.

-- 
Michael Bacarella <mbac@nyct.net>
Technical Staff / System Development,
New York Connect.Net, Ltd.
