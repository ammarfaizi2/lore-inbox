Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135480AbRAQSpP>; Wed, 17 Jan 2001 13:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135512AbRAQSpG>; Wed, 17 Jan 2001 13:45:06 -0500
Received: from baldur.fh-brandenburg.de ([195.37.0.5]:40072 "HELO
	baldur.fh-brandenburg.de") by vger.kernel.org with SMTP
	id <S135480AbRAQSov>; Wed, 17 Jan 2001 13:44:51 -0500
Date: Wed, 17 Jan 2001 19:22:36 +0100 (MET)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: Andrew Morton <andrewm@uow.edu.au>
cc: James Simmons <jsimmons@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        FrameBuffer List <linux-fbdev@vuser.vu.union.edu>,
        Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: console spin_lock
In-Reply-To: <3A65A2F1.690CD6CF@uow.edu.au>
Message-ID: <Pine.GSO.4.10.10101171859480.19156-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 18 Jan 2001, Andrew Morton wrote:

> - Get rid of the special printk buffer - share the
>   log buffer.  (Implies writes to console
>   devices will be broken into two writes when they
>   wrap around).
> - Teach vsprintf to print into a circular buffer
>   (snprintf thus comes for free).

I have a different vsprintf variant - vpprintf(). It takes a function and
a data pointer, this function is called with the print buffer and within
that function you can take care of the locking. The only problem is that
%n doesn't work anymore, but it's not used anyway in the kernel (as far as
I can grep :) ).

bye, Roman

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
