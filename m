Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270387AbRHSNWl>; Sun, 19 Aug 2001 09:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270401AbRHSNWb>; Sun, 19 Aug 2001 09:22:31 -0400
Received: from ns.suse.de ([213.95.15.193]:16391 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S270387AbRHSNW0>;
	Sun, 19 Aug 2001 09:22:26 -0400
Date: Sun, 19 Aug 2001 15:22:40 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: "Serguei I. Ivantsov" <administrator@svitonline.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.x & Celeron = very slow system
In-Reply-To: <1021859034.20010819160618@svitonline.com>
Message-ID: <Pine.LNX.4.30.0108191519430.22917-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Aug 2001, Serguei I. Ivantsov wrote:

> With 2.4.x kernel my system (Celeron (Coppermine) 850Mhz (100x8.5)
> 256Mb i810) behaves like slow i386sx.
>
> For example, when I extract 25MB gzip file on 2.2.19 kernel - it
> takes about 12 seconds, but with 2.4.8(9) - 6(!) MINUTES on the SAME
> system...
>
> The only idea is that 2.4.x kernel turns off cache (L1 & L2) on
> processor (on my cpu). How can I check it? Any ideas?

No, we don't do any such frobbing of the cache control registers.
It is enabled in the BIOS right ?

Another thing that it might be, is if you're using ACPI instead of
APM, the cpu-idle may be causing the CPU to run slower than usual
though throttling.

Although, I've not seen this happen to the extent of what you're
reporting.  If you are running with an ACPI kernel, try booting
with an APM kernel instead to see if it makes a difference.

regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

