Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312128AbSCQW5b>; Sun, 17 Mar 2002 17:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312130AbSCQW5V>; Sun, 17 Mar 2002 17:57:21 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:65167 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S312128AbSCQW5J>; Sun, 17 Mar 2002 17:57:09 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sun, 17 Mar 2002 15:01:38 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
In-Reply-To: <a72mif$941$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0203171453050.7378-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Mar 2002, Linus Torvalds wrote:

> In article <Pine.LNX.4.44L.0203171021090.2181-100000@imladris.surriel.com>,
> Rik van Riel  <riel@conectiva.com.br> wrote:
> >
> >In other words, large pages should be a "special hack" for
> >special applications, like Oracle and maybe some scientific
> >calculations ?
>
> Yes, I think so.
>
> That said, a 64kB page would be useful for generic use.
>
> >Grabbing some bitflags in generic datastructures shouldn't
> >be an issue since free bits are available.
>
> I had large-page-support working in the VM a long time ago, back when I
> did the original VM portability rewrite.  I actually exposed the kernel
> large pages to the VM, and it worked fine - I didn't even need a new
> bit, since the code just used the "large page" bit in the page table
> directly.
>
> But it wasn't ever exposed to user space, and in the end I just made the
> kenel mapping just not visible to the VM and simplified the x86
> pmd_xxx() macros.  The approach definitely worked, though.

Couldn't we choose the page size depending on the map size ?
If we start mixing page sizes, what about kernel code that assumes PAGE_SIZE ?



- Davide


