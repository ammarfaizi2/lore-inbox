Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262308AbTJAPAJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 11:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262276AbTJAO6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 10:58:53 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:30726 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S262275AbTJAO6X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 10:58:23 -0400
Date: Wed, 1 Oct 2003 16:58:11 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Matthew Wilcox <willy@debian.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CONFIG_* In Comments Considered Harmful
Message-ID: <20031001145811.GA941@mars.ravnborg.org>
Mail-Followup-To: Matthew Wilcox <willy@debian.org>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
References: <20031001132619.GL24824@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031001132619.GL24824@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 01, 2003 at 02:26:19PM +0100, Matthew Wilcox wrote:
> 
> I reviewed the dependency list for a file this morning to see why it was
> being unnecessarily recompiled (a little fetish of mine, mostly harmless).
> I was a little discombobulated to find this line:
> 
>     $(wildcard include/config/higmem.h) \

I was a design decision not to parse comments.
Tradeoff between speed and accurateness.
And usually CONFIG_SYMBOLs referred in comments are also used.

The mis-behaviour is not documented in other places than in fixdep
itself - and that's not a place I expect people to look anyway.
If I at some point in time manage to convince myself to write a
how-to-compile-the-kernel I will try to include a section of
known shortcoming. This being one of them.

	Sam

