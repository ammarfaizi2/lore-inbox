Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271756AbTHMLE6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 07:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271758AbTHMLE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 07:04:58 -0400
Received: from colin2.muc.de ([193.149.48.15]:7944 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S271756AbTHMLE5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 07:04:57 -0400
Date: 13 Aug 2003 13:04:53 +0200
Date: Wed, 13 Aug 2003 13:04:53 +0200
From: Andi Kleen <ak@colin2.muc.de>
To: Martin Pool <mbp@sourcefrog.net>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: KDB in the mainstream 2.4.x kernels?
Message-ID: <20030813110453.GA26019@colin2.muc.de>
References: <aJIn.3mj.15@gated-at.bofh.it> <m3smp3y38y.fsf@averell.firstfloor.org> <pan.2003.08.13.04.40.27.59654@sourcefrog.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pan.2003.08.13.04.40.27.59654@sourcefrog.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 02:40:31PM +1000, Martin Pool wrote:
> On Fri, 18 Jul 2003 22:43:57 +0200, Andi Kleen wrote:
> 
> > KDB is usually not useful for debugging hangs on desktop boxes (and even
> > many servers) because you have usually X running. When the machine crashes
> > and goes in KDB you cannot see the text output and debug anything. I
> > learned to type "go<return>" blind when I had still an KDB aware kernel,
> > but it's not very useful overall.
> 
> Perhaps in the case where the console is on a vt, kdb could try to
> switch to the right vc before presenting its prompt?  I realize calling into
> the vc code might be risky but it seems like there's not much to lose.  
> (If you do have a bug in say the agp driver then you need a serial
> console...)   If it works, you'll be able to debug and continue.

Only the X server can switch away, because only it knows how 
to talk to the graphic chipset. And running user space here is 
far too risky.

It's possible when the resolutions are controlled by the kernel
in fbcon. That's the case on linux/ppc and you can indeed debug on
top of an X server there. But it's unlikely to happen for linux/x86, the
xfree86 people don't want to move parts of their drivers into the kernel.

-Andi

