Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317258AbSH3MOK>; Fri, 30 Aug 2002 08:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319554AbSH3MOK>; Fri, 30 Aug 2002 08:14:10 -0400
Received: from 2-210.ctame701-1.telepar.net.br ([200.193.160.210]:57984 "EHLO
	2-210.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S317258AbSH3MOK>; Fri, 30 Aug 2002 08:14:10 -0400
Date: Fri, 30 Aug 2002 09:18:17 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: "Pedro M. Rodrigues" <pmanuel@myrealbox.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: nfs & "Warning - running *really* short on DMA buffers"
In-Reply-To: <3D6F7650.32578.A1B755@localhost>
Message-ID: <Pine.LNX.4.44L.0208300916580.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Aug 2002, Pedro M. Rodrigues wrote:

>    I do wan't to tune the vm settings, these warnings may not be
> fatal but it's not pretty to have hundreds of those in the console
> and log files. Bear with me on this one, but i remember doing exactly
> that in the past, tuning  /proc/sys/vm/freepages. How does one
> acomplish that nowadays? I looked at the kernel source documentation
> and still found references to freepages, but vm/freepages doesn't
> exist anymore. Kernel is 2.4.18-10 from Redhat.

For fundamental reasons it's always possible for non-sleeping
allocations to fail.  I think this warning just needs to be
rate-limited, if it isn't already ...

OTOH, failed allocations could serve as a hint for kswapd to
try to keep more memory free. I should look into that for some
next version.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

