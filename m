Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272124AbRIJXZU>; Mon, 10 Sep 2001 19:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272164AbRIJXZM>; Mon, 10 Sep 2001 19:25:12 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:24513 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S272124AbRIJXZA>;
	Mon, 10 Sep 2001 19:25:00 -0400
Date: Tue, 11 Sep 2001 00:25:16 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Daniel Phillips <phillips@bonn-fries.net>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>
Cc: Andreas Dilger <adilger@turbolabs.com>, Andrea Arcangeli <andrea@suse.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: linux-2.4.10-pre5
Message-ID: <1735991721.1000167915@[169.254.198.40]>
In-Reply-To: <20010910230554Z16824-26183+920@humbolt.nl.linux.org>
In-Reply-To: <20010910230554Z16824-26183+920@humbolt.nl.linux.org>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Tuesday, 11 September, 2001 1:13 AM +0200 Daniel Phillips 
<phillips@bonn-fries.net> wrote:

> OK, now to shorten this up, if you've reached the conclusion that the
> page  cache needs to be able to take advantage of blocks already read
> into the  buffer cache then we're done.  That was my point all along.

ACK. May be I am arguing all pages read should live in page/unified cache,
i.e. current buffer cache should at most contain references to data already
read and influence expiry of those pages (as opposed to hold private copies
thereof) - see previous readahead debate ref best/worst pages to expire -
BUT STILL thus drive what is cached at the layers below, (i.e.
drive the file based readahead). Not saying there is necessarilly no place
for physical readahead even with disks being able to do it, just difficult
to measure whilst all logical readahead pages put in buffer cache cannot be
taken advantage of by page cache.

It may well be that I am lagging well behind on the thought process.
Need lkml readahead obviously :-)

--
Alex Bligh
