Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129532AbQJaP51>; Tue, 31 Oct 2000 10:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129523AbQJaP5S>; Tue, 31 Oct 2000 10:57:18 -0500
Received: from nathan.polyware.nl ([193.67.144.241]:15119 "EHLO
	nathan.polyware.nl") by vger.kernel.org with ESMTP
	id <S129278AbQJaP5H>; Tue, 31 Oct 2000 10:57:07 -0500
Date: Tue, 31 Oct 2000 16:57:02 +0100
From: Pauline Middelink <middelink@polyware.nl>
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: kmalloc() allocation.
Message-ID: <20001031165702.A21402@polyware.nl>
Mail-Followup-To: Pauline Middelink <middelin@polyware.nl>,
	Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0010311134590.23139-100000@duckman.distro.conectiva> <Pine.LNX.3.95.1001031084051.13415A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.3.95.1001031084051.13415A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Tue, Oct 31, 2000 at 08:59:53AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2000 around 08:59:53 -0500, Richard B. Johnson wrote:
[snip]

> Since Linux is starting to be used in many 'strange' non-desktop
> environments, maybe it's time to provide a hook to reserve the
> top N kilobytes of RAM for strange buffers. Like:
> 
> 	append="..,reserve=2M".
> 
> Upon startup, a pointer, valid when using the kernel DS, could be
> initialized to point to the beginning of this area. This is essentially
> zero overhead for the kernel because it just points to one longword
> greater than the RAM the kernel will use.

Please look at bigphysarea, it allocates a piece of meory at boottime
and has a small allocator over it to dispatch it to drivers. Mostly
video framegrabbers at this time... But the interface et all is there...

	http://www.polyware.nl/~middelink/En/hob-v4l.html

    Met vriendelijke groet,
        Pauline Middelink
-- 
PGP Key fingerprint = DE 6B D0 D9 19 AD A7 A0  58 A3 06 9D B6 34 39 E2
For more details look at my website http://www.polyware.nl/~middelink
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
