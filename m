Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310154AbSCUKPU>; Thu, 21 Mar 2002 05:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310168AbSCUKPH>; Thu, 21 Mar 2002 05:15:07 -0500
Received: from mailrelay1.lrz-muenchen.de ([129.187.254.101]:5261 "EHLO
	mailrelay1.lrz-muenchen.de") by vger.kernel.org with ESMTP
	id <S310154AbSCUKO4>; Thu, 21 Mar 2002 05:14:56 -0500
Date: Thu, 21 Mar 2002 11:14:49 +0100 (MET)
From: Oliver.Neukum@lrz.uni-muenchen.de
X-X-Sender: ui222bq@sun4.lrz-muenchen.de
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>,
        Axel Kittenberger <Axel.Kittenberger@maxxio.at>,
        <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: Patch, forward release() return values to the close() call
In-Reply-To: <3C99A54D.1050206@mandrakesoft.com>
Message-Id: <Pine.SOL.4.44.0203211113500.6558-100000@sun4.lrz-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2002, Jeff Garzik wrote:

> Oliver Neukum wrote:
>
> >On Thursday 21 March 2002 09:27, Jeff Garzik wrote:
> >
> >>Whoops, my apologies.  The patch looks ok to me.
> >>
> >>I read your text closely and the patch not close enough.  As I said, it
> >>is indeed wrong for a device driver to fail f_op->release(), "fail"
> >>being defined as leaving fd state lying around, assuming that the system
> >>will fail the fput().
> >>
> >>But your patch merely propagates a return value, not change behavior,
> >>which seems sane to me.
> >>
> >
> >Hi,
> >
> >close() does not directly map to release().
> >If you want your device to return error
> >information reliably, you need to implement flush().
> >
>
> Agreed.
>
> I still think propagating f_op->release's return value is a good idea,
> though.
>
>     Jeff

Probably. Throwing away information without need is bad.

	Regards
		Oliver


