Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314089AbSDZRb0>; Fri, 26 Apr 2002 13:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314094AbSDZRbZ>; Fri, 26 Apr 2002 13:31:25 -0400
Received: from ns.suse.de ([213.95.15.193]:8977 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S314089AbSDZRbX>;
	Fri, 26 Apr 2002 13:31:23 -0400
Date: Fri, 26 Apr 2002 19:31:21 +0200
From: Dave Jones <davej@suse.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.10 IDE 42
Message-ID: <20020426193121.Y14343@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Pavel Machek <pavel@ucw.cz>,
	Martin Dalecki <dalecki@evision-ventures.com>,
	Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1019549894.1450.41.camel@turbulence.megapathdsl.net> <3CC7E358.8050905@evision-ventures.com> <20020425172508.GK3542@suse.de> <20020425173439.GM3542@suse.de> <aa9qtb$d8a$1@penguin.transmeta.com> <3CC904AA.7020706@evision-ventures.com> <20020426160911.GE3783@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2002 at 06:09:11PM +0200, Pavel Machek wrote:

> 
 > > @@ -839,7 +834,7 @@
 > >  					printk(", sector=%ld", HWGROUP(drive)->rq->sector);
 > >  			}
 > >  		}
 > > -#endif	/* FANCY_STATUS_DUMPS */
 > > +#endif
 > >  		printk("\n");
 > >  	}
 > >  	__restore_flags (flags);	/* local CPU only */
 > 
 > Here to. Comment after endif is good thing; you don't have to add it
 > but you should certainly not kill it.

In cases where the #if is several pages before, or there multiple nested
#if's, I agree. But when the #if is just a few lines up with no other #if's
around, it's ugly.

We have functions elsewhere in the kernel like this..

void foo (void)
{
#if MY_MEMORY_SUCKS_BUT_LIKE_SILLY_COMMENTS
    one_line_of_code();
#endif /* MY_MEMORY_SUCKS_BUT_I_LIKE_SILLY_COMMENTS */
}

What information is this comment adding ?

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
