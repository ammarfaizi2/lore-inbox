Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129969AbRARLEs>; Thu, 18 Jan 2001 06:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130918AbRARLEi>; Thu, 18 Jan 2001 06:04:38 -0500
Received: from zeus.kernel.org ([209.10.41.242]:42712 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129969AbRARLE0>;
	Thu, 18 Jan 2001 06:04:26 -0500
Message-ID: <3A66CDB1.B61CD27B@imake.com>
Date: Thu, 18 Jan 2001 06:04:17 -0500
From: Russell Leighton <leighton@imake.com>
Reply-To: leighton@imake.com
X-Mailer: Mozilla 4.51 [en] (Win98; I)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <200101181001.f0IA11I25258@webber.adilger.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


"copy this fd to that one, and optimize that if you can"

... isn't this Larry M's "splice" (http://www.bitmover.com/lm/papers/splice.ps)?

Andreas Dilger wrote:

> Roger Wolff writes:
> > I'd prefer an interface that says "copy this fd to that one, and
> > optimize that if you can".
> >
> > For example, copying a file from one disk to another. I'm pretty sure
> > that some efficiency can be gained if you don't need to handle the
> > possibility of the userspace program accessing the data in between the
> > read and the write. Sure this may not qualify as a "trivial
> > optimization, that can be done with the existing infrastructure" right
> > now, but programs that want to indicate "kernel, please optimize this
> > if you can" can say so.
>
> Actually, this is a great example, because at one point I was working
> on a device interface which would offload all of the disk-disk copying
> overhead to the disks themselves, and not involve the CPU/RAM at all.
>
> I seem to recall that I2O promised something along these lines as well
> (i.e. direct device-device communication).
>
> Cheers, Andreas
> --
> Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
>                  \  would they cancel out, leaving him still hungry?"
> http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

--
-------------------------------------------------
Russell Leighton
leighton@imake.com
http://www.247media.com
Company Vision:
To be the preeminent global provider
of interactive marketing solutions and services.
-------------------------------------------------


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
