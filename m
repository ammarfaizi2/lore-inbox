Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288845AbSBMUCp>; Wed, 13 Feb 2002 15:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288821AbSBMUCf>; Wed, 13 Feb 2002 15:02:35 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:36621 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S288845AbSBMUCV>; Wed, 13 Feb 2002 15:02:21 -0500
Date: Wed, 13 Feb 2002 16:52:34 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Hugh Dickins <hugh@veritas.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@zip.com.au>,
        Andrea Arcangeli <andrea@suse.de>,
        Rik van Riel <riel@conectiva.com.br>,
        "David S. Miller" <davem@redhat.com>,
        Benjamin LaHaise <bcrl@redhat.com>, Gerd Knorr <kraxel@bytesex.org>,
        Dave Jones <davej@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __free_pages_ok oops
In-Reply-To: <Pine.LNX.4.21.0202121929230.1468-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0202131652050.20915-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 12 Feb 2002, Hugh Dickins wrote:

> On Sat, 9 Feb 2002, Benjamin LaHaise wrote:
> > On Fri, Feb 08, 2002 at 05:46:56PM +0000, Hugh Dickins wrote:
> > > Ben, you probably have an AIO opinion here.  Is there a circumstance
> > > in which AIO can unpin a user page at interrupt time, after the
> > > calling task has (exited or) unmapped the page?
> > 
> > If the user unmaps the page, then aio is left holding the last reference 
> > to the page and will unmap it from irq or bh context (potentially task 
> > context too).  With networked aio, pages from userspace (anonymous or 
> > page cache pages) will be released by the network stack from bh context.  
> > Even now, I'm guess that should be possible with the zero copy flag...

Hugh. Are you sure we can free a page from IRQ/BH context with _current_
2.4 ? 

Please make sure so. 

