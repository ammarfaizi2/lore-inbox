Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbWCEX2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWCEX2o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 18:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751901AbWCEX2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 18:28:44 -0500
Received: from kanga.kvack.org ([66.96.29.28]:13220 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1750773AbWCEX2o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 18:28:44 -0500
Date: Sun, 5 Mar 2006 18:23:26 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Greg KH <gregkh@suse.de>, Nicholas Miell <nmiell@comcast.net>,
       Greg KH <greg@kroah.com>, "Theodore Ts'o" <tytso@mit.edu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, davej@redhat.com, perex@suse.cz,
       Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [RFC] Add kernel<->userspace ABI stability documentation
Message-ID: <20060305232326.GC20768@kvack.org>
References: <20060227190150.GA9121@kroah.com> <20060227193654.GA12788@kvack.org> <20060227194623.GC9991@suse.de> <Pine.LNX.4.64.0602271216340.22647@g5.osdl.org> <20060227234525.GA21694@suse.de> <20060228063207.GA12502@thunk.org> <20060301003452.GG23716@kroah.com> <1141175870.2989.17.camel@entropy> <20060302042455.GB10464@suse.de> <m1fylwc1c8.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1fylwc1c8.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 05, 2006 at 09:17:59AM -0700, Eric W. Biederman wrote:
> So if we go down this path can we make this functional Documentation?
> 
> In particular can we have per process/per interface kinds of flags that
> allow access to experimental subsystems?

Sounds fragile.  It doesn't help the real problem that APIs need to be well 
designed.

> If the developer has to jump through an extra hoop to use an interface
> we have clearly documented this is unsupported and will change in the
> future.  Anything else can be easy to miss.

At this point if it ends up anywhere near the tools people need to use on 
a regular basis, it will not have accomplished anything.  APIs should be 
reasonably stable, often extensible, by the time they hit the kernel.  The 
problem with any sort of 'experimental' API is that it probably means the 
code is not ready to be in the kernel.  Wrapping it up in flags doesn't 
stop people from using it and tieing code to the interface; not shipping 
code that isn't fully baked does.

		-ben
-- 
"Time is of no importance, Mr. President, only life is important."
Don't Email: <dont@kvack.org>.
