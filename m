Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267303AbUH0TCH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267303AbUH0TCH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 15:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267287AbUH0TCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 15:02:07 -0400
Received: from daq3.if.pw.edu.pl ([194.29.174.23]:18561 "HELO milosz.na.pl")
	by vger.kernel.org with SMTP id S267375AbUH0S7o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 14:59:44 -0400
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Reply-To: bzolnier@milosz.na.pl
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH] Configure IDE probe delays
Date: Fri, 27 Aug 2004 20:59:51 +0200
User-Agent: KMail/1.6.2
Cc: Greg Stark <gsstark@mit.edu>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Todd Poynor <tpoynor@mvista.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       tim.bird@am.sony.com, dsingleton@mvista.com
References: <20040730191100.GA22201@slurryseal.ddns.mvista.com> <200408272005.08407.bzolnier@elka.pw.edu.pl> <1093630121.837.39.camel@krustophenia.net>
In-Reply-To: <1093630121.837.39.camel@krustophenia.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200408272059.51779.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 August 2004 20:08, Lee Revell wrote:
> On Fri, 2004-08-27 at 14:05, Bartlomiej Zolnierkiewicz wrote:
> > On Friday 27 August 2004 19:53, Lee Revell wrote:
> > > On Fri, 2004-08-27 at 13:45, Greg Stark wrote:
> > > > Lee Revell <rlrevell@joe-job.com> writes:
> > > > > I wonder if 83 probes are really necessary.  Maybe this could be
> > > > > optimized a bit.
> > > >
> > > > Or if the kernel could be doing something useful during that time. I
> > > > don't suppose it's possible to probe two different ide interfaces at
> > > > the same time, is it?
> > >
> > > Did the patch to move this into a #define ever get merged?  Seems like
> > > a no brainer, as it eliminates a magic number.
> >
> > No and it won't because it is not a 'magic number' but rather a 'random
> > number' (see Alan's mail for explanation).
>
> OK, sorry.  Missed that one the first time.
>
> > BTW Lee, 48-bit addressing doesn't mean that capacity > 137GB

Contrary is true of course:
if capacity > 137 GB then disk supports 48-bit addressing.

> What determines whether 48 bit addressing will be used then?

Availability of 48-bit addressing feature set and host capabilities
(some don't support LBA48 when DMA is used etc.).
