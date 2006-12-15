Return-Path: <linux-kernel-owner+w=401wt.eu-S1751247AbWLOILI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbWLOILI (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 03:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbWLOILI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 03:11:08 -0500
Received: from brick.kernel.dk ([62.242.22.158]:12563 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751247AbWLOILH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 03:11:07 -0500
Date: Fri, 15 Dec 2006 09:12:33 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
Cc: "Frazier, Daniel Kent" <daniel_frazier@hp.com>,
       Steve Roemen <stever@carlislefsp.com>,
       LKML <linux-kernel@vger.kernel.org>,
       ISS StorageDev <iss_storagedev@hp.com>
Subject: Re: 2.6.19-git20 cciss: cmd f7b00000 timedout
Message-ID: <20061215081233.GU5010@kernel.dk>
References: <20061214211207.GM25409@krebs.dannf> <E717642AF17E744CA95C070CA815AE55F6F0C3@cceexc23.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E717642AF17E744CA95C070CA815AE55F6F0C3@cceexc23.americas.cpqcorp.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14 2006, Miller, Mike (OS Dev) wrote:
>  
> 
> > -----Original Message-----
> > From: Frazier, Daniel Kent 
> > Sent: Thursday, December 14, 2006 3:12 PM
> > To: Miller, Mike (OS Dev)
> > Cc: Jens Axboe; Steve Roemen; LKML; ISS StorageDev
> > Subject: Re: 2.6.19-git20 cciss: cmd f7b00000 timedout
> > 
> > On Thu, Dec 14, 2006 at 01:44:34PM -0600, Miller, Mike (OS Dev) wrote:
> > >  
> > > 
> > > > -----Original Message-----
> > > > From: Jens Axboe [mailto:jens.axboe@oracle.com]
> > > > Sent: Thursday, December 14, 2006 12:51 PM
> > > > To: Steve Roemen
> > > > Cc: LKML; ISS StorageDev; Miller, Mike (OS Dev)
> > > > Subject: Re: 2.6.19-git20 cciss: cmd f7b00000 timedout
> > > > 
> > > > On Thu, Dec 14 2006, Steve Roemen wrote:
> > > > > -----BEGIN PGP SIGNED MESSAGE-----
> > > > > Hash: SHA1
> > > > > 
> > > > > All,
> > > > >     I tried out the 2.6.19-git20 kernel on one of my 
> > machines (HP 
> > > > > DL380 G3) that has the on board 5i controller (disabled),
> > > > > 2 smart array 642 controllers.
> > > > > 
> > > > > I get the error (cciss: cmd f7b00000 timedout) with Buffer
> > > > I/O error
> > > > > on device cciss/c (all cards, and disks) logical block 0, 1, 2, 
> > > > > etc
> > > > 
> > > > I saw this on another box, but it works on the ones that I have. 
> > > > Does
> > > > 2.6.19 work? Any chance you can try and narrow down when it broke?
> > > 
> > > Jens/Steve:
> > > We also encountered a time out issue on the 642. This one 
> > is connected 
> > > to an MSA500. Do either of you have MSA500? What controller 
> > fw are you 
> > > running? Check /proc/driver/cciss/ccissN.
> > 
> > fyi, we've been seeing this in Debian too (which is why Mike 
> > added me to the CC list), and I've narrowed it down to the 
> > 2TB patch that went into 2.6.19:
> >   http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=402787
> 
> Hmmmm. Dann, did you see this on 32-bit Debian? I have this running in
> the lab on x86_64 and ia64. Someone else was _supposed_ to test ia32 for
> me. Dammit.
> 
> Jens/Steve:
> Are your os'es 32-bit?

Yep, the machine I saw this on is 32-bit. The one I tested on myself is
x86-64, and that works. It's not driving an MSA500 either, but it's a
data point for you.

-- 
Jens Axboe

