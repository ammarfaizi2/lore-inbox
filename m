Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281769AbRKUMOh>; Wed, 21 Nov 2001 07:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281758AbRKUMO2>; Wed, 21 Nov 2001 07:14:28 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:47628 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S281769AbRKUMON>;
	Wed, 21 Nov 2001 07:14:13 -0500
Date: Wed, 21 Nov 2001 10:13:52 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.14 + Bug in swap_out.
In-Reply-To: <m1vgg41x3x.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.33L.0111211013020.4079-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Nov 2001, Eric W. Biederman wrote:

> 	/* Make sure the mm doesn't disappear when we drop the lock.. */
> 	atomic_inc(&mm->mm_users);
> 	spin_unlock(&mmlist_lock);
>
> 	nr_pages = swap_out_mm(mm, nr_pages, &counter, classzone);
>
> 	mmput(mm);
>
>
> And looking in fork.c mmput under with right circumstances becomes.
> kmem_cache_free(mm_cachep, (mm)))
>
> So it appears that there is nothing that keeps the mm_struct that
> swap_mm points to as being valid.

The atomic_inc(&mm->mm_users) above should make sure this
mm_struct stays valid.

regards,

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

