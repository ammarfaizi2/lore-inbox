Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288996AbSBIXzp>; Sat, 9 Feb 2002 18:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289014AbSBIXzf>; Sat, 9 Feb 2002 18:55:35 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50180 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S288996AbSBIXzZ>;
	Sat, 9 Feb 2002 18:55:25 -0500
Message-ID: <3C65B6EA.E2C1D123@mandrakesoft.com>
Date: Sat, 09 Feb 2002 18:55:22 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@caldera.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kthread abstraction, take two
In-Reply-To: <20020209180305.A11717@caldera.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> 
> This is a new version of the ktread abstraction which incorporates
> suggestions by Andi Kleen, Jeff Garzik and Andrew Morton.
> 
> The changes are:
> 
>   - kthread_start now takes a void * for the user-data, so it doesn't
>     have to be part of struct kthread.
>   - the main method of struct kthread now returns an integers, if it
>     is negative, the thread will be stopped.
>   - kthread_main no more does the scheduling, it has to be done by
>     the mainloop now.

Nice.  I like it.

Would you consider converting a few places in the kernel to use kthread,
just as an example to show people what a sample implementation would
look like?

	Jeff



-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
