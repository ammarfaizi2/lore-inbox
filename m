Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbUCWWS0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 17:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262880AbUCWWS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 17:18:26 -0500
Received: from gprs214-90.eurotel.cz ([160.218.214.90]:25729 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262874AbUCWWSW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 17:18:22 -0500
Date: Tue, 23 Mar 2004 23:17:56 +0100
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@users.sourceforge.net>
Cc: Jonathan Sambrook <swsusp@hmmn.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Swsusp mailing list <swsusp-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Swsusp-devel] Re: swsusp problems [was Re: Your opinion on the merge?]
Message-ID: <20040323221756.GF364@elf.ucw.cz>
References: <20040318193703.4c02f7f5.akpm@osdl.org> <1079661410.15557.38.camel@calvin.wpcb.org.au> <20040318200513.287ebcf0.akpm@osdl.org> <1079664318.15559.41.camel@calvin.wpcb.org.au> <20040321220050.GA14433@elf.ucw.cz> <1079988938.2779.18.camel@calvin.wpcb.org.au> <20040322231737.GA9125@elf.ucw.cz> <20040323095318.GB20026@hmmn.org> <20040323214734.GD364@elf.ucw.cz> <1080076132.12965.18.camel@calvin.wpcb.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1080076132.12965.18.camel@calvin.wpcb.org.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> if/when its needed. I'm also of a mind to not include the original
> text-mode 'nice display' and just use the Bootsplash support.

Yes, that would be great. [Bootsplash is in mainline but is in vendor
kernels => great, vendor kernels get splashscreen with progress bar
and vanilla kernel just plain old dots].

> Of course there's also the point that you're assuming I'm going to
> disappear into the wild blue yonder after it's merged. That assumption
> has no basis from my perspective.

Ok, sorry about that one.

> > Oh and it is enough confusing that it confuses me. Some messages end
> > in dmesg, some do not. User feedback can be done with much less code,
> > and also slightly less confusing for the user, see swsusp1. [We have
> > to switch to another console, anyway; and printing dots is easy.]
> 
> As I said above, much of the code was from debugging and can be removed.
> Nevertheless, the interface is not that confusing:

If it slims down a lot, great. If debugging code is gone, and progress
bar depends on bootsplash, we are left with something that looks like
output from swsusp1, right? And there should be little need to
configure it. Good.

> > Okay, we should probably make suspend more quiet, I can see users
> > badly confused by those hdX: spinning down (etc) messages.
> 
> That's fine, but those messages aren't related to my code.

Yes, thats _my_ todo.

> > Also, in your model, where do messages printk()-ed from drivers during
> > suspend/resume end up? Corrupting screen? Lost from sight and only
> > accessible from dmesg? I believe driver messages *are* important, and
> > do not see how they could coexist with eye-candy.
> 
> They do go in the logs. An important exception though (which applies to
> all implementations): messages displayed after the atomic copy is made
> (while suspending) or before the kernel is copied back (resuming) as
> lost because the printk buffer is overwritten,

Yes, but with eye candy its a bit more of a problem because progress
bar updating could obscure them.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
