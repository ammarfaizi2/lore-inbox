Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315424AbSEUSha>; Tue, 21 May 2002 14:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315419AbSEUSh3>; Tue, 21 May 2002 14:37:29 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:260 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S315424AbSEUSgs>; Tue, 21 May 2002 14:36:48 -0400
Message-ID: <3CEA93B5.B2E62FC7@linux-m68k.org>
Date: Tue, 21 May 2002 20:36:37 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.17
In-Reply-To: <Pine.LNX.4.44.0205210904440.2249-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Linus Torvalds wrote:

> I don't think there is any validity any more in the "opaque type" comment,
> and I'd rather expose the fact that it _has_ to have the rss computations
> inside of it than have more made-up interfaces to hide it.
> 
> The fact is, the rss cannot be computed anywhere else any more, so why
> play games about it?

Basically I could agree with it, but something looks wrong. Why exactly
is pte_free_tlb() needed in first place? Why does it call
tlb_remove_page()? A page mapped into user space has little to do with a
page used as page table. Latter is never in the user tlb, so it doesn't
need to be removed from it, so calling tlb_remove_page() is just a more
complicated way of calling __free_page() or am I missing something?

bye, Roman
