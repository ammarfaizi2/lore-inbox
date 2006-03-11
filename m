Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932423AbWCKEfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbWCKEfE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 23:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbWCKEfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 23:35:04 -0500
Received: from mail26.syd.optusnet.com.au ([211.29.133.167]:32669 "EHLO
	mail26.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932423AbWCKEfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 23:35:02 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [PATCH] mm: Implement swap prefetching tweaks
Date: Sat, 11 Mar 2006 15:34:52 +1100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ck@vds.kolivas.org
References: <200603102054.20077.kernel@kolivas.org> <200603111518.46474.kernel@kolivas.org> <441251DD.8080704@bigpond.net.au>
In-Reply-To: <441251DD.8080704@bigpond.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603111534.53220.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 11 March 2006 15:28, Peter Williams wrote:
> Con Kolivas wrote:
> > Because despite what anyone seems to want to believe, reading from disk
> > hurts. Why it hurts so much I'm not really sure, but it's not a SCSI vs
> > IDE with or without DMA issue. It's not about tweaking parameters. It
> > doesn't seem to be only about cpu cycles. This is not a mistuned system
> > that it happens on. It just plain hurts if we do lots of disk i/o,
> > perhaps it's saturating the bus or something. Whatever it is, as much as
> > I'd _like_ swap prefetch to just keep working quietly at ultra ultra low
> > priority, the disk reads that swap prefetch does are not innocuous so I
> > really do want them to only be done when nothing else wants cpu.

I didn't make it clear here the things affected are not even doing any I/O of 
their own. It's not about I/O resource allocation. However they are using 
100% cpu and probably doing a lot of gpu bus traffic.

> Would you like to try a prototype version of the soft caps patch I'm
> working on to see if it will help?

What happens if it's using .01% cpu and spends most of its time in 
uninterruptible sleep?

Cheers,
Con
