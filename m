Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280024AbRKVQiU>; Thu, 22 Nov 2001 11:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280026AbRKVQiK>; Thu, 22 Nov 2001 11:38:10 -0500
Received: from c0mailgw.prontomail.com ([216.163.180.10]:40632 "EHLO
	c0mailgw08.prontomail.com") by vger.kernel.org with ESMTP
	id <S280024AbRKVQiA>; Thu, 22 Nov 2001 11:38:00 -0500
Message-ID: <3BFD2997.95F2B9EE@starband.net>
Date: Thu, 22 Nov 2001 11:36:39 -0500
From: war <war@starband.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: James A Sutherland <jas88@cam.ac.uk>
CC: Oliver Neukum <oliver@neukum.org>, linux-kernel@vger.kernel.org
Subject: Re: Swap vs No Swap.
In-Reply-To: <3BFC5A9B.915B77DF@starband.net> <01112211150302.00690@argo> <3BFD214F.36A55D94@starband.net> <E166wSm-00063a-00@mauve.csi.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The bottom line here is:

There is no need for swap if you have enough ram.
Using swap with more than enough ram does absolutley nothing for the system,
except by degrading the performance of it.


James A Sutherland wrote:

> On Thursday 22 November 2001 4:01 pm, war wrote:
> > Once again, I have enough ram where I am not going to run out for the
> > things I do.
> > I never need swap.
> >
> > When the system swaps, it slows down the system responsiveness big time.
>
> "when it swaps" is meaningless: Linux ALWAYS swaps when there is swapspace.
> Do you mean when it *thrashes*? Or does your system have problems during I/O
> such as not using DMA for disk access?
>
> James.

On Thursday 22 November 2001 4:00 pm, war wrote:
> Incorrect, my point is I have enough ram where I am not going to run out
> for the things I do.

There's more to it than "not run out". You have some fixed amount of RAM; if
the VM is working properly, adding swap will IMPROVE performance, because
that fixed amount of RAM is used more efficiently.

Obviously, there are cases where removing swap breaks the system entirely,
but even in other cases, adding swap should *never* degrade performance. (In
theory, anyway; in practice, it still needs tuning...)

> Using swap simply slows the system down!

In which case, the VM isn't working properly; it SHOULD page out infrequently
used data to make more room for caching frequently used files.


James.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

