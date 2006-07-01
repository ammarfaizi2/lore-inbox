Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbWGAUIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbWGAUIn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 16:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751924AbWGAUIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 16:08:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24041 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932100AbWGAUIm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 16:08:42 -0400
Date: Sat, 1 Jul 2006 13:08:17 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Theodore Tso <tytso@mit.edu>
cc: Jeff Bailey <jbailey@ubuntu.com>, "H. Peter Anvin" <hpa@zytor.com>,
       Michael Tokarev <mjt@tls.msk.ru>, Roman Zippel <zippel@linux-m68k.org>,
       klibc@zytor.com, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [klibc] klibc and what's the next step?
In-Reply-To: <20060701150506.GA10517@thunk.org>
Message-ID: <Pine.LNX.4.64.0607011306060.12404@g5.osdl.org>
References: <klibc.200606251757.00@tazenda.hos.anvin.org>
 <Pine.LNX.4.64.0606271316220.17704@scrub.home> <20060630181131.GA1709@elf.ucw.cz>
 <44A5AE17.4080106@tls.msk.ru> <44A5B07E.9040007@zytor.com>
 <1151751417.2553.8.camel@localhost.localdomain> <20060701150506.GA10517@thunk.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 1 Jul 2006, Theodore Tso wrote:
> 
> This is going to be a problem given that people are hell-bent at
> chucking functionality out of the kernel into userspace.

Btw, I'm not necessarily one of those people.

There _are_ some things that can be better done in user space, but on the 
other hand, other things really are better off in the kernel.

The argument that user space is more debuggable has been shown to be 
largely a red herring. User space is only more debuggable if it does 
something independent, and we've seen that user space is _harder_ to debug 
than kernel space if we have events going back and forth.

For example, the old pcmcia layer in user space was crap, crap, crap, and 
at least I fount it was MUCH harder to debug than the all-in-kernel code.

			Linus
