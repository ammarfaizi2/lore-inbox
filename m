Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268091AbUHFPOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268091AbUHFPOh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 11:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265784AbUHFPOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 11:14:36 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:55758 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S268085AbUHFPNc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 11:13:32 -0400
Date: Fri, 6 Aug 2004 17:13:10 +0200
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Zinx Verituse <zinx@epicsol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide-cd problems
Message-ID: <20040806151309.GH23263@suse.de>
References: <20040731182741.GA21845@bliss> <20040731200036.GM23697@suse.de> <20040731210257.GA22560@bliss> <20040805054056.GC10376@suse.de> <1091739966.8418.38.camel@localhost.localdomain> <20040806054424.GB10274@suse.de> <20040806062331.GE10274@suse.de> <1091794470.16306.11.camel@localhost.localdomain> <20040806143258.GB23263@suse.de> <20040806151455.GE29393@discworld.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040806151455.GE29393@discworld.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06 2004, Charles Cazabon wrote:
> Jens Axboe <axboe@suse.de> wrote:
> > On Fri, Aug 06 2004, Alan Cox wrote:
> > > 		default:
> > > 			if(capable(CAP_SYS_RAWIO))
> > > 			/* Only administrators get to do arbitary things */
> > 
> > That's the case I don't agree with, and why I didn't like the idea
> > originally. That suddenly requires a patching of the kernel because of
> > new commands in new devices. Like when dvd readers became common, you
> > can't just require people to update their kernel because a few new
> > commands are needed to drive them from user space.
> 
> The problem is that what if one of the new commands is IGNITE_PLATTER?
> Unknown commands can do anything, are therefore extremely dangerous,
> and should be restricted.

Well yes, that's exactly why there is a discussion. As I have written
before, filtering cannot be perfect exactly because of this. Either you
leave unknown commands unfiltered (and risk a problem with new commands
until you update your kernels), or you add the _policy_ to filter
unknown commands and risk not working with new devices for no good
reason.

And if you really want to try and cover everything, you want to add
filtering tables per _device_. Which is basically impossible to do, and
is completely unmaintainable.

But I've already stated that before.

-- 
Jens Axboe

