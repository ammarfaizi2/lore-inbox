Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286712AbSAIOEi>; Wed, 9 Jan 2002 09:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286756AbSAIOEa>; Wed, 9 Jan 2002 09:04:30 -0500
Received: from mustard.heime.net ([194.234.65.222]:41420 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S286692AbSAIOEG>; Wed, 9 Jan 2002 09:04:06 -0500
Date: Wed, 9 Jan 2002 15:03:56 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Jens Axboe <axboe@suse.de>
cc: Mark Hahn <hahn@physics.mcmaster.ca>, <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] Error reading multiple large files
In-Reply-To: <20020109145952.D19814@suse.de>
Message-ID: <Pine.LNX.4.30.0201091502120.7021-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > It seemed like it helped first, but after a while, some 99 processes went
> > Defunct, and locked. After this, the total 'bi' as reported from vmstat
> > went down to ~ 900kB per sec
>
> Bad news for Andrew's patch, however I really don't think it would have
> helped you much in the first place. The problem seems to be down to
> loosing read-ahead when cache ends up eating all of available memory,
> I've seen this effect myself too. Maybe the vm needs to be more
> aggressive about tossing out pages when this happens, I'm quite sure
> that would help tremendously for this workload.

Thanks for answering. I'm really close to giving up and have already
started testing on *BSD unices.

It seems reasonable if that (tossing old pages) could be the problem.

Thanks, guys

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

