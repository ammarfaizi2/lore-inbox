Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129703AbQL1ORy>; Thu, 28 Dec 2000 09:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129881AbQL1ORn>; Thu, 28 Dec 2000 09:17:43 -0500
Received: from host0.the-party.cybercity.dk ([62.66.128.2]:13322 "HELO
	fw.theparty.dk") by vger.kernel.org with SMTP id <S129703AbQL1ORe>;
	Thu, 28 Dec 2000 09:17:34 -0500
Date: Thu, 28 Dec 2000 14:47:59 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: plug problem in linux-2.4.0-test11
Message-ID: <20001228144759.C386@suse.de>
In-Reply-To: <C12569A6.00425037.00@d12mta07.de.ibm.com> <20001227210426.B10446@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001227210426.B10446@athlon.random>; from andrea@suse.de on Wed, Dec 27, 2000 at 09:04:26PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 27 2000, Andrea Arcangeli wrote:
> I think right behaviour of the blkdev layer is to BUG() if the driver eats
> requests while the device is plugged.

The device is supposed to know what it's doing. Sure it defeats the
elevators work a bit, but again the driver should know best. Besides, it
doesn't seem worthwhile to go to any lengths detecting this.

But in general I agree, device request_fn should never touch a plugged
queue.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
