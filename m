Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267489AbSLEV0X>; Thu, 5 Dec 2002 16:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267446AbSLEVZo>; Thu, 5 Dec 2002 16:25:44 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:9232 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S267489AbSLEVYz>; Thu, 5 Dec 2002 16:24:55 -0500
Date: Thu, 5 Dec 2002 22:32:29 +0100
From: Pavel Machek <pavel@suse.cz>
To: "David S. Miller" <davem@redhat.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org, hubicka@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] Start of compat32.h (again)
Message-ID: <20021205213229.GF3870@atrey.karlin.mff.cuni.cz>
References: <20021204111947.GB309@elf.ucw.cz> <20021205.130614.99253893.davem@redhat.com> <20021205212120.GA1386@elf.ucw.cz> <20021205.132213.111260405.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021205.132213.111260405.davem@redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>    > How about some test where relocations come into play?
>    > spec2000 is a bad example, it's just crunch code.
>    
>    time ./configure might be a good test...
>    
> Agreed.
> 
>    > Most systems spend their time running quick small executables over and
>    > over, and in such cases relocation overhead shows up very strongly.
>    
>    Really? What workload besides configure does many small programs?
>    
> What do you do when you're developing code?  make, edit, ldd, ls,
> grep, etc.

Yes, but as developing code is human-bound (waits for my input most of
the time), it is not *that* important. [It is probably still nice to
have it fast.]

OTOH: gcc is faster 64-bit, and if you mix 32-bit and 64-bit, you
loose caches and have twice as many libraries. I guess 5% faster gcc
is more important than 30% slower ls...

								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
