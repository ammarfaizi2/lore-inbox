Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261770AbSI1PIK>; Sat, 28 Sep 2002 11:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261782AbSI1PIK>; Sat, 28 Sep 2002 11:08:10 -0400
Received: from waste.org ([209.173.204.2]:23718 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S261770AbSI1PIJ>;
	Sat, 28 Sep 2002 11:08:09 -0400
Date: Sat, 28 Sep 2002 10:13:08 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Daniel Jacobowitz <dan@debian.org>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel@vger.kernel.org
Subject: Re: Does kernel use system stdarg.h?
Message-ID: <20020928151308.GP21969@waste.org>
References: <20020927140543.GA5613@nevyn.them.org> <20020927214721.GK21969@waste.org> <20020928091530.B32639@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020928091530.B32639@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 28, 2002 at 09:15:30AM +0100, Russell King wrote:
> On Fri, Sep 27, 2002 at 04:47:22PM -0500, Oliver Xymoron wrote:
> > > > -I/usr/src/linux-2.5.36/include
> > > > -iprefix /usr/sbin/../../lib/gcc-lib/i686-pc-linux-gnu/3.0.3/
> > > 
> > > That's the problem.  Where's the -iprefix coming from?   Your configure
> > > doesn't specify /usr/sbin anywhere.
> > > 
> > > Verdict: bad GCC install or a 3.0.3 bug.  Might have to do with your
> > > libdir-outside-of-prefix.
> > 
> > I've got the same problem with -nostdinc with my Debian gcc-3.0 that
> > I've been patching around. I assumed it was a problem with the
> > kernel's Makefile, now you're saying it's the Debian package?
> 
> It certainly looks like it.  gcc 3.0.3 appears to ignore
> "-iwithprefix include", where as gcc 2.95.x, 2.96, 3.1 and 3.2 all
> work as expected.
> 
> -iwithprefix is supposed to add /usr/lib/gcc-lib/<target>/<version>/include
> to the compilers include path.
> 
> For curiositys sake, what does:
> 
>   gcc -print-file-name=include
> 
> give you?  That should (in theory) be the same path as -iwithprefix include
> but iirc this method apparantly breaks with internationalisation
> (discovered in 2.4.)  I'm going to place my bets on:
> 
>   /usr/sbin/../../lib/gcc-lib/i686-pc-linux-gnu/3.0.3/include

/usr/lib/gcc-lib/i386-linux/3.0.4/include

Amusingly, I just noticed I already have 3.2.1 on my system as well,
which seems to work just fine.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
