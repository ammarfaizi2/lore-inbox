Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262732AbVD2Ofb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262732AbVD2Ofb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 10:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262742AbVD2Odd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 10:33:33 -0400
Received: from fire.osdl.org ([65.172.181.4]:54408 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262732AbVD2Oca (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 10:32:30 -0400
Date: Fri, 29 Apr 2005 07:34:15 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Matt Mackall <mpm@selenic.com>
cc: Sean <seanlkml@sympatico.ca>, linux-kernel <linux-kernel@vger.kernel.org>,
       git@vger.kernel.org
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
In-Reply-To: <20050429074043.GT21897@waste.org>
Message-ID: <Pine.LNX.4.58.0504290728090.18901@ppc970.osdl.org>
References: <20050426004111.GI21897@waste.org> <Pine.LNX.4.58.0504251859550.18901@ppc970.osdl.org>
 <20050429060157.GS21897@waste.org> <3817.10.10.10.24.1114756831.squirrel@linux1>
 <20050429074043.GT21897@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Apr 2005, Matt Mackall wrote:
> 
> Mercurial is even younger (Linus had a few days' head start, not to
> mention a bunch of help), and it is already as fast as git, relatively
> easy to use, much simpler, and much more space and bandwidth
> efficient.

You've not mentioned two out of my three design goals:
 - distribution
 - reliability/trustability

ie does mercurial do distributed merges, which git was designed for, and 
does mercurial notice single-bit errors in a reasonably secure manner, or 
can people just mess with history willy-nilly?

For the latter, the cryptographic nature of sha1 is an added bonus - the
_big_ issue is that it is a good hash, and an _exteremely_ effective CRC
of the data. You can't mess up an archive and lie about it later. And if
you have random memory or filesystem corruption, it's not a "shit happens"  
kind of situation - it's a "uhhoh, we can catch it (and hopefully even fix
it, thanks to distribution)" thing.

I had three design goals. "disk space" wasn't one of them, so you've
concentrated on only one so far in your arguments.

		Linus
