Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131644AbRDSR73>; Thu, 19 Apr 2001 13:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131665AbRDSR7U>; Thu, 19 Apr 2001 13:59:20 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:44810 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S131644AbRDSR7F>;
	Thu, 19 Apr 2001 13:59:05 -0400
Date: Thu, 19 Apr 2001 13:59:55 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: Re: Dead symbol elimination, stage 1
Message-ID: <20010419135955.A3841@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Russell King <rmk@arm.linux.org.uk>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010419131944.A3049@thyrsus.com> <20010419184444.A3111@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010419184444.A3111@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Thu, Apr 19, 2001 at 06:44:44PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk@arm.linux.org.uk>:
> On Thu, Apr 19, 2001 at 01:19:44PM -0400, Eric S. Raymond wrote:
> > The following patch cleans dead symbols out of the defconfigs in the 2.4.4pre4
> > source tree.  It corrects a typo involving CONFIG_GEN_RTC.  Another typo
> > involving CONFIG_SOUND_YMPCI doesn't need to be corrected, as the symbol
> > is never set in these files.
> 
> As I said previously, please don't eliminate the ones on arch/arm -
> you'll prevent me from sending a patch to Alan without a _lot_ more
> work.

Um...this is what you said:

> The ones that show up in arch/arm/def-configs are purely because I've been
> keeping back the updates to these files; each time the config structure
> changes, I get a nice big patch from people with the new def-configs.  I
> didn't want to inflict this too regularly on people.

I read this as "I haven't fixed the problem because..."  not as "Don't
fix the problem."  Please be more explicit next time so I won't step on
your toes?

I don't care whether it's you or me that cleans up this part of the
dead-symbol mess.  I'm just trying to get it cleaned up.  

I'm rather disturbed by the amount of crap kxref is turning up -- I
expected dozens of dodgy bits, but I'm finding hundreds.  We need to pay
better attention to janitorial issues like this if the kernel code
isn't going to degenerate into an unmaintainable hairball.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

False is the idea of utility that sacrifices a thousand real advantages for
one imaginary or trifling inconvenience; that would take fire from men because
it burns, and water because one may drown in it; that has no remedy for evils
except destruction.  The laws that forbid the carrying of arms are laws of
such a nature.  They disarm only those who are neither inclined nor determined
to commit crimes.
        -- Cesare Beccaria, as quoted by Thomas Jefferson's Commonplace book
