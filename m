Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261411AbSKBVKu>; Sat, 2 Nov 2002 16:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261424AbSKBVKu>; Sat, 2 Nov 2002 16:10:50 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:28421 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S261411AbSKBVKn>;
	Sat, 2 Nov 2002 16:10:43 -0500
Date: Sat, 2 Nov 2002 22:16:57 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dcache_rcu [performance results]
Message-ID: <20021102211656.GA3759@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <20021030161912.E2613@in.ibm.com.suse.lists.linux.kernel> <p734rb0s2qb.fsf@oldwotan.suse.de> <20021102162419.A7894@dikhow> <20021102120155.A17591@wotan.suse.de> <aq19pe$2p0$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aq19pe$2p0$1@penguin.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02, 2002 at 07:41:34PM +0000, Linus Torvalds wrote:
> >Kernel compilation actually uses absolute pathnames e.g. for dependency
> >checking.
> 
> This used to be true, but it shouldn't be true any more. TOPDIR should
> be gone, and everything should be relative paths (and all "make"
> invocations should just be done from the top kernel directory).
> 
> But yes, it certainly _used_ to be true (and hey, maybe I've missed some
> reason for why it isn't still true).
If there is any dependency left on absolute paths thats a bug.

I have tested this by doing a full make and copy the tree.
When executing make again nothing got rebuild - so it is OK for the
general case.

But please report it if you see something in contradiction with that.

	Sam
