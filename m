Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130211AbQKWTcq>; Thu, 23 Nov 2000 14:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129903AbQKWTc1>; Thu, 23 Nov 2000 14:32:27 -0500
Received: from mail.zmailer.org ([194.252.70.162]:40973 "EHLO zmailer.org")
        by vger.kernel.org with ESMTP id <S129097AbQKWTcX>;
        Thu, 23 Nov 2000 14:32:23 -0500
Date: Thu, 23 Nov 2000 21:02:07 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: alloc_tty_struct() question.
Message-ID: <20001123210207.D28963@mea-ext.zmailer.org>
In-Reply-To: <Pine.LNX.4.21.0011231852590.2128-100000@penguin.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0011231852590.2128-100000@penguin.homenet>; from tigran@aivazian.fsnet.co.uk on Thu, Nov 23, 2000 at 06:54:48PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2000 at 06:54:48PM +0000, Tigran Aivazian wrote:
> Hi,
> 
> The sizeof(struct tty_struct) = 3084. Why don't we have a private slab
> cache for it instead of getting a page and wasting some precious bytes at
> the end? Potentially, we can have thousands of tty_struct allocated
> (assuming we have thousands of concurrent users)...

	Potentially thousands, in practice some 10-30.
	Wastage will be worse with 8k pages, of course.

> regards,
> Tigran
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
