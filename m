Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932632AbWAJVA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932632AbWAJVA7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 16:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932629AbWAJVA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 16:00:59 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:36178 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932632AbWAJVA6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 16:00:58 -0500
Date: Tue, 10 Jan 2006 22:02:37 +0100
From: Jens Axboe <axboe@suse.de>
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Martin Bligh <mbligh@mbligh.org>, Byron Stanoszek <gandalf@winds.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2G memory split
Message-ID: <20060110210237.GL3389@suse.de>
References: <20060110132957.GA28666@elte.hu> <20060110133728.GB3389@suse.de> <Pine.LNX.4.63.0601100840400.9511@winds.org> <20060110143931.GM3389@suse.de> <Pine.LNX.4.64.0601100804380.4939@g5.osdl.org> <43C3F986.4090209@mbligh.org> <Pine.LNX.4.64.0601101028360.4939@g5.osdl.org> <43C3E74D.7060309@wolfmountaingroup.com> <1136926519.14532.46.camel@localhost.localdomain> <43C40738.4070600@wolfmountaingroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C40738.4070600@wolfmountaingroup.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10 2006, Jeff V. Merkey wrote:
> Alan Cox wrote:
> 
> >On Maw, 2006-01-10 at 09:56 -0700, Jeff V. Merkey wrote:
> > 
> >
> >>RH ES uses 4:4 which is ideal and superior to this hack.
> >>   
> >>
> >
> >Its a non trivial trade-off. 4/4 lets you run very large physical memory
> >systems much more efficiently than usual but you pay a cost on syscalls
> >and some other events when using the majority of processors. The 4/4
> >tricks also give most emulations (eg Qemu) serious heartburn trying to
> >emulate %cr3 reloading via mmap and other interfaces with high overhead
> >in relative terms.
> >
> >Of course AMD64 kind of shot the problem in the head once and for all.
> >
> > 
> >
> 
> Yep, they sure did.  Seriously, the 4:4 option should also be present 
> along with 3:1 and 2:2
> splits.  You should merge your RH work into this patch and allow both.  
> It would save me one less
> patch to maintain off the tree.

You can't compare the two patches, saying that 4:4 should go in because
configurable page offsets is merged is nonsense.

Note that I'm not advocating against 4:4 as such, I have no real
oppinion on that. It has its uses for sure, while it comes with a cost
for others.

-- 
Jens Axboe

