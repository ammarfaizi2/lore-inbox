Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270883AbTGNVlA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 17:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270904AbTGNVlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 17:41:00 -0400
Received: from waste.org ([209.173.204.2]:42898 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S270883AbTGNVkh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 17:40:37 -0400
Date: Mon, 14 Jul 2003 16:55:01 -0500
From: Matt Mackall <mpm@selenic.com>
To: Roland Dreier <roland@topspin.com>
Cc: simon@baydel.com, linux-kernel@vger.kernel.org
Subject: Re: PPC 440 System
Message-ID: <20030714215501.GB19001@waste.org>
References: <3F12A1B9.3086.614B56@localhost> <524r1pw0bd.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <524r1pw0bd.fsf@topspin.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 14, 2003 at 09:16:38AM -0700, Roland Dreier wrote:
>     simon> If I remove /sbin/init from the nfs root the kernel panics
>     simon> as expected, so I assume root is mounted ok. I have tried
>     simon> to build a minimum root filesystem which contains
>     simon> /dev/console, /dev/ttyS0 and a statically linked
>     simon> /sbin/init. The init just does a printf but I do not see
>     simon> this message. Does anyone know it this should work ?
> 
> Yes, a static /sbin/init should work.
> 
>     simon> Initially I tried to build a root filesystem from files on
>     simon> a Mac Clone running Yellow Dog Linux. I believe this has a
>     simon> PPC 604e processor. Should this systems binaries/libraries
>     simon> run on the 440GP ?
> 
>     simon> Can I expect a statically linked executable, made on the
>     simon> Mac, to run on the 440GP?
> 
> Probably not.  The 440GP has no floating point hardware, so you will
> need (at least) to build a special glibc without FP instructions and
> also make sure your gcc is set up not to generate FP instructions.

You can build a 440 kernel with FPU emulation and it will run native
apps just fine, otherwise they'll core dump. I bootstrapped a full
native Debian PPC system on an Ebony board a few months ago.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
