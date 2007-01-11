Return-Path: <linux-kernel-owner+w=401wt.eu-S965253AbXAKAk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965253AbXAKAk4 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 19:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965261AbXAKAk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 19:40:56 -0500
Received: from cantor2.suse.de ([195.135.220.15]:37486 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965253AbXAKAk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 19:40:56 -0500
From: Andi Kleen <ak@suse.de>
To: Neil Brown <neilb@suse.de>
Subject: Re: PATCH - x86-64 signed-compare bug, was Re: select() setting ERESTARTNOHAND (514).
Date: Thu, 11 Jan 2007 01:40:51 +0100
User-Agent: KMail/1.9.5
Cc: Sean Reifschneider <jafo@tummy.com>, linux-kernel@vger.kernel.org
References: <20070110234238.GB10791@tummy.com> <17829.34481.340913.519675@notabene.brown>
In-Reply-To: <17829.34481.340913.519675@notabene.brown>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701110140.51842.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 January 2007 01:37, Neil Brown wrote:
> On Wednesday January 10, jafo@tummy.com wrote:
> > 
> > In looking at the Linux code for ERESTARTNOHAND, I see that
> > include/linux/errno.h says this errno should never make it to the user.
> > However, in this instance we ARE seeing it.  Looking around on google shows
> > others are seeing it as well, though hits are few.
> ..
> > 
> > Thoughts?
> 
> Just a 'me too' at this point. 
> The X server on my shiny new notebook (Core 2 Duo) occasionally dies
> with 'select' repeatedly returning ERESTARTNOHAND.  It is most
> annoying!

Normally it should be only visible in strace. Did you see it without
strace?

> 
> You don't mention in the Email which kernel version you use but I see
> from the web page you reference it is 2.6.19.1.  I'm using
> 2.6.18.something.
> 
> I thought I'd have a quick look at the code, comparing i386 to x86-64
> and guess what I found.....
> 
> On x86-64, regs->rax is "unsigned long", so the following is
> needed....

regs->rax is unsigned long.
I don't think your patch will make any difference. What do you think
it will change?

-Andi
