Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312331AbSDSOgC>; Fri, 19 Apr 2002 10:36:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312497AbSDSOgB>; Fri, 19 Apr 2002 10:36:01 -0400
Received: from ns.suse.de ([213.95.15.193]:19469 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S312331AbSDSOgA>;
	Fri, 19 Apr 2002 10:36:00 -0400
Date: Fri, 19 Apr 2002 16:35:59 +0200
From: Dave Jones <davej@suse.de>
To: Anton Altaparmakov <aia21@cantab.net>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.9 patch] Fix bluesmoke/mce compiler warnings.
Message-ID: <20020419163558.G15517@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Anton Altaparmakov <aia21@cantab.net>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <E16yVSw-0001Iv-00@storm.christs.cam.ac.uk> <E16yVSw-0001Iv-00@storm.christs.cam.ac.uk> <20020419150048.E15517@suse.de> <5.1.0.14.2.20020419150509.00a8c580@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2002 at 03:16:32PM +0100, Anton Altaparmakov wrote:

 > If gcc optimizes the "cpu" into a register then fine but if not, it would 
 > be IMHO preferable to use this instead:
 > 
 >          BUG_ON(*(unsigned int *)info != smp_processor_id());

I favoured simplicity over optimisation here, as it's not a speed critical path.

 > >(This contains some other bits too that I intend to push to Linus after
 > >  a pre1 appears)
 > Why not push now considering 2.5.9 isn't out yet?

I've not pulled Linus' bk tree, but have noticed from the changelogs
that some changes went in already touching this file.

 > Considering the current bitkeeper tree on bkbits does not compile on ia32 
 > UP at all by any close margin, the more fixes that go in now the better...

Erk.

 > Releasing 2.5.9 in current state would not be too useful for people like me 
 > who experience the ide problems...

Agreed. I assumed the Linus just didn't add the "pre1" part to EXTRAVERSION
yet but, given that 2.5.8 doesn't compile for a lot of people, I can see
why pushing 2.5.9 out sooner would be a good thing.

I've been busy with x86-64 bits and other projects the last few days, I'll
continue pushing more bits from my tree (including the bluesmoke bits) to
Linus over the weekend.

    Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
