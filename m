Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315614AbSETBPp>; Sun, 19 May 2002 21:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315617AbSETBPo>; Sun, 19 May 2002 21:15:44 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:27666 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S315614AbSETBPm>; Sun, 19 May 2002 21:15:42 -0400
Date: Mon, 20 May 2002 03:15:38 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.16
In-Reply-To: <Pine.LNX.4.44.0205191742130.10180-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.21.0205200311420.23394-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 19 May 2002, Linus Torvalds wrote:

> That reminds me - we should increment the rss for page directories now on
> the allocation path, because we will decrement rss for them when we free
> them (and because it's the right thing to do anyway, I guess - better
> resource tracking).
> 
> The other alternative is to make separate versions of "tlb_remove_page()":
> one that decrements RSS, one that doesn't (and the latter would be used
> for page directories).
> 
> Finally, I haven't really heard anything back from the "strange" VM
> architectures (ie sparc v8 and PPC) other than Davem's buy-in that the
> basic approach should work ok for them.

There is another problem even on rather "normal" systems, a pgd/pmd
directory doesn't have to be of PAGE_SIZE size, e.g. on m68k it's 512
bytes.

bye, Roman

