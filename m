Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317475AbSFECVQ>; Tue, 4 Jun 2002 22:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317489AbSFECVP>; Tue, 4 Jun 2002 22:21:15 -0400
Received: from dsl-213-023-043-246.arcor-ip.net ([213.23.43.246]:29366 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317475AbSFECVP>;
	Tue, 4 Jun 2002 22:21:15 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Oliver Xymoron <oxymoron@waste.org>
Subject: Re: [ANNOUNCE] Adeos nanokernel for Linux kernel
Date: Wed, 5 Jun 2002 04:20:42 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0206041418460.2614-100000@waste.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17FQPj-0001Rr-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 June 2002 21:29, Oliver Xymoron wrote:
> On Mon, 3 Jun 2002, Daniel Phillips wrote:
> 
> > traditional IT.  Not to mention that I can look forward to a sound
> > system where I can be *sure* my mp3s won't skip.
> 
> Not unless you're loading your entire MP3 into memory, mlocking it down,
> and handing it off to a hard RT process. And then your control of the
> playback of said song through a non-RT GUI could be arbitrarily coarse,
> depending on load.

Thanks for biting :-)

First, these days it's no big deal to load an entire mp3 into memory.  

Second, and of more interest to broadcasting industry professionals and the 
like, it's possible to write a real-time filesystem that bypasses all the 
normal non-realtime facilities of the operating system, and where the latency 
of every operation is bounded according to the amount of data transferred.  
Such a filesystem could use its own dedicated disk, or, more practically, the 
RTOS (or realtime subsystem) could operate the disk's block queue.

If I recall correctly, XFS makes an attempt to provide such realtime 
guarantees, or at least the Solaris version does.  However, the operating 
system must be able to provide true realtime guarantees in order for the 
filesystem to provide them, and I doubt that the combination of XFS and 
Solaris can do that.

-- 
Daniel
