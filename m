Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263003AbUHJIws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263003AbUHJIws (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 04:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262837AbUHJIvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 04:51:14 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:64418 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263001AbUHJIuw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 04:50:52 -0400
Date: Tue, 10 Aug 2004 10:50:23 +0200
From: Jens Axboe <axboe@suse.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040810085023.GB11201@suse.de>
References: <200408061330.i76DU2Tm005937@burner.fokus.fraunhofer.de> <20040806151017.GG23263@suse.de> <20040810084159.GD10361@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040810084159.GD10361@merlin.emma.line.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10 2004, Matthias Andree wrote:
> Jens Axboe schrieb am 2004-08-06:
> 
> > On Fri, Aug 06 2004, Joerg Schilling wrote:
> > > Let me give you a short answer: If DMA creates so many problem on Linux,
> > > how about imlementing a generic DMA abstraction layer like Solaris does?
> > 
> > We do have that. But suddenly changing the alignment and length
> > restrictions on issuing dma to a device in the _end_ of a stable series
> > does not exactly fill me with joyful expectations. It's simply that,
> > not lack of infrastructure.
> 
> The problem has been reported again and again throughout the whole 2.4
> cycle and has grown ever more painful as devices became faster.
> 
> It's not exactly fun if everything can do 48X but your favorite OS
> (Linux 2.4) is limited to say 8X because it only does PIO in spite of
> hdparm settings and everything else.
> 
> I didn't care much because I had a SCSI writer at that time which had
> working DMA (and was also slow...) but as that turned out to become
> unreliable, I bought one of the nice Plextors and now was faced with
> the problem I couldn't use it at full speed. FreeBSD came to the
> rescue while 2.6 started to become stable through its early releases.
> 
> It's Marcelo's call to decide if he wants the DMA addressing
> requirements relaxed for 2.4.28 or if 2.4 is closed. If 2.4 is now
> bugfixes-only then this certainly qualifies after some testing. If it
> doesn't work out, it can still be disabled through the -rc versions,
> or it can be some sysctl if you fear adverse effects.

It's not going to happen for 2.4, that's pretty much given. 2.6 works
just fine, and I sure as hell don't want to risk breaking anything in
2.4 just to get a speed increase. Not at this point.

You also seem to forget that someone needs to do the actual work to make
it happen. It's not likely someone will, when they haven't already.

-- 
Jens Axboe

