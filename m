Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315439AbSFEO6x>; Wed, 5 Jun 2002 10:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315447AbSFEO6w>; Wed, 5 Jun 2002 10:58:52 -0400
Received: from [195.63.194.11] ([195.63.194.11]:55557 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315439AbSFEO6w>; Wed, 5 Jun 2002 10:58:52 -0400
Message-ID: <3CFE1974.9080509@evision-ventures.com>
Date: Wed, 05 Jun 2002 16:00:20 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.20 IDE 85
In-Reply-To: <Pine.LNX.4.33.0206021853030.1383-100000@penguin.transmeta.com> <3CFE0C16.1020203@evision-ventures.com> <20020605141717.GB16257@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Wed, Jun 05 2002, Martin Dalecki wrote:
> 
> AFAICS, you just introduced some nasty list races in the interrupt
> handlers. You must hold the queue locks when calling
> blkdev_dequeue_request() and end_that_request_last(), for instance.
> 

No. Please be more accurate. Becouse:

1. If anything I have made existing races only "obvious".

2. It is called in the context of do_ide_request or ide_raw_taskfile
    where we already have the lock.


