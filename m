Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263589AbTEJCkN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 22:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263632AbTEJCkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 22:40:13 -0400
Received: from pop.gmx.net ([213.165.64.20]:46288 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263589AbTEJCkM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 22:40:12 -0400
Message-ID: <3EBC6943.B4261A64@gmx.de>
Date: Sat, 10 May 2003 04:51:47 +0200
From: Edgar Toernig <froese@gmx.de>
MIME-Version: 1.0
To: Ulrich Drepper <drepper@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: hammer: MAP_32BIT
References: <3EBB5A44.7070704@redhat.com> <20030509092026.GA11012@averell> <16059.37067.925423.998433@gargle.gargle.HOWL> <20030509113845.GA4586@averell> <b9gr03$42n$1@cesium.transmeta.com> <3EBC0084.4090809@redhat.com> <3EBC15B5.4070604@zytor.com> <3EBC2164.6050605@redhat.com> <3EBC29A5.1050005@techsource.com> <3EBC2A3C.8040409@redhat.com> <3EBC3167.2030302@techsource.com> <3EBC38C1.6020305@redhat.com> <3EBC4119.B5C8F11A@gmx.de> <3EBC4E9A.3090204@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Anyway, what's so bad about the idea someone (Linus?) suggested?
[it was Andi]
> > Without MAP_FIXED the address given to mmap is already taken as a
> > hint where to start looking for free memory.
> 
> The kernel fortunately already defines some semantics to using a
> non-NULL first parameter without MAP_FIXED.  It means: I prefer
> *exactly* this address.

Yeah, ok.

>  If it's not available, give me anything else.

And at least on older kernels (don't know about 2.5) it gives you
not "anything" but the next free memory region above that address.

POSIX-draft6 about that topic:

    "A non-zero value of addr is taken to be a suggestion of a
     process address near which the mapping should be placed."


> Now you want to give this another semantics.  It would need at least one
> more MAP_* flag.

No new flag.  No new semantic.  Everything's already there...

Ciao, ET.
