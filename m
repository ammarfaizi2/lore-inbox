Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265840AbUGDX2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265840AbUGDX2d (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 19:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265841AbUGDX2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 19:28:33 -0400
Received: from send.it.helsinki.fi ([128.214.205.133]:391 "EHLO
	send.it.helsinki.fi") by vger.kernel.org with ESMTP id S265840AbUGDX2Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 19:28:24 -0400
Date: Mon, 5 Jul 2004 02:28:15 +0300 (EEST)
From: Mikael Johansson <mpjohans@pcu.helsinki.fi>
X-X-Sender: mpjohans@soul.it.helsinki.fi
To: Martin Knoblauch <knobi@knobisoft.de>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: RAID-0 read perf. decrease after 2.4.20
In-Reply-To: <20031218143741.25747.qmail@web13908.mail.yahoo.com>
Message-ID: <Pine.OSF.4.58.0407050216150.208397@soul.it.helsinki.fi>
References: <20031218143741.25747.qmail@web13908.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello again!

Finally had time to test this on IDE, "better late than even later"...

On Thu, 18 Dec 2003, Martin Knoblauch wrote:

> > >  Just some feedback:
> > >
> > > echo 511 > /proc/sys/vm/max-readahead
> > >
> > >  brings back the read performance of my 30 disks on 4 controller
> > > LVM/RAID0.
> >
> > Great.
> >
>
>  Indeed :-) Just to clarify - the modification of max-readahead was
> sufficient to "fix" the observed read performance degradation. I did
> not apply (or reverse) anything on top of 2.4.22.
>
>  Actually 255 would have been sufficient, 511 proved to be a small bit
> better :-))

The "max-readahead" does not seem to affect IDE-RAID, at least not with
the 2.4.27-pre6 I just compiled on two machines. So the problem still
exists, read speed on 2.4.20-ac2 is almost twice as fast as on later
kernels :-/

Have a nice summer,
    Mikael J.
    http://www.helsinki.fi/~mpjohans/
