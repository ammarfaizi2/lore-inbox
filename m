Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131842AbQLVHjY>; Fri, 22 Dec 2000 02:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131851AbQLVHjE>; Fri, 22 Dec 2000 02:39:04 -0500
Received: from monza.monza.org ([209.102.105.34]:8202 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S131842AbQLVHi5>;
	Fri, 22 Dec 2000 02:38:57 -0500
Date: Thu, 21 Dec 2000 23:08:19 -0800
From: Tim Wright <timw@splhi.com>
To: "Matthew D. Pitts" <mpitts@suite224.net>
Cc: "Robert B. Easter" <reaster@comptechnews.com>,
        linux-kernel@vger.kernel.org
Subject: Re: recommended gcc compiler version
Message-ID: <20001221230819.A1678@scutter.internal.splhi.com>
Reply-To: timw@splhi.com
Mail-Followup-To: "Matthew D. Pitts" <mpitts@suite224.net>,
	"Robert B. Easter" <reaster@comptechnews.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <0012212320430F.02217@comptechnews> <001901c06bdf$1d6c74e0$3b42b0d1@pittscomp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <001901c06bdf$1d6c74e0$3b42b0d1@pittscomp.com>; from mpitts@suite224.net on Fri, Dec 22, 2000 at 01:19:07AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sorry but this is incorrect.
The recommended compiler version is not longer the same for the 2.2 and 2.4
kernels.
>From Documentation/Changes in 2.4 (test12):
"The recommended compiler for the kernel is egcs 1.1.2 (gcc 2.91.66), and it
should be used when you need absolute stability. You may use gcc 2.95.2
instead if you wish, although it may cause problems. Later versions of gcc
have not received much testing for Linux kernel compilation, and there are
almost certainly bugs (mainly, but not exclusively, in the kernel) that
will need to be fixed in order to use these compilers. In any case, using
pgcc instead of egcs or plain gcc is just asking for trouble.
 
Note that gcc 2.7.2.3 is no longer a supported kernel compiler. The kernel
no longer works around bugs in gcc 2.7.2.3 and, in fact, will refuse to
be compiled with it."

For 2.2.18:
"   Note that the latest compilers (pgcc, gcc 2.95) may do Bad
Things while compiling your kernel, particularly if absurd
optimizations (like -O9) are used.  Caveat emptor. In general, however,
gcc-2.7.2.3 and egcs 1.1.2 are known to be stable on x86, while gcc 2.95 and
others have not been as thoroughly tested yet."

So....
egcs-1.1.2 is good for either, 2.7.2 is OK for 2.2, bad for 2.4. 2.95.2 and
later are risky. RedHat just released a bugfixed "2.96" which is an unknown
quantity AFAIK. Anybody brave enough to try it should probably post their
results.

No compiler is bug-free. In general, you will get the most reliable results
when you use what most everybody else is using, 'cos that's how the bugs get
fixed. YMMV :-)

Regards,

Tim

On Fri, Dec 22, 2000 at 01:19:07AM -0500, Matthew D. Pitts wrote:
>     Robert,
> gcc 2.7.2.3 is the safest, but egcs 1.1.2 will work. any kernels built with
> gcc 2.95.x work but can be buggy.
> 
> Matthew Pitts
> mpitts@suite224.net
> 
> ----- Original Message -----
> From: Robert B. Easter <reaster@comptechnews.com>
> To: <linux-kernel@vger.kernel.org>
> Sent: Thursday, December 21, 2000 11:20 PM
> Subject: recommended gcc compiler version
> 
> 
> > This is a newbie question, but what are the recommended gcc compiler
> versions
> > for compiling,
> >
> > Linux 2.2.18?
> >
> > Linux 2.4.0?
> >
> >
> > I'd rather use the recommended version than not and have difficult bugs.
> >
> > Thanks.  If there is a FAQ, kindy direct me to it, or, if this info isn't
> in
> > there specificly, perhaps a FAQ maintainer can add this stuff.
> >
> > --
> > -------- Robert B. Easter  reaster@comptechnews.com ---------
> > - CompTechNews Message Board   http://www.comptechnews.com/ -
> > - CompTechServ Tech Services   http://www.comptechserv.com/ -
> > ---------- http://www.comptechnews.com/~reaster/ ------------
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > Please read the FAQ at http://www.tux.org/lkml/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-- 
Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
IBM Linux Technology Center, Beaverton, Oregon
"Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
