Return-Path: <linux-kernel-owner+w=401wt.eu-S932924AbWLNVU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932924AbWLNVU5 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 16:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932926AbWLNVU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 16:20:57 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:40016 "EHLO atlrel7.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932924AbWLNVU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 16:20:56 -0500
X-Greylist: delayed 547 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 16:20:56 EST
Date: Thu, 14 Dec 2006 14:12:07 -0700
From: dann frazier <dannf@hp.com>
To: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
Cc: Jens Axboe <jens.axboe@oracle.com>, Steve Roemen <stever@carlislefsp.com>,
       LKML <linux-kernel@vger.kernel.org>,
       ISS StorageDev <iss_storagedev@hp.com>
Subject: Re: 2.6.19-git20 cciss: cmd f7b00000 timedout
Message-ID: <20061214211207.GM25409@krebs.dannf>
References: <20061214185112.GG5010@kernel.dk> <E717642AF17E744CA95C070CA815AE55F2DAEA@cceexc23.americas.cpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E717642AF17E744CA95C070CA815AE55F2DAEA@cceexc23.americas.cpqcorp.net>
User-Agent: mutt-ng/devel-r804 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2006 at 01:44:34PM -0600, Miller, Mike (OS Dev) wrote:
>  
> 
> > -----Original Message-----
> > From: Jens Axboe [mailto:jens.axboe@oracle.com] 
> > Sent: Thursday, December 14, 2006 12:51 PM
> > To: Steve Roemen
> > Cc: LKML; ISS StorageDev; Miller, Mike (OS Dev)
> > Subject: Re: 2.6.19-git20 cciss: cmd f7b00000 timedout
> > 
> > On Thu, Dec 14 2006, Steve Roemen wrote:
> > > -----BEGIN PGP SIGNED MESSAGE-----
> > > Hash: SHA1
> > > 
> > > All,
> > >     I tried out the 2.6.19-git20 kernel on one of my machines (HP 
> > > DL380 G3) that has the on board 5i controller (disabled),
> > > 2 smart array 642 controllers.
> > > 
> > > I get the error (cciss: cmd f7b00000 timedout) with Buffer 
> > I/O error 
> > > on device cciss/c (all cards, and disks) logical block 0, 1, 2, etc
> > 
> > I saw this on another box, but it works on the ones that I have. Does
> > 2.6.19 work? Any chance you can try and narrow down when it broke?
> 
> Jens/Steve:
> We also encountered a time out issue on the 642. This one is connected
> to an MSA500. Do either of you have MSA500? What controller fw are you
> running? Check /proc/driver/cciss/ccissN.

fyi, we've been seeing this in Debian too (which is why Mike added me
to the CC list), and I've narrowed it down to the 2TB patch that went
into 2.6.19:
  http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=402787
-- 
dann frazier | HP Open Source and Linux Organization
