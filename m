Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263212AbRFYVQD>; Mon, 25 Jun 2001 17:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263165AbRFYVPn>; Mon, 25 Jun 2001 17:15:43 -0400
Received: from m52-mp1-cvx1a.col.ntl.com ([213.104.68.52]:21632 "EHLO
	[213.104.68.52]") by vger.kernel.org with ESMTP id <S262747AbRFYVPl>;
	Mon, 25 Jun 2001 17:15:41 -0400
To: Rik van Riel <riel@conectiva.com.br>
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: VM tuning through fault trace gathering [with actual code]
In-Reply-To: <Pine.LNX.4.21.0106251456130.7419-100000@imladris.rielhome.conectiva>
From: John Fremlin <vii@users.sourceforge.net>
Date: 25 Jun 2001 22:15:31 +0100
In-Reply-To: <Pine.LNX.4.21.0106251456130.7419-100000@imladris.rielhome.conectiva> (Rik van Riel's message of "Mon, 25 Jun 2001 14:57:39 -0300 (BRST)")
Message-ID: <m28zigi7m4.fsf@boreas.yi.org.>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@conectiva.com.br> writes:

> On 25 Jun 2001, John Fremlin wrote:
> 
> > Last year I had the idea of tracing the memory accesses of the
> > system to improve the VM - the traces could be used to test
> > algorithms in userspace. The difficulty is of course making all
> > memory accesses fault without destroying system performance.
> 
> Sounds like a cool idea.  One thing you should keep in mind though
> is to gather traces of the WHOLE SYSTEM and not of individual
> applications.

In the current patch all pagefaults are recorded from all sources. I'd
like to be able to catch read(2) and write(2) (buffer cache stuff) as
well but I don't know how . . . .

> There has to be a way to balance the eviction of pages from
> applications against those of other applications.

Of course! It is important not to regard each thread group as an
independent entity IMHO (had a big old argument about this).

[...]

-- 

	http://ape.n3.net
