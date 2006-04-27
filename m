Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932394AbWD0C7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbWD0C7P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 22:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbWD0C7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 22:59:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53983 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932394AbWD0C7P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 22:59:15 -0400
Date: Wed, 26 Apr 2006 19:59:10 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Simple header cleanups
In-Reply-To: <1146105458.2885.37.camel@hades.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.64.0604261954480.3701@g5.osdl.org>
References: <1146104023.2885.15.camel@hades.cambridge.redhat.com> 
 <Pine.LNX.4.64.0604261917270.3701@g5.osdl.org> <1146105458.2885.37.camel@hades.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 27 Apr 2006, David Woodhouse wrote:
> 
> Well, yes, but we all know that people _have_ to include kernel headers.
> We can't just bury our head in the sand and say "they mustn't do that".
> The kernel headers contain all the juicy stuff like structure
> definitions and ioctls which you _need_ in order to communicate with the
> kernel.

.. and that's generally the job of library maintainers.

I disagree violently with the notion that any normal system should _ever_ 
have the regular headers have anything to do with "what kernel source is 
installed right now". It is untenable to expect kernel developers to have 
to worry about user-level header problems.

> The problem is that we don't actually have any _discipline_ about how we
> throw our kernel headers over the wall. We never even _think_ about how
> usable they are in userspace, or how what we're doing will affect
> userspace.

AND WE SHOULD NOT HAVE TO!

Linkages are bad. We _will_ break kernel headers for user space, and 
that's just a undeniable fact.

If this is work to try to make kernel headers generally palatable to user 
space, I'm not going to apply it at all. Not now, not early in the 2.6.18 
sequence, not EVER. Because that's not a goal I believe in for a moment.

In contrast, if this is work to make it eventually _easier_ for _library_ 
people to decide to upgrade their kernel-related information, I'm ok with 
it. But that "target audience" part really is very very important. The 
target audience should NOT be applications including kernel headers.

The target audience should be distributions and library maintainers.

			Linus
