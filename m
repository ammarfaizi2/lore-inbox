Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273626AbRIQObI>; Mon, 17 Sep 2001 10:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273627AbRIQOas>; Mon, 17 Sep 2001 10:30:48 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:35983
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S273626AbRIQOaj>; Mon, 17 Sep 2001 10:30:39 -0400
Date: Mon, 17 Sep 2001 07:30:54 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>, Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bzImage target for PPC
Message-ID: <20010917073054.G14279@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <20010916212538.F14279@cpe-24-221-152-185.az.sprintbbd.net> <E15ivIz-00087v-00@wagner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15ivIz-00087v-00@wagner>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2001 at 08:07:09PM +1000, Rusty Russell wrote:
> In message <20010916212538.F14279@cpe-24-221-152-185.az.sprintbbd.net> you writ
> e:
> > On Mon, Sep 17, 2001 at 02:11:34PM +1000, Rusty Russell wrote:
> > 
> > > All the instructions (including the message after "make oldconfig")
> > > talk about "make bzImage".  So I suppose it's best to give in to this
> > > rampant Intelism 8)
> > 
> > What about 'bzlilo' and 'zlilo' ? Those are mentioned too.  Linus, please
> > don't apply this.  Hopefully Paul will say that too. :)
> 
> Actually, Paul suggested it.  As for bzlilo, that's even a problem on
> non-lilo Intel (and should be subsumed by make install).  Of course,
> make install should be moved to the top level Makefile, but that's
> another battle.

Bah.  I thought when that text got changed around a bit ages ago (didn't it
used to say something just 'zImage') there was a bit of a thread/flame and
it was just left as an intel-ism, and hopefully users would still do the
'right' thing.  Anyhow, the original patch just makes bzImage not fail as
an unknown target, but not actually do anything.  The 'correct' way I
_think_ would be:
arch/ppc/Makefile:
bzImage: $(CHECKS) vmlinux
	@$(MAKEBOOT) zImage

Or print out a msg saying to use 'zImage'. :)

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
