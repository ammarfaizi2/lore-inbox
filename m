Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278406AbRJWX7K>; Tue, 23 Oct 2001 19:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278414AbRJWX7A>; Tue, 23 Oct 2001 19:59:00 -0400
Received: from lsmls02.we.mediaone.net ([24.130.1.15]:3226 "EHLO
	lsmls02.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S278406AbRJWX6r>; Tue, 23 Oct 2001 19:58:47 -0400
Message-ID: <3BD60491.25152E6C@kegel.com>
Date: Tue, 23 Oct 2001 17:00:17 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Issue with max_threads (and other resources) and highmem
In-Reply-To: <Pine.LNX.4.33L.0110232134470.3690-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Tue, 23 Oct 2001, Dan Kegel wrote:
> > Rik wrote:
> > > ... A sane upper limit for
> > > max_threads would be 10000, this also keeps in mind the
> > > fact that we only have 32000 possible PIDs, some of which
> > > could be taken by task groups, etc...
> >
> > ?  I thought the 2.4 kernel had switched to 32 bit pid's long ago.
> > Where does the limit of 32000 possible PIDs come from?
> 
> Please take a look at kernel/fork.c::get_pid() ...

Yes, I see the limit is enforced there, but why do we need that limit?

There are probably a bunch of user-space programs that assume
a pid fits in five digits, is that the main reason?
- Dan
