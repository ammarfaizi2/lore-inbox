Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266358AbUHIIuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266358AbUHIIuU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 04:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266359AbUHIIuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 04:50:19 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:60346 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266358AbUHIItp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 04:49:45 -0400
Date: Mon, 9 Aug 2004 10:49:17 +0200
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Zinx Verituse <zinx@epicsol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide-cd problems
Message-ID: <20040809084916.GR10418@suse.de>
References: <20040731182741.GA21845@bliss> <20040731200036.GM23697@suse.de> <20040731210257.GA22560@bliss> <20040805054056.GC10376@suse.de> <1091739966.8418.38.camel@localhost.localdomain> <20040806054424.GB10274@suse.de> <20040806062331.GE10274@suse.de> <1091794470.16306.11.camel@localhost.localdomain> <20040806143258.GB23263@suse.de> <1091887718.18407.51.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091887718.18407.51.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 07 2004, Alan Cox wrote:
> On Gwe, 2004-08-06 at 15:32, Jens Axboe wrote:
> > That's the case I don't agree with, and why I didn't like the idea
> > originally. That suddenly requires a patching of the kernel because of
> > new commands in new devices. Like when dvd readers became common, you
> > can't just require people to update their kernel because a few new
> > commands are needed to drive them from user space.
> 
> I'm stunning we are even having this argument. You are talking about
> what appes to be a hardware destruction enabling security level bug in
> the 2.6 kernel and arguing about whether it is a feature or not.

Alan, stop putting words into my mouth. I'm not saying it's a feature.

> In essence you are saying read access to any raw device node entitles
> the opener of the file to destroy the attached device (device even not
> just media). You are arguing that its ok that I can use raw scsi I/O to
> subvert the read/write permissions too.

In essence, yes. I'm arguing that it's not easily doable to
differentiate between destructive and non-destructive commands. And that
doing so requires extensive tables because commands are not the same
across devices.

I'm not saying that I think it's a good thing! Or a feature, for that
matter. I'm just arguing the feasibility of doing it, the maintenance
involved, etc.

> In the example code I gave
> 
> >               default:
> >                       if(capable(CAP_SYS_RAWIO))
> >                       /* Only administrators get to do arbitary things
> */
> > 
> 
> means there is no need to recompile anything, you just need priviledges
> to do stuff the kernel doesn't *know* is safe. This is the correct
> behaviour for people who don't live in cloud cuckoo land.

I'm well aware of the implications. The argument is only whether it's ok
to policy filter unknown commands. I guess with capability elevating the
app until the kernels are modified it would be ok, at least it enables
the apps to work for root.

-- 
Jens Axboe

