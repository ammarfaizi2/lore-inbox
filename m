Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316609AbSGYW1R>; Thu, 25 Jul 2002 18:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316610AbSGYW1R>; Thu, 25 Jul 2002 18:27:17 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:35531 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S316609AbSGYW1Q>;
	Thu, 25 Jul 2002 18:27:16 -0400
From: Cort Dougan <cort@fsmlabs.com>
Date: Thu, 25 Jul 2002 16:23:22 -0600
To: Russell King <rmk@arm.linux.org.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cheap lookup of symbol names on oops()
Message-ID: <20020725162322.A2276@host110.fsmlabs.com>
References: <20020725110033.G2276@host110.fsmlabs.com> <1027637183.11604.8.camel@irongate.swansea.linux.org.uk> <20020725154425.T2276@host110.fsmlabs.com> <20020725231822.H9800@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020725231822.H9800@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Thu, Jul 25, 2002 at 11:18:22PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've had the stack backtrace cause cascading oops' that scroll until I
power a machine off.  It's a crash - things aren't always going to work
out.  Arguments like that can be made to remove nearly the entire oops
message.

The patch as it is now doesn't even add a line of text to the x86 oops
message.  It does add a line to the PPC oops message though.  I understand,
and agree with, the need for brevity in a oops.

Would you be happy with the lookup function as a config option rather than
the default?

} I recently had an oops on my laptop with a rh kernel with I think this
} stuff in (it decoded the trace to symbols, etc).
} 
} The only problem was that the machine paniced at the end, with the
} register dump off the top of the screen.  The only thing visible was
} the trace.
} 
} As useful as it was to have the trace, the oops was useless because
} the rest of the information was missing.
} 
} So why didn't I scroll up?  Because shift-pgup needs a task queue to
} run, which doesn't happen after a panic, just like you can't ctrl-alt-del
} to reboot (but you can alt-sysrq-b)...
} 
} Personally, I'd much rather have the standard oops output and be able
} to scribble down the numbers, and then look them up than to have some
} snazzy bit of code in the kernel do it for me and scroll the useful
} information off the screen.
} 
} (And thanks for reminding me about the oops...)
} 
} -- 
} Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
}              http://www.arm.linux.org.uk/personal/aboutme.html
