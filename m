Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286541AbRL0TpZ>; Thu, 27 Dec 2001 14:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286556AbRL0TpO>; Thu, 27 Dec 2001 14:45:14 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:37900 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S286541AbRL0TpB>; Thu, 27 Dec 2001 14:45:01 -0500
Message-ID: <3C2B7981.EDCBEFA@zip.com.au>
Date: Thu, 27 Dec 2001 11:41:53 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Andre Hedrick <andre@linux-ide.org>, Keith Owens <kaos@ocs.com.au>,
        kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: your mail
In-Reply-To: <Pine.LNX.4.10.10112271008350.24428-100000@master.linux-ide.org> <Pine.LNX.4.33.0112271025590.1052-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> The other part of the bio rewrite has been to get rid of another coupling:
> the coupling between "struct buffer_head" (which is used for a limited
> kind of memory management by a number of filesystems) and the act of
> actually just doing IO.
> 
> I used to think that we could just relegate "struct buffer_head" to _be_
> the IO entity, but it turns out to be much easier to just split off the IO
> part, which is why you now have a separate "bio" structure for the block
> IO part, and the buffer_head stuff uses that to get the work done.
> 

So... would it be correct to say that there won't be any large
changes to the buffer_head concept in 2.5?
