Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314584AbSEPT0c>; Thu, 16 May 2002 15:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314596AbSEPT0b>; Thu, 16 May 2002 15:26:31 -0400
Received: from imladris.infradead.org ([194.205.184.45]:47110 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S314584AbSEPT0a>; Thu, 16 May 2002 15:26:30 -0400
Date: Thu, 16 May 2002 20:26:26 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrea Arcangeli <andrea@suse.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre8aa3
Message-ID: <20020516202626.A13795@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrea Arcangeli <andrea@suse.de>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020515212733.GA1025@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2002 at 11:27:33PM +0200, Andrea Arcangeli wrote:
> o	minor bdflush tuning difference to avoid char-writer in bonnie
> 	to stall and to slowdown too much (can make a difference in real
> 	life)

...

> Only in 2.4.19pre8aa3: 00_bdflush-tuning-1
> 
> 	Put the mid watermark at 50% (near the high watermark so we don't stall
> 	too much).

As the 2.4.19-pre mainline got your buffer throtteling changes I guess it
has the same issues?  Do you think it's worth to submit that patch to Marcelo
even that late in the release cycle?

> Only in 2.4.19pre8aa2: 05_vm_10_read_write_tweaks-1
> Only in 2.4.19pre8aa3: 05_vm_10_read_write_tweaks-2
> 
> 	Avoid backing out the flush_page_to_ram in this vm patch,
> 	the one on the pagecache is still needed before the memcpy
> 	on the pagecache during the early cow (would be cleaner
> 	to move it up, if Hugh wants to clean it up that's welcome,
> 	it will be an orthogonal patch, so far I just avoid to
> 	change that area in my changes, not high prio to clean it up
> 	as DaveM side it's more high prio to conver the users of
> 	flush_page_to_ram API to flush_dcache_page/icache new API during 2.5).

It seems to me you ignore the comments akpm put in the split patches you
merged :)  Not only the comment to this change is superflous now, but also
I'd really like to get an answer to the remaining part of it as Andrew's
comment about that part beeing buggy makes a lot of sense to me..

