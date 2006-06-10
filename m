Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161056AbWFJXiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161056AbWFJXiJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 19:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161057AbWFJXiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 19:38:09 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:44987 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1161056AbWFJXiI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 19:38:08 -0400
Date: Sun, 11 Jun 2006 01:37:48 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Sam Ravnborg <sam@ravnborg.org>
cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: klibc - another libc?
In-Reply-To: <20060610061327.GD8120@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.64.0606102321060.32445@scrub.home>
References: <44869397.4000907@tls.msk.ru> <Pine.LNX.4.64.0606080036250.17704@scrub.home>
 <e69fu3$5ch$1@terminus.zytor.com> <Pine.LNX.4.64.0606091409220.17704@scrub.home>
 <e6cgjv$b8t$1@terminus.zytor.com> <Pine.LNX.4.64.0606100257550.17704@scrub.home>
 <20060610061327.GD8120@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 10 Jun 2006, Sam Ravnborg wrote:

> > Well for now you pretty much just moved code, that was in the kernel 
> > before. What I'm trying to find out is what is coming next. How does e.g. 
> > udev or modules fit into the picture?
> udev and module-init-tools fits nicely with the kernel. I never have
> understood this 'keep-everyhig-separate' mantra. Just see how many
> people had troubles with missing module-init-tools or people having
> troubles with non-backward compatible udev.

It just means that we suck at producing stable kernel interfaces.
Moving everything into the kernel doesn't magically solve problem, it only 
shifts the problem.
You still had to define the boundaries - how does it interface with the 
rest of the system. This is the part I'm currently trying to figure out 
regarding klibc.

> > For -mm that's fine, but do you seriously expect it to get merged like 
> > that. Again, what makes klibc so special, that it doesn't have to follow 
> > standard rules?
> So part of what you ask for is a set of incremental patches that shows
> all the kernal modifications?

Well, it's common practice. If we start making exceptions, everyone wants 
one, so it IMO would need a very, very good reason to merge this as is.

bye, Roman
