Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310357AbSCBJYH>; Sat, 2 Mar 2002 04:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310356AbSCBJXs>; Sat, 2 Mar 2002 04:23:48 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39945 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S310355AbSCBJXj>;
	Sat, 2 Mar 2002 04:23:39 -0500
Message-ID: <3C8099BF.85BA994D@zip.com.au>
Date: Sat, 02 Mar 2002 01:22:07 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        linux-kernel@vger.kernel.org
Subject: Re: queue_nr_requests needs to be selective
In-Reply-To: <20020301132254.A11528@vger.timpanogas.org> <3C7FE7DD.98121E87@zip.com.au> <20020301162016.A12413@vger.timpanogas.org> <3C800D66.F613BBAA@zip.com.au> <20020301172701.A12718@vger.timpanogas.org> <3C8021A9.BB16E3FC@zip.com.au> <20020301191626.A13313@vger.timpanogas.org> <3C804BF0.3993B153@zip.com.au>,
		<3C804BF0.3993B153@zip.com.au> <20020302091023.GH12014@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> On Fri, Mar 01 2002, Andrew Morton wrote:
> > So it would be more straightforward to just allow the queue
> > to be grown later on?
> 
> I agree with that too. I'm fine with the patch,

Thanks.

> I'm just a bit worried
> about the batch_request vs nr_requests ratio. Are you sure 1/4 is always
> a good ratio? In my previous testing, a batch value of more than 32 had
> little impact and usually changed things for the worse.
> 

Well I just left it as it was for the default case...

I haven't tested much at all for different batching levels.  And
in this area, tuning it for my combination of hardware probably
doesn't carry much relevance for Jeff's setup (for example).

And the change to FIFO wakeup may have invalidated your earlier
testing.

So hmm.  I'll have a play with it, and if nothing obvious jumps
out, I'll just clamp it at 32.

-
