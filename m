Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287348AbSAUQfw>; Mon, 21 Jan 2002 11:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287359AbSAUQfc>; Mon, 21 Jan 2002 11:35:32 -0500
Received: from waste.org ([209.173.204.2]:56208 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S287348AbSAUQfa>;
	Mon, 21 Jan 2002 11:35:30 -0500
Date: Mon, 21 Jan 2002 10:35:15 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Jens Axboe <axboe@suse.de>
cc: Andre Hedrick <andre@linuxdiskcert.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.3-pre1-aia1 (fwd)
In-Reply-To: <20020121113549.U27835@suse.de>
Message-ID: <Pine.LNX.4.44.0201211031240.16211-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2002, Jens Axboe wrote:

>
> I think this is too restrictive, something ala
>
> 		if (sectors % drive->mult_count)
> 			command = WIN_WRITE;

As far as I can see, mult_count will always be a power of two, so we might
consider:

   if (sectors & (drive->mult_count-1))

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

