Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130642AbQLaTnr>; Sun, 31 Dec 2000 14:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130774AbQLaTnh>; Sun, 31 Dec 2000 14:43:37 -0500
Received: from hermes.mixx.net ([212.84.196.2]:34822 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S130642AbQLaTn0>;
	Sun, 31 Dec 2000 14:43:26 -0500
Message-ID: <3A4F84B2.D691EC50@innominate.de>
Date: Sun, 31 Dec 2000 20:10:42 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Generic deferred file writing
In-Reply-To: <3A4F7B45.C8313E8A@innominate.de> <Pine.LNX.4.10.10012311035020.4239-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
>  I do not believe that "get_block()" is as big of a problem as people make
>  it out to be.

I didn't mention get_block - disk accesses obviously far outweigh
filesystem cpu/cache usage in overall impact.  The question is, what
happens to disk access patterns when we do the deferred allocation.

> One form of deferred writes I _do_ like is the mount-time-option form.
> Because that one doesn't add complexity. Kind of like the "noatime" mount
> option - it can be worth it under some circumstances, and sometimes it's
> acceptable to not get 100% unix semantics - at which point deferred writes
> have none of the disadvantages of trying to be clever.

And the added attraction of requiring almost no effort.
	
--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
