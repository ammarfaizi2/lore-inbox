Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313115AbSDYMvE>; Thu, 25 Apr 2002 08:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313116AbSDYMvD>; Thu, 25 Apr 2002 08:51:03 -0400
Received: from imladris.infradead.org ([194.205.184.45]:26632 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S313115AbSDYMvC>; Thu, 25 Apr 2002 08:51:02 -0400
Date: Thu, 25 Apr 2002 13:50:48 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] page->flags cleanup
Message-ID: <20020425135048.A24800@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@zip.com.au>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3CC6720F.BD1367B9@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2002 at 01:51:27AM -0700, Andrew Morton wrote:
> 
> Moves the definitions of the page->flags bits and all the PageFoo
> macros into linux/page-flags.h.  That file is currently included from
> mm.h, but the stage is set to remove that and include page-flags.h
> direct in all .c files which require that.  (120 of them).

What about moving not only the flags but also struct page itself to
<linux/page.h>?  I think they belong together and don't have much shared
with the other bits of mm.h, so this makes some sense.

