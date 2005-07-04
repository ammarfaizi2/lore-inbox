Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261661AbVGDUsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbVGDUsF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 16:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261666AbVGDUsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 16:48:05 -0400
Received: from nproxy.gmail.com ([64.233.182.207]:3143 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261661AbVGDUrn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 16:47:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QB/erSysmJhWWqyRltDRhgyhbX/w2WZQuZOsM1mej1FcQfStFGPE4UDnpkQ+xD86B+FcEtDepBNWk3bJniYM1KdCk1uIFhsCHltrRY7xK5NpiwpHl+XnLSmC2Xk6g5UBGK73eTW3txk+yIYy2PSuPsz+51OYFCtNRrVurVnIhpI=
Message-ID: <58cb370e05070413472629dd58@mail.gmail.com>
Date: Mon, 4 Jul 2005 22:47:39 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Al Boldi <a1426z@gawab.com>
Subject: Re: [git patches] IDE update
Cc: Ondrej Zary <linux@rainbow-software.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <200507042033.XAA19724@raad.intranet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <58cb370e0507041251dd5a@mail.gmail.com>
	 <200507042033.XAA19724@raad.intranet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/05, Al Boldi <a1426z@gawab.com> wrote:
> Bartlomiej Zolnierkiewicz wrote: {
> > >
> > >>On 7/4/05, Al Boldi <a1426z@gawab.com> wrote:
> > >>Hdparm -tT gives 38mb/s in 2.4.31
> > >>Cat /dev/hda > /dev/null gives 2% user 33% sys 65% idle
> > >>
> > >>Hdparm -tT gives 28mb/s in 2.6.12
> > >>Cat /dev/hda > /dev/null gives 2% user 25% sys 0% idle 73% IOWAIT
> > >>
> > >>It feels like DMA is not being applied properly in 2.6.12.
> > >
> > > Same on 2.6.10,11,12.
> > > No errors though, only sluggish system.
> 
> What about earlier kernels?
> Please try to narrow down the problem to a specific kernel version.
> }
> 
> Don't know about 2.6.0-2.6.9, but 2.4.31 is ok.

2.4 -> 2.6 means zillions of changes.
 
> Bartlomiej,
> When you compare 2.4.31 with 2.6.12 don't you see this problem on your
> machine?

Unfortunately I've never encountered this problem on any machine.

> If you have a fast system the slowdown won't show, but your IOWAIT will be
> higher anyway!

AFAIK high iowait is a known block layer problem

> It feels like running on PIO instead of DMA.
