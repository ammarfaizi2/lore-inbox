Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135488AbRAYSBl>; Thu, 25 Jan 2001 13:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132699AbRAYSBc>; Thu, 25 Jan 2001 13:01:32 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:29197 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S132577AbRAYSBO>;
	Thu, 25 Jan 2001 13:01:14 -0500
Date: Thu, 25 Jan 2001 18:59:49 +0100
From: Jens Axboe <axboe@suse.de>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Pete Zaitcev <zaitcev@metabyte.com>, linux-kernel@vger.kernel.org
Subject: Re: patchlet for cs46xx
Message-ID: <20010125185949.B444@suse.de>
In-Reply-To: <3A70588B.4692D937@metabyte.com> <Pine.LNX.3.95.1010125123928.9456A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1010125123928.9456A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Thu, Jan 25, 2001 at 12:41:28PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 25 2001, Richard B. Johnson wrote:
> [SNIPPED...]
> >From what I tested, copy_to/from_user, now seg-faults the caller directly.
> If the function returns, it worked. Therefore you will never get a
> chance to return -EFAULT.

Huh?? copy_to/from_user returns the bytes _not_ copied, in which
case you return -EFAULT go segv the caller.

I think the confusion usually is that put/get_user return -EFAULT
directly.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
