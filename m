Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262027AbSJIUjB>; Wed, 9 Oct 2002 16:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262000AbSJIUjA>; Wed, 9 Oct 2002 16:39:00 -0400
Received: from 10fwd.cistron-office.nl ([62.216.29.197]:2009 "EHLO
	smtp.cistron-office.nl") by vger.kernel.org with ESMTP
	id <S262027AbSJIUi7>; Wed, 9 Oct 2002 16:38:59 -0400
Date: Wed, 9 Oct 2002 22:44:36 +0200
From: Miquel van Smoorenburg <miquels@cistron.nl>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.41-mm1 panics on boot, 2.5.41-vanilla OK
Message-ID: <20021009224436.A24150@cistron.nl>
References: <ao1orf$m2l$1@ncc1701.cistron.net> <3DA47455.6F78E6F1@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3DA47455.6F78E6F1@digeo.com>; from akpm@digeo.com on Wed, Oct 09, 2002 at 11:24:21AM -0700
X-NCC-RegID: nl.cistron
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to Andrew Morton:
> Miquel van Smoorenburg wrote:
> > 
> > As per subject: 2.5.41-mm1 panics on boot, 2.5.41-vanilla OK.
> > 
> Does this fix it?
> 
> --- 2.5.41/mm/slab.c~slab-split-10-list_for_each_fix	Tue Oct  8 15:40:52 2002
> +++ 2.5.41-akpm/mm/slab.c	Tue Oct  8 15:40:52 2002

Yes, it does fix it. I still get quite a lot of
"Debug: sleeping function called from illegal context" and
"bad: scheduling while atomic!" while booting, but after booting
it looks stable (well, only 8 minutes of uptime). You probably
know about those already so I'll not bore you with the
bootup log messages.

I'm now running 2.5.41-mm1 + the above patch + the raid0 patch +
the mremap fix (CONFIG_HIGHPTE -> CONFIG_HIGHMEM) on our news
peering server.

It's looking better swap-wise than 2.5.40 - it's only 116K
into swap, looks like stuff that should remain in memory
is staying there.

I'll let you know if tonights expire finishes in 15 minutes
instead of 15 hours ...

Mike.
