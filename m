Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136170AbRECHqj>; Thu, 3 May 2001 03:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136173AbRECHqb>; Thu, 3 May 2001 03:46:31 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:45062 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S136170AbRECHqL>;
	Thu, 3 May 2001 03:46:11 -0400
Date: Thu, 3 May 2001 03:46:20 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Urban Widmark <urban@teststation.com>
Cc: John Stoffel <stoffel@casc.com>, cate@dplanet.ch,
        Peter Samuelson <peter@cadcamlab.org>,
        CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Hierarchy doesn't solve the problem
Message-ID: <20010503034620.A27880@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Urban Widmark <urban@teststation.com>,
	John Stoffel <stoffel@casc.com>, cate@dplanet.ch,
	Peter Samuelson <peter@cadcamlab.org>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010503030431.A25141@thyrsus.com> <Pine.LNX.4.30.0105030907470.28400-100000@cola.teststation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0105030907470.28400-100000@cola.teststation.com>; from urban@teststation.com on Thu, May 03, 2001 at 09:34:20AM +0200
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Urban Widmark <urban@teststation.com>:
> Then it must somehow handle me trying to (incorrectly) answer X86=Y,
> SMP=Y, RTC=N in some order?

What it does is (a) always start with a valid config, and (b) not permit
any change that would make it invalid.

So, you froze X86 at startup.  SMP gets asked early.  If you specify 
SMP=y, and then later try to set RTC=n, the configurator will not let
you do it and will explain why.  At that point if you want you can go
back and change SMP.
 
> Perhaps I have missed something, but I really prefer the old oldconfig
> over the new oldconfig.

What's to prefer?  You get essentially the same behavior unless you start
with a broken config.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

This would be the best of all possible worlds, if there were
no religion in it.
	-- John Adams, in a letter to Thomas Jefferson.
