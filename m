Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289004AbSAUCLq>; Sun, 20 Jan 2002 21:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289010AbSAUCLh>; Sun, 20 Jan 2002 21:11:37 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:18180 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S289004AbSAUCLX>; Sun, 20 Jan 2002 21:11:23 -0500
Date: Mon, 21 Jan 2002 02:13:55 +0000
From: John Levon <movement@marcelothewonderpenguin.com>
To: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: Re: Hardwired drivers are going away?
Message-ID: <20020121021355.GA60801@compsoc.man.ac.uk>
In-Reply-To: <3C4B6F24.C2750F51@zip.com.au> <32505.1011578008@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32505.1011578008@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Bendik Singers - Afrotid
X-Toppers: N/A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2002 at 12:53:28PM +1100, Keith Owens wrote:

> >How often have we seen nonsensical backtraces here because
> >modules were involved?   Possibly we can include a table
> >of module base addresses in the Oops output and teach ksymoops
> >about it.
> 
> You see nonsensical backtraces because people persist in using the oops
> decode option of klogd which is broken when faced with modules.  Turn
> off klogd oops (klogd -x) and you get a raw backtrace which ksymoops
> can handle.  Guess why these entries are in /proc/ksyms?
> 
> c48a2300 __insmod_3c589_cs_S.bss_L4	[3c589_cs]

and quite often the user has unloaded / loaded modules in the meantime
and the oops is useless.

It would be nice if klogd's oops detection just passed everything to ksymoops
untouched, and stored everything somewhere using -m

I don't see any reason why the internal profiler can't have an extended EIP
range to catch module samples either. Perhaps I'm missing something. Perhaps
no one cares enough ...

regards
john

-- 
"I hope you will find the courage to keep on living 
 despite the existence of this feature."
	- Richard Stallman
