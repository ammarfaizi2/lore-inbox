Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286336AbSA1Vnp>; Mon, 28 Jan 2002 16:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285073AbSA1Vnh>; Mon, 28 Jan 2002 16:43:37 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:54277 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S286336AbSA1VnR>;
	Mon, 28 Jan 2002 16:43:17 -0500
Date: Mon, 28 Jan 2002 19:43:01 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Rick Stevens <rstevens@vitalstream.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Note describing poor dcache utilization under high memory pressure
In-Reply-To: <3C55C39A.8040203@vitalstream.com>
Message-ID: <Pine.LNX.4.33L.0201281940580.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2002, Rick Stevens wrote:
> Daniel Phillips wrote:
> [snip]
  [page table COW description]

> Perhaps I'm missing this, but I read that as the child gets a reference
> to the parent's memory.  If the child attempts a write, then new memory
> is allocated, data copied and the write occurs to this new memory.  As
> I read this, it's only invoked on a child write.
>
> Would this not leave a hole where the parent could write and, since the
> child shares that memory, the new data would be read by the child?  Sort
> of a hidden shm segment?  If so, I think we've got problems brewing.
> Now, if a parent write causes the same behaviour as a child write, then
> my point is moot.

Daniel and I discussed this issue when Daniel first came up with
the idea of doing page table COW.  He seemed a bit confused by
fork semantics when we first discussed this idea, too ;)

You're right though, both parent and child need to react in the
same way, preferably _without_ having to walk all of the parent's
page tables and mark them read-only ...

kind regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

