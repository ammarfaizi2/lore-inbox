Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316567AbSE3KaM>; Thu, 30 May 2002 06:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316568AbSE3KaL>; Thu, 30 May 2002 06:30:11 -0400
Received: from [62.70.58.70] ([62.70.58.70]:26305 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S316567AbSE3KaK> convert rfc822-to-8bit;
	Thu, 30 May 2002 06:30:10 -0400
Message-Id: <200205301029.g4UATuE03249@mail.pronto.tv>
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: Pronto TV AS
To: Andrew Morton <akpm@zip.com.au>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: Re: [BUG] 2.4 VM sucks. Again
Date: Thu, 30 May 2002 12:29:55 +0200
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200205241004.g4OA4Ul28364@mail.pronto.tv> <1572079531.1022225730@[10.10.2.3]> <3CEE954F.9CB99816@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I don't think Andrew is ready to submit this yet ... before anything
> > gets merged back, it'd be very worthwhile testing the relative
> > performance of both solutions ... the more testers we have the
> > better ;-)
>
> Cripes no.  It's pretty experimental.  Andrea spotted a bug, too.  Fixed
> version is below.

Works great! This should _definetely_ be merged into the main kernel after 
som testing. Without it _all_ other kernels I've tested (2.4.lots) goes OOM 
under the mentioned scenarios. This one simply does the job.

> It's possible that keeping the number of buffers as low as possible
> will give improved performance over Andrea's approach because it
> leaves more ZONE_NORMAL for other things.  It's also possible that
> it'll give worse performance because more get_block's need to be
> done for file overwriting.

Andrea's patch merely pushed the problem forward. This one fixed it
-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.
