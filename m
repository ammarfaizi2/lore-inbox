Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751482AbWE3Met@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbWE3Met (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 08:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbWE3Met
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 08:34:49 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:56363 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751483AbWE3Mes (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 08:34:48 -0400
Date: Tue, 30 May 2006 14:36:52 +0200
From: Jens Axboe <axboe@suse.de>
To: Mike Galbraith <efault@gmx.de>
Cc: Al Viro <viro@ftp.linux.org.uk>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-rc4-mm3 cfq oops->panic w. fs damage
Message-ID: <20060530123652.GV4199@suse.de>
References: <1148793123.7572.22.camel@homer> <20060528052514.GQ27946@ftp.linux.org.uk> <1148796018.11873.11.camel@homer> <1148802491.8083.7.camel@homer> <1148803384.8757.7.camel@homer> <1148804675.7755.2.camel@homer> <1148900440.9817.46.camel@homer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1148900440.9817.46.camel@homer>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29 2006, Mike Galbraith wrote:
> On Sun, 2006-05-28 at 10:24 +0200, Mike Galbraith wrote: 
> > On Sun, 2006-05-28 at 10:03 +0200, Mike Galbraith wrote:
> > 
> > > Yup, mm3 makes reliable kaboom.
> > > 
> > > I suppose the first thing to do is see if it's cfq, and then maybe toss
> > > a dart at the patch list.
> > 
> > That was too easy.  It's git-cfq.patch.
> 
> Too easy indeed.
> 
> After staring at these changes, and not having anything poke me in the
> eye that looked like it might cause list corruption, I decided to try
> them in a different kernel.  I put them into 2.6.16-rt25, and there they
> work peachy.  A diff of 2.6.16-rt25+git-cfq.patch->2.6.17-rc4-mm3 shows
> what I was expecting (locking changes), but it's embedded in ~1000 lines
> of diff, and doesn't look particularly trivial.
> 
> Hi Jens <punt> :)

I'm suspecting a recent -mm change, since git-cfq hasn't changed in
quite a while and it used to work just fine. Can you pass me the diff
you generated?

-- 
Jens Axboe

