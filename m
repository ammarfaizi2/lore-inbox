Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315440AbSFEORl>; Wed, 5 Jun 2002 10:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315442AbSFEORk>; Wed, 5 Jun 2002 10:17:40 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:216 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S315440AbSFEORj>;
	Wed, 5 Jun 2002 10:17:39 -0400
Date: Wed, 5 Jun 2002 16:17:17 +0200
From: Jens Axboe <axboe@suse.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.20 IDE 85
Message-ID: <20020605141717.GB16257@suse.de>
In-Reply-To: <Pine.LNX.4.33.0206021853030.1383-100000@penguin.transmeta.com> <3CFE0C16.1020203@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05 2002, Martin Dalecki wrote:

AFAICS, you just introduced some nasty list races in the interrupt
handlers. You must hold the queue locks when calling
blkdev_dequeue_request() and end_that_request_last(), for instance.

-- 
Jens Axboe

