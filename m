Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129399AbRAaKXd>; Wed, 31 Jan 2001 05:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129485AbRAaKXZ>; Wed, 31 Jan 2001 05:23:25 -0500
Received: from zeus.kernel.org ([209.10.41.242]:59869 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129399AbRAaKXQ>;
	Wed, 31 Jan 2001 05:23:16 -0500
Date: Wed, 31 Jan 2001 10:21:58 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Stephen Tweedie <sct@redhat.com>
Subject: Re: [PATCH] vma limited swapin readahead
Message-ID: <20010131102158.O11607@redhat.com>
In-Reply-To: <Pine.LNX.4.21.0101310037540.16187-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.21.0101310037540.16187-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Wed, Jan 31, 2001 at 01:05:02AM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jan 31, 2001 at 01:05:02AM -0200, Marcelo Tosatti wrote:
> 
> However, the pages which are contiguous on swap are not necessarily
> contiguous in the virtual memory area where the fault happened. That means
> the swapin readahead code may read pages which are not related to the
> process which suffered a page fault.
> 
Yes, but reading extra sectors is cheap, and throwing the pages out of
memory again if they turn out not to be needed is also cheap.  The
on-disk swapped pages are likely to have been swapped out at roughly
the same time, which is at least a modest indicator of being of the
same age and likely to have been in use at the same time in the past.

I'd like to see at lest some basic performance numbers on this,
though.

Cheers,
 Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
