Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316843AbSE3T3r>; Thu, 30 May 2002 15:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316844AbSE3T3q>; Thu, 30 May 2002 15:29:46 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10758 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316843AbSE3T3p>;
	Thu, 30 May 2002 15:29:45 -0400
Message-ID: <3CF67D5F.3398C893@zip.com.au>
Date: Thu, 30 May 2002 12:28:31 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
CC: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.4 VM sucks. Again
In-Reply-To: <200205241004.g4OA4Ul28364@mail.pronto.tv> <1572079531.1022225730@[10.10.2.3]> <3CEE954F.9CB99816@zip.com.au> <200205301029.g4UATuE03249@mail.pronto.tv>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roy Sigurd Karlsbakk wrote:
> 
> > > I don't think Andrew is ready to submit this yet ... before anything
> > > gets merged back, it'd be very worthwhile testing the relative
> > > performance of both solutions ... the more testers we have the
> > > better ;-)
> >
> > Cripes no.  It's pretty experimental.  Andrea spotted a bug, too.  Fixed
> > version is below.
> 
> Works great! This should _definetely_ be merged into the main kernel after
> som testing. Without it _all_ other kernels I've tested (2.4.lots) goes OOM
> under the mentioned scenarios. This one simply does the job.

I suspect nuke-buffers is simply always the right thing to do.  It's
what 2.5 is doing now (effectively).  We'll see...

But in your case, you only have a couple of gigs of memory, iirc.
You shouldn't be running into catastrophic buffer_head congestion.
Something odd is happening.

If you can provide a really detailed set of steps which can be
used by others to reproduce this, that would really help.

-
