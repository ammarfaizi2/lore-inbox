Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030229AbWAJWKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030229AbWAJWKY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 17:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932566AbWAJWKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 17:10:23 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:49598 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932561AbWAJWKX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 17:10:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mlwCHkW6+PSp5oSPDxO4BbEeY7yCowdhhDsS+FU3kpJ5ipxkMQ4ZXRR4MqlG3ipjwqpg5SbUo7gQkna07jP5Wwnz3QJ0c6UY3oCeWwY2Adt+TPHX7MRDbi2bgxqSO3MO6gmBu5ZOz06Rud/wdGA1ODalcDdvae83luYerhRHBfU=
Message-ID: <9a8748490601101410i31a8447ev2bf8fafe570fc407@mail.gmail.com>
Date: Tue, 10 Jan 2006 23:10:22 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Martin Bligh <mbligh@mbligh.org>
Subject: Re: Although CONFIG_IRQBALANCE is enabled IRQ's don't seem to be balanced very well
Cc: Josef Sipek <jsipek@fsl.cs.sunysb.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <43C42708.4020108@mbligh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9a8748490601100314u26d4a566uc41a1912e410ea46@mail.gmail.com>
	 <20060110203115.GB5479@filer.fsl.cs.sunysb.edu>
	 <43C42708.4020108@mbligh.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/06, Martin Bligh <mbligh@mbligh.org> wrote:
> Josef Sipek wrote:
> > On Tue, Jan 10, 2006 at 12:14:42PM +0100, Jesper Juhl wrote:
> >
> >>Do I need any userspace tools in addition to CONFIG_IRQBALANCE?
> >
> >
> > Last I checked, yes you do need "irqbalance" (at least that's what
> > the package is called in debian.
>
> Nope - you need the kernel option turned on OR the userspace daemon,
> not both.
>
Ok, good to know.

> If you're not generating interrupts at a high enough rate, it won't
> rotate. That's deliberate.
>

Hmm, and what would count as "a high enough rate"?

I just did a small test with thousands of  ping -f's through my NIC
while at the same time giving the disk a good workout with tons of
find's, sync's & updatedb's - that sure did drive up the number of
interrupts and my load average went sky high (amazingly the box was
still fairly responsive):

root@dragon:/home/juhl# uptime
 22:59:58 up 12:43,  1 user,  load average: 1015.48, 715.93, 429.07

but, not a single interrupt was handled by CPU1, they all went to CPU0.

Do you have a good way to drive up the nr of interrupts above the
treshhold for balancing?

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
