Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263239AbTGTIDf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 04:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263281AbTGTIDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 04:03:35 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:23309 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S263239AbTGTIDd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 04:03:33 -0400
Date: Sun, 20 Jul 2003 10:13:21 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>, Mark Cooke <mpc@star.sr.bham.ac.uk>
Subject: Re: pre6 oddity (fwd)
Message-ID: <20030720081321.GC643@alpha.home.local>
References: <Pine.LNX.4.55L.0307191805200.11090@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0307191805200.11090@freak.distro.conectiva>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

This was a procps bug. 2.0.11 I believe. There was something like a
printf("%ull", prio) with prio=-1, which prints 2^64-1 (the high number seen
here). Upgrading to 2.0.13 fixed the problem for me.

Cheers,
Willy

On Sat, Jul 19, 2003 at 06:07:42PM -0300, Marcelo Tosatti wrote:
> 
> Bogus.
> 
> ---------- Forwarded message ----------
> Date: 19 Jul 2003 08:54:55 +0100
> From: Mark Cooke <mpc@star.sr.bham.ac.uk>
> To: Marcelo Tosatti <marcelo@conectiva.com.br>
> Subject: pre6 oddity
> 
> Hi Marcelo,
> 
> On two of my machines running pre6, I am seeing top report very odd
> priorities for two kernel tasks:
> 
>   PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME CPU
> COMMAND
> 
>     8 root     18446744073709551615 -20     0    0     0 SW<   0.0
> 0.0   0:00   0 mdrecoveryd
>    16 root     18446744073709551615 -20     0    0     0 SW<   0.0
> 0.0   0:00   0 raid1d
> 
> 
> Something related to the scheduling changes going on ?
> 
> (RedHat 9 base system)
> 
> Mark
> 
> -- 
> Mark Cooke <mpc@star.sr.bham.ac.uk>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
