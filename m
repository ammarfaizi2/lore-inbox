Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbWAEVZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbWAEVZU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 16:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbWAEVZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 16:25:20 -0500
Received: from soundwarez.org ([217.160.171.123]:4327 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S932222AbWAEVZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 16:25:19 -0500
Date: Thu, 5 Jan 2006 22:25:11 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: Marko Kohtala <marko.kohtala@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Jason Dravet <dravet@hotmail.com>,
       greg@kroah.com, device@lanana.org, linux-kernel@vger.kernel.org,
       linux-parport@lists.infradead.org
Subject: Re: [RFC]: add sysfs support to parport_pc, v3
Message-ID: <20060105212511.GA1547@vrfy.org>
References: <20060104010841.GA19541@kroah.com> <BAY103-F400667AF1AF50590C4990CDF2F0@phx.gbl> <20060104143157.357f9830.akpm@osdl.org> <9cfa10eb0601050817u56b007dbj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cfa10eb0601050817u56b007dbj@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 06:17:51PM +0200, Marko Kohtala wrote:
> 2006/1/5, Andrew Morton <akpm@osdl.org>:
> > "Jason Dravet" <dravet@hotmail.com> wrote:
> > > >From: Greg KH <greg@kroah.com>
> > > > > + * Added sysfs and udev - Jason Dravet <dravet@hotmail.com>
> > > > >  */
> >
> > 6 is OK - it's LP_MAJOR.
> >
> > However 99 is JSFD_MAJOR, used by drivers/sbus/char/jsflash.c.  And yet my
> > /dev/parport0 is also 99:0 (RH 7.3 and RH FC1).  I've no idea how that came
> > about??
> >
> > bix:/home/akpm> grep parport /etc/makedev.d/*
> > /etc/makedev.d/generic:a generic parport
> > /etc/makedev.d/linux-2.4.x:c $PRINTER              99   0  1   8 parport%d
> 
> JSFD is a block device so tha majors are ok. I'm not just sure if the
> PP_MAJOR from linux/ppdev.h should be moved to major.h.
> 
> The patch by Jason however is not ok. He had another problem and this
> is not the fix. What he tries to do is already in lp and ppdev, where
> I think they belong.

Yeah, I was wondering about it too.

> There is also something weird: why does RedHat create these nodes in
> /dev when udev already does that.

Probably cause they want to be safe if nothing from their sysconfig loads
the module. Opening the node will autoload it then.

Kay
