Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277371AbRKABlt>; Wed, 31 Oct 2001 20:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277514AbRKABlk>; Wed, 31 Oct 2001 20:41:40 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:58896 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S277371AbRKABlY>;
	Wed, 31 Oct 2001 20:41:24 -0500
Date: Wed, 31 Oct 2001 23:41:42 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Ben Smith <ben@google.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Andrea Arcangeli <andrea@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: Google's mm problem - not reproduced on 2.4.13
In-Reply-To: <3BE0A2C1.70600@google.com>
Message-ID: <Pine.LNX.4.33L.0110312341030.2963-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Oct 2001, Ben Smith wrote:

> > *Just in case* it's oom-related I've asked Ben to try it with one less than
> > the maximum number of memory blocks he can allocate.
>
> I've run this test with my 3.5G machine, 3 blocks instead of 4 blocks,
> and it has the same behavior (my app gets killed, 0-order allocation
> failures, and the system stays up.

If you still have swap free at the point where the process
gets killed, or if the memory is file-backed, then we are
positive it's a kernel bug.

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

