Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267361AbTA1QbC>; Tue, 28 Jan 2003 11:31:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267377AbTA1QbB>; Tue, 28 Jan 2003 11:31:01 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:40152 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S267361AbTA1QbB>; Tue, 28 Jan 2003 11:31:01 -0500
Date: Tue, 28 Jan 2003 10:40:09 -0600 (CST)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Sam Ravnborg <sam@ravnborg.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] new modversions implementation 
In-Reply-To: <20030128091625.2B5322C08A@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0301281036180.1777-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jan 2003, Rusty Russell wrote:

> In message <Pine.LNX.4.44.0301252025350.6749-100000@chaos.physics.uiowa.edu> yo
> u write:
> > On Sat, 25 Jan 2003, Sam Ravnborg wrote:
> > 
> > > A genksyms replacement should do all the three steps above?
> > 
> > Yes, I think at some point I should take a look at patching genksyms so 
> > that the post-processing above is not necessary anymore. However, it 
> > doesn't hurt much, performance-wise.
> 
> Of course, genksyms belongs in the kernel sources, too, since it's
> intimately tied to them.

Yeah, I guess I'll move it there some time. It'd also be possible to make 
genksyms just a filter which takes the preprocessed input as a filter, 
generates the module symbol checksums and outputs the preprocessed code 
with the right versions added.

OTOH, that'd mean that my trick of using the linker to add the checksums
would become obsolete again, though it's sooo cute ;)

--Kai


