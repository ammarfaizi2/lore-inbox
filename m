Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269101AbRHTUGz>; Mon, 20 Aug 2001 16:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269068AbRHTUGp>; Mon, 20 Aug 2001 16:06:45 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:47119 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S269101AbRHTUGa>; Mon, 20 Aug 2001 16:06:30 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>,
        Benjamin Redelings I <bredelin@ucla.edu>
Subject: Re: 2.4.8/2.4.9 VM problems
Date: Mon, 20 Aug 2001 22:13:08 +0200
X-Mailer: KMail [version 1.3.1]
Cc: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
In-Reply-To: <Pine.LNX.4.33L.0108201402140.31410-100000@duckman.distro.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0108201402140.31410-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010820200639Z16342-32383+579@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 20, 2001 07:02 pm, Rik van Riel wrote:
> On Mon, 20 Aug 2001, Benjamin Redelings I wrote:
> 
> > Was it really true, that swapped in pages didn't get marked as
> > referenced before?
> 
> That's just an artifact of the use-once patch, which
> only sets the referenced bit on the _second_ access
> to a page.

It was an artifact of the change in lru_cache_add where all new pages start 
on the inactive queue instead of the active queue.

--
Daniel
