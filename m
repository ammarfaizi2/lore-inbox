Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268778AbRHFPUY>; Mon, 6 Aug 2001 11:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268779AbRHFPUF>; Mon, 6 Aug 2001 11:20:05 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:40283 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S268778AbRHFPT5>; Mon, 6 Aug 2001 11:19:57 -0400
To: Chris Mason <mason@suse.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, torvalds@transmeta.com
Subject: Re: [RFC] using writepage to start io
In-Reply-To: <209120000.997036451@tiny>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 06 Aug 2001 09:13:20 -0600
In-Reply-To: <209120000.997036451@tiny>
Message-ID: <m11ympw7an.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason <mason@suse.com> writes:

> On Wednesday, August 01, 2001 04:57:35 PM +0200 Daniel Phillips
> <phillips@bonn-fries.net> wrote:
> 
> > On Tuesday 31 July 2001 21:07, Chris Mason wrote:
> >> This has been tested a little more now, both ext2 (1k, 4k) and
> >> reiserfs.  dbench and iozone testing don't show any difference, but I
> >> need to spend a little more time on the benchmarks.
> > 
> > It's impressive that such seemingly radical surgery on the vm innards 
> > is a) possible and b) doesn't make the system perform noticably worse.
> 
> radical surgery is always possible ;-)  But, I was expecting better
> performance results than I got.  I'm trying a few other things out here,
> more details will come if they work.  

Hmm.  I would expect that could could entirely avoid the issue of which
hash chain to put pages on if you did the block devices in the page cache
thing.    The the current buffer cache interface  becomes just a
backwards compatibility layer which should make things cleaner.

Eric
