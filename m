Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316593AbSFDMHX>; Tue, 4 Jun 2002 08:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316595AbSFDMHW>; Tue, 4 Jun 2002 08:07:22 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:31683 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S316593AbSFDMHT>;
	Tue, 4 Jun 2002 08:07:19 -0400
Date: Tue, 4 Jun 2002 14:07:09 +0200
From: Jens Axboe <axboe@suse.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ]PATCH] 2.5.20 IDE 83
Message-ID: <20020604120709.GA1105@suse.de>
In-Reply-To: <Pine.LNX.4.33.0206021853030.1383-100000@penguin.transmeta.com> <3CFB7899.3060209@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03 2002, Martin Dalecki wrote:
> - Patch for DVD read through ide-scsi. There is the possibility that we can 
> get
>   request structures passed down, which don't have the queue field set.
>   At lest on the BIO code path this seems to be something worth further
>   investigation. Found by Adam J. Richter. (Jens?)

It's because of the scsi mid layer queueing private requests which have
rq->q cleared. The fix looks correct.

-- 
Jens Axboe

