Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290300AbSAPAk5>; Tue, 15 Jan 2002 19:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290306AbSAPAkv>; Tue, 15 Jan 2002 19:40:51 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:1038 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S290305AbSAPAkg>; Tue, 15 Jan 2002 19:40:36 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 15 Jan 2002 16:46:36 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Benjamin LaHaise <bcrl@redhat.com>, John Weber <weber@nyc.rr.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: 2.5.3-pre1 compile error
In-Reply-To: <Pine.LNX.4.33.0201151628440.1140-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.40.0201151644530.960-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2002, Linus Torvalds wrote:

>
> On Tue, 15 Jan 2002, Benjamin LaHaise wrote:
> >
> > Hmm, this should fix that.
>
> probably will, BUT..
>
> > +#ifndef __ASM__ATOMIC_H
> > +#include <asm/atomic.h>
> > +#endif
>
> Please do not assume knowdledge of what the different header files use to
> define their re-entrancy.
>
> Just do
>
> 	#include <asm/atomic.h>
>
> and be done with it.

I needed two fixes :

#include <asm/atomic.h> in include/linux/file.h

#include <linux/fs.h> in include/linux/dnotify.h

after that it builds for me ... but it crashes at boot time




- Davide


