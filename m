Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269763AbRHTWsZ>; Mon, 20 Aug 2001 18:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269752AbRHTWsQ>; Mon, 20 Aug 2001 18:48:16 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:15876 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S269763AbRHTWr6>; Mon, 20 Aug 2001 18:47:58 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: 2.4.8/2.4.9 VM problems
Date: Tue, 21 Aug 2001 00:54:32 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Mike Galbraith <mikeg@wen-online.de>,
        Frank Dekervel <Frank.dekervel@student.kuleuven.ac.Be>,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0108201712360.538-100000@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.21.0108201712360.538-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010820224802Z16009-32384+228@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 20, 2001 10:16 pm, Marcelo Tosatti wrote:
> On Mon, 20 Aug 2001, Marcelo Tosatti wrote:
> > On Mon, 20 Aug 2001, Daniel Phillips wrote:
> > > On Mon, 20 Aug 2001, Marcelo Tosatti wrote:
> > > > Find riel's message with topic "VM tuning" to linux-mm, then take a look
> > > > at the 4th aging option.
> > > > 
> > > > That one _should_ be able to make us remove all kinds of "hacks" to do
> > > > drop behind, and also it should keep hot/warm active memory _in cache_
> > > > for more time. 
> > > 
> > > I looked at it yesterday.  The problem is, it loses the information about *how*
> > > a page is used: pagecache lookup via readahead has different implications than
> > > actual usage.
> 
> And ah, I forgot something here. 
> 
> Your statement which says "pagecache lookup via readahead has different
> implications than actual usage" is not really correct.
> 
> If you only consider "hot" pages as "pages which have been touched",
> you're going to (potentially) fuck heavy streaming IO workloads.

"Hot" pages are pages that have been touched more than once.  The idea of
use-once (on the read side) is to retain the readahead pages just long enough
to use them, and not a lot longer.  If you've seen streaming IO pages getting
evicted before being used, I'd like to know about it because something is
broken in that case.

--
Daniel
