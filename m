Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293344AbSCBJLB>; Sat, 2 Mar 2002 04:11:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310353AbSCBJKv>; Sat, 2 Mar 2002 04:10:51 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:5392 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S293344AbSCBJKm>;
	Sat, 2 Mar 2002 04:10:42 -0500
Date: Sat, 2 Mar 2002 10:10:23 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        linux-kernel@vger.kernel.org
Subject: Re: queue_nr_requests needs to be selective
Message-ID: <20020302091023.GH12014@suse.de>
In-Reply-To: <20020301132254.A11528@vger.timpanogas.org> <3C7FE7DD.98121E87@zip.com.au> <20020301162016.A12413@vger.timpanogas.org> <3C800D66.F613BBAA@zip.com.au> <20020301172701.A12718@vger.timpanogas.org> <3C8021A9.BB16E3FC@zip.com.au> <20020301191626.A13313@vger.timpanogas.org> <3C804BF0.3993B153@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C804BF0.3993B153@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01 2002, Andrew Morton wrote:
> So it would be more straightforward to just allow the queue
> to be grown later on?

I agree with that too. I'm fine with the patch, I'm just a bit worried
about the batch_request vs nr_requests ratio. Are you sure 1/4 is always
a good ratio? In my previous testing, a batch value of more than 32 had
little impact and usually changed things for the worse.

-- 
Jens Axboe

