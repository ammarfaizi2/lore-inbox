Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750968AbWDVTPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbWDVTPq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 15:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750966AbWDVTPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 15:15:46 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:29113 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750968AbWDVTPp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 15:15:45 -0400
Date: Sat, 22 Apr 2006 16:14:10 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 'make headers_install' kbuild target.
Message-ID: <20060422141410.GA25926@mars.ravnborg.org>
References: <1145672241.16166.156.camel@shinybook.infradead.org> <20060422093328.GM19754@stusta.de> <1145707384.16166.181.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145707384.16166.181.camel@shinybook.infradead.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 22, 2006 at 01:03:03PM +0100, David Woodhouse wrote:
> On Sat, 2006-04-22 at 11:33 +0200, Adrian Bunk wrote:
> > My thirst thought is:
> > Is this really the best approach, or could this be done better?
> 
> I think it's the best way to start, although I agree with you entirely
> about what we should strive for in the end.
> 
> > I'm currently more a fan of a separate kabi/ subdir with headers used by 
> > both headers under linux/ and userspace.
> 
> I agree -- I'd like to see that too. But Linus doesn't like that
> approach very much.
Thats bacause the kabi subdir is broken by design.
Any approach that does not take into account the existing userbase is
broken by design and should be avoided.
The only sensible solution is to move out the kernel internal headers
from include/* to somewhere else.
And then slowly but steady let include/linux and include/asm-* be the
KABI.

In this way we avoid breaking a lot of current users. And new users will
continue to just work.

	Sam
