Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132881AbRDUTzy>; Sat, 21 Apr 2001 15:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132875AbRDUTzp>; Sat, 21 Apr 2001 15:55:45 -0400
Received: from diup-184-214.inter.net.il ([213.8.184.214]:63493 "EHLO
	callisto.yi.org") by vger.kernel.org with ESMTP id <S132869AbRDUTz2>;
	Sat, 21 Apr 2001 15:55:28 -0400
Date: Sat, 21 Apr 2001 22:55:06 +0300 (IDT)
From: Dan Aloni <karrde@callisto.yi.org>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@image.dk>
Subject: Re: cdrom driver dependency problem (and a workaround patch)
In-Reply-To: <20010421212645.W719@nightmaster.csn.tu-chemnitz.de>
Message-ID: <Pine.LNX.4.32.0104212250150.31353-100000@callisto.yi.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Apr 2001, Ingo Oeser wrote:

> On Sat, Apr 21, 2001 at 08:33:05PM +0300, Dan Aloni wrote:
> > On Sat, 21 Apr 2001, Ingo Oeser wrote:
> > > The link order is wrong. So why not changing the link order then?
> >
> > I remember doing what the patch below does.
> > It didn't help.
>
> Hmm, maybe you had a typo?

No, I meant I tested this exact patch you wrote on my system and it
doesn't fix the Oops on boot problem. Maybe I forgot to recompile the
kernel while I tested it, but I doubt.

> > Did you try this patch?
>
> Yes, just booted an SMP machine with 2.4.3-ac11 and this patch.
>
> I booted remote, so it was some kind of dangerous, if it wouldn't
> work ;-)
>
> We also have SCSI enabled there. So it really works ;-)

I'm happy to hear it works on your system, but I don't think we should
relay on link ordering in order to resolve dependency problems. More
generally, it's kinda dirty the way it works now in the kernel, where the
initialization order is determined by the linkage order.

--
Dan Aloni
dax@karrde.org

