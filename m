Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288769AbSAELeW>; Sat, 5 Jan 2002 06:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288773AbSAELeM>; Sat, 5 Jan 2002 06:34:12 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:62470 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S288769AbSAELeB>;
	Sat, 5 Jan 2002 06:34:01 -0500
Date: Sat, 5 Jan 2002 12:33:46 +0100
From: Jens Axboe <axboe@suse.de>
To: Peter Osterlund <petero2@telia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.2-pre3] Harddisk Performance
Message-ID: <20020105123346.X8673@suse.de>
In-Reply-To: <20011229162930.GA317@elfie.cavy.de> <20011229181717.C1821@suse.de> <m2sn9m5bcv.fsf@pengo.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2sn9m5bcv.fsf@pengo.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04 2002, Peter Osterlund wrote:
> Jens Axboe <axboe@suse.de> writes:
> 
> > On Sat, Dec 29 2001, Heinz Diehl wrote:
> > >
> > > Running 2.5.2-pre3, hdparm shows up very poor harddisk performance
> > > on my system compared to 2.4.x:
> >
> > Yes I just noticed that too (someone else reported it) -- seems to be
> > due to missed merges, I'm investigating.
> 
> I have found that if the elevator says BACK_MERGE or FRONT_MERGE, but
> the request queue doesn't allow the merge, the request will be put
> last in the queue instead of next to the request where the merge would
> have been done if allowed.

Excellent spotting! Applied.

-- 
Jens Axboe

