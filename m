Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264088AbRFKLiM>; Mon, 11 Jun 2001 07:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264089AbRFKLiC>; Mon, 11 Jun 2001 07:38:02 -0400
Received: from HSE-MTL-ppp72834.qc.sympatico.ca ([64.229.202.135]:8076 "HELO
	oscar.casa.dyndns.org") by vger.kernel.org with SMTP
	id <S264088AbRFKLht>; Mon, 11 Jun 2001 07:37:49 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Jonathan Morton <chromi@cyberspace.org>, Ed Tomlinson <tomlins@cam.org>,
        linux-kernel@vger.kernel.org
Subject: Re: what is using memory?
Date: Mon, 11 Jun 2001 07:37:46 -0400
X-Mailer: KMail [version 1.2]
Cc: linux-mm@kvack.org
In-Reply-To: <l03130300b74a2f8d4db6@[192.168.239.105]>
In-Reply-To: <l03130300b74a2f8d4db6@[192.168.239.105]>
MIME-Version: 1.0
Message-Id: <01061107374601.06951@oscar>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 June 2001 04:20, Jonathan Morton wrote:
> >My box has
> >
> >320280K
> >
> >from proc/meminfo
> >
> > 17140	buffer
> >123696	cache
> > 32303	free
> >
> >leaving unaccounted
> >
> >123627K
>
> This is your processes' memory, the inode and dentry caches, and possibly
> some extra kernel memory which may be allocated after boot time.  It is
> *very* much accounted for.

No its not.  For instance the slab caches encompass the inode and dentry
caches.  Point I was/am tring to make is not that this memory is lost or
not need, but that is it _not_ accounted.  ie. There is not way to tell
what is using it, hense we cannot see leaks or places that could be 
optimized.

I have attempted to count all memory I could.  The 123M is what is left in
the kernel overhead bucket...

Ed Tomlinson
