Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316889AbSEVIJl>; Wed, 22 May 2002 04:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316890AbSEVIJk>; Wed, 22 May 2002 04:09:40 -0400
Received: from warden3-p.diginsite.com ([208.147.64.186]:31907 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id <S316889AbSEVIJk>; Wed, 22 May 2002 04:09:40 -0400
Date: Wed, 22 May 2002 01:06:08 -0700 (PDT)
From: David Lang <dlang@diginsite.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: "David S. Miller" <davem@redhat.com>, <zippel@linux-m68k.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.17
In-Reply-To: <Pine.LNX.4.44.0205212013020.5712-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0205220105030.2640-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

what about SMP where you may have multiple children hit this at the same
time on different CPUs?

David Lang

On Tue, 21 May 2002, Linus Torvalds wrote:
>  - if there is no process on th erun-queue, take our parent
>
> The "parent" fallback is nice because (a) we're guaranteed to have a
> parent and it is easily found and (b) we're going to wake our parent up
> soon enough in "notify_parent()", so if the current runqueue is empty, the
> parent is one of the likelier processes to end up there..
>
> But no, I've not looked into the details. We've never stolen a mm from
> anybody else before (lazy TLB _gives_ a mm to the next process, it doesn't
> take it from anybody), so it might have nasty locking issues or something.
>
> 			Linus
