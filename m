Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316582AbSGYWPL>; Thu, 25 Jul 2002 18:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316588AbSGYWPK>; Thu, 25 Jul 2002 18:15:10 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:55815 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316582AbSGYWPK>; Thu, 25 Jul 2002 18:15:10 -0400
Date: Thu, 25 Jul 2002 23:18:22 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Cort Dougan <cort@fsmlabs.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cheap lookup of symbol names on oops()
Message-ID: <20020725231822.H9800@flint.arm.linux.org.uk>
References: <20020725110033.G2276@host110.fsmlabs.com> <1027637183.11604.8.camel@irongate.swansea.linux.org.uk> <20020725154425.T2276@host110.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020725154425.T2276@host110.fsmlabs.com>; from cort@fsmlabs.com on Thu, Jul 25, 2002 at 03:44:25PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2002 at 03:44:25PM -0600, Cort Dougan wrote:
> You don't lose the hex data.  The patch just prints data that the kernel
> already has.  For some situations this patch does match the needs of
> developers better.

I recently had an oops on my laptop with a rh kernel with I think this
stuff in (it decoded the trace to symbols, etc).

The only problem was that the machine paniced at the end, with the
register dump off the top of the screen.  The only thing visible was
the trace.

As useful as it was to have the trace, the oops was useless because
the rest of the information was missing.

So why didn't I scroll up?  Because shift-pgup needs a task queue to
run, which doesn't happen after a panic, just like you can't ctrl-alt-del
to reboot (but you can alt-sysrq-b)...

Personally, I'd much rather have the standard oops output and be able
to scribble down the numbers, and then look them up than to have some
snazzy bit of code in the kernel do it for me and scroll the useful
information off the screen.

(And thanks for reminding me about the oops...)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

