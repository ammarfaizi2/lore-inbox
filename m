Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271857AbRIYWD5>; Tue, 25 Sep 2001 18:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271809AbRIYWDk>; Tue, 25 Sep 2001 18:03:40 -0400
Received: from [195.223.140.107] ([195.223.140.107]:20208 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274694AbRIYWDX>;
	Tue, 25 Sep 2001 18:03:23 -0400
Date: Wed, 26 Sep 2001 00:03:47 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: "David S. Miller" <davem@redhat.com>, marcelo@conectiva.com.br,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Locking comment on shrink_caches()
Message-ID: <20010926000347.H8350@athlon.random>
In-Reply-To: <20010925.131528.78383994.davem@redhat.com> <Pine.LNX.4.21.0109251601360.2193-100000@freak.distro.conectiva> <20010925.132905.32720330.davem@redhat.com> <20010925170055.B19494@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010925170055.B19494@redhat.com>; from bcrl@redhat.com on Tue, Sep 25, 2001 at 05:00:55PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2001 at 05:00:55PM -0400, Benjamin LaHaise wrote:
> even worse.  I'd rather try to use some of the rcu techniques for 
> page cache lookup, and per-page locking for page cache removal 
> which will lead to *cleaner* code as well as a much more scalable 

I don't think rcu fits there, truncations and releasing must be
extremely efficient too.

Andrea
