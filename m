Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273038AbRIIUm3>; Sun, 9 Sep 2001 16:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273043AbRIIUmT>; Sun, 9 Sep 2001 16:42:19 -0400
Received: from [208.129.208.52] ([208.129.208.52]:56324 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S273038AbRIIUmH>;
	Sun, 9 Sep 2001 16:42:07 -0400
Message-ID: <XFMail.20010909134444.davidel@xmailserver.org>
X-Mailer: XFMail 1.5.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.33L.0109091722060.21049-100000@duckman.distro.conectiva>
Date: Sun, 09 Sep 2001 13:44:44 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: Purpose of the mm/slab.c changes
Cc: torvalds@transmeta.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org, Andrea Arcangeli <andrea@suse.de>,
        Manfred Spraul <manfred@colorfullife.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 09-Sep-2001 Rik van Riel wrote:
> On Sun, 9 Sep 2001, Manfred Spraul wrote:
> 
>> > it provides lifo allocations from both partial and unused slabs.
>>
>> lifo/fifo for unused slabs is obviously superflous - free is
>> free, it doesn't matter which free page is used first/last.
> 
> Mind that the L2 cache is often as much as 10 times faster
> than RAM, so it would be nice if we had a good chance that
> the slab we just allocated would be in L2 cache.

Do You see it as a plus ?
The new allocated slab will be very likely written ( w/o regard about the old content )
and an L2 mapping will generate invalidate traffic.



- Davide

