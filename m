Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288804AbSANFvJ>; Mon, 14 Jan 2002 00:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288809AbSANFvA>; Mon, 14 Jan 2002 00:51:00 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:31810 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S288804AbSANFul>; Mon, 14 Jan 2002 00:50:41 -0500
To: Rik van Riel <riel@conectiva.com.br>
Cc: Adam Kropelin <akropel1@rochester.rr.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18pre3-ac1
In-Reply-To: <Pine.LNX.4.33L.0201140052030.32617-100000@imladris.surriel.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 13 Jan 2002 22:47:56 -0700
In-Reply-To: <Pine.LNX.4.33L.0201140052030.32617-100000@imladris.surriel.com>
Message-ID: <m13d19qy9f.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@conectiva.com.br> writes:

> On Sun, 13 Jan 2002, Adam Kropelin wrote:
> 
> > From: "Alan Cox" <alan@redhat.com>
> >
> > > People keep bugging me about the -ac tree stuff so this is whats in my
> > > current internal diff with the ll patch and the ide changes excluded.
> 
> > For the sake of completeness I ran my large inbound FTP transfer test
> > (details in the "Writeout in recent kernels..." thread) on this
> > release. Performance and observed writeout behavior was essentially
> > the same as for 2.4.17, both stock and with -rmap11a. Transfer time
> > was 6:56 and writeout was uneven. 2.4.13-ac7 is still the winner by a
> > significant margin.
> 
> I'm looking into this bug, I just finished the first large
> dbench test set on 2.4.17-rmap11b with 512 MB RAM, tomorrow
> I'll run them with 128 and 32 MB of RAM.
> 
> Luckily you have already shown the other recent kernels to
> have the same performance, so I only have to do half a day
> of testing. I'll try to track down this bug and get it fixed.

Rik while you are looking at your reverse mapping code, I would like
to call to your attention the at least trippling of times for fork.  I
wouldn't be surprised if the reason your rmap vm handles things like
gcc -j better than the stock kernel is simply the reduced number of
processes, due to slower forking.  

Just my 2 cents so we don't forget the caveats of the reverse map
approach.

Eric
