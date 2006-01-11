Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbWAKOPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWAKOPA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 09:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbWAKOPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 09:15:00 -0500
Received: from zproxy.gmail.com ([64.233.162.192]:11218 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751511AbWAKOPA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 09:15:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QbGAGuW+noj0bF3GPPq3f/XTMn9DKlzfPCTTIU6y0+497xwfs/rT3LSWv7y75cYOh3uOw7AEQFtIsa9tUrwngNk/ok/LD620yB2ghXHJQMyJSQZHJHwoTO/yyHLT2KxC/S0J0HhkZWc4j+A5UwwK+NbZkxEYyWB7scAhYhky9F8=
Message-ID: <f0309ff0601110614s3007cfb5g11278f9850225a8c@mail.gmail.com>
Date: Wed, 11 Jan 2006 06:14:58 -0800
From: Nauman Tahir <nauman.tahir@gmail.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: Although CONFIG_IRQBALANCE is enabled IRQ's don't seem to be balanced very well
Cc: Martin Bligh <mbligh@mbligh.org>, Josef Sipek <jsipek@fsl.cs.sunysb.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <9a8748490601101414o4e380abeme8b20a458e9e97bf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9a8748490601100314u26d4a566uc41a1912e410ea46@mail.gmail.com>
	 <20060110203115.GB5479@filer.fsl.cs.sunysb.edu>
	 <43C42708.4020108@mbligh.org>
	 <9a8748490601101410i31a8447ev2bf8fafe570fc407@mail.gmail.com>
	 <43C4314C.4030800@mbligh.org>
	 <9a8748490601101414o4e380abeme8b20a458e9e97bf@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 1/10/06, Martin Bligh <mbligh@mbligh.org> wrote:
> > Jesper Juhl wrote:
> > > On 1/10/06, Martin Bligh <mbligh@mbligh.org> wrote:
> > >
> > >>Josef Sipek wrote:
> > >>
> > >>>On Tue, Jan 10, 2006 at 12:14:42PM +0100, Jesper Juhl wrote:
> > >>>
> > >>>
> > >>>>Do I need any userspace tools in addition to CONFIG_IRQBALANCE?
> > >>>
> > >>>
> > >>>Last I checked, yes you do need "irqbalance" (at least that's what
> > >>>the package is called in debian.
> > >>
> > >>Nope - you need the kernel option turned on OR the userspace daemon,
> > >>not both.
> > >>
> > >
> > > Ok, good to know.
> > >
> > >
> > >>If you're not generating interrupts at a high enough rate, it won't
> > >>rotate. That's deliberate.
> > >>

What I have read is that first CPU is used more for interrupts to use
the concept of maximizing cache locality. Probably kernel is
optimizing this even with CONFIG option enabled.

Nauman

> > >
> > >
> > > Hmm, and what would count as "a high enough rate"?
> > >
> > > I just did a small test with thousands of  ping -f's through my NIC
> > > while at the same time giving the disk a good workout with tons of
> > > find's, sync's & updatedb's - that sure did drive up the number of
> > > interrupts and my load average went sky high (amazingly the box was
> > > still fairly responsive):
> > >
> > > root@dragon:/home/juhl# uptime
> > >  22:59:58 up 12:43,  1 user,  load average: 1015.48, 715.93, 429.07
> > >
> > > but, not a single interrupt was handled by CPU1, they all went to CPU0.
> > >
> > > Do you have a good way to drive up the nr of interrupts above the
> > > treshhold for balancing?
> >
> > Is it HT? ISTR it was intelligent enough to ignore that. But you'd
> > have to look at the code to be sure.
> >
> Dual Core Athlon 64 X2 4400+
>
> --
> Jesper Juhl <jesper.juhl@gmail.com>
> Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
> Plain text mails only, please      http://www.expita.com/nomime.html
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
