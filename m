Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261872AbSJKIWr>; Fri, 11 Oct 2002 04:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261974AbSJKIWr>; Fri, 11 Oct 2002 04:22:47 -0400
Received: from denise.shiny.it ([194.20.232.1]:3758 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S261872AbSJKIWq>;
	Fri, 11 Oct 2002 04:22:46 -0400
Message-ID: <XFMail.20021011102620.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20021010225050.GC2673@matchmail.com>
Date: Fri, 11 Oct 2002 10:26:20 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: Mike Fedyk <mfedyk@matchmail.com>
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
Cc: andersen@codepoet.org, Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Mark Mielke <mark@mark.mielke.cc>, linux-kernel@vger.kernel.org,
       Robert Love <rml@tech9.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> When a process opens a file with O_STREAMING, it tells the kernel
>> it will use the data only once, but it tells nothing about other
>> tasks. If that process reads something which is already cached,
>> then it must not drop it because someone other used it recently
>> and IMHO pagecache only should be allowed to drop it.
>
> You are missing the point.  If the app thinks that might happen, it
> shouldn't use O_STREAMING.
> 
> Though, how do you get around some binary app using O_STREAMING when it
> shouldn't?

Yes, it is with the current behaviour of O_STREAMING. If we change it to
what I said above, O_STREAMING becomes useful in a larger set of cases
with no drawbacks, I think. To not drop pages that were not loaded with
O_STREAMING flag sounds simple, but I don't know how much it is easy to
implement.


Bye.

