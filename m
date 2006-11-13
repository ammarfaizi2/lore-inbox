Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbWKMRnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWKMRnt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 12:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbWKMRnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 12:43:49 -0500
Received: from smtp-vbr9.xs4all.nl ([194.109.24.29]:4627 "EHLO
	smtp-vbr9.xs4all.nl") by vger.kernel.org with ESMTP id S932091AbWKMRns
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 12:43:48 -0500
Date: Mon, 13 Nov 2006 18:43:41 +0100
From: thunder7@xs4all.nl
To: Neil Brown <neilb@suse.de>
Cc: Jurriaan <thunder7@xs4all.nl>, linux-kernel@vger.kernel.org
Subject: Re: trouble with mounting a 1.5 TB raid6 volume in 2.6.19-rc5-mm1
Message-ID: <20061113174341.GA3819@amd64.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
References: <20061111183835.GA3801@amd64.of.nowhere> <17751.64583.924110.954687@cse.unsw.edu.au> <17752.15962.816035.80638@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17752.15962.816035.80638@cse.unsw.edu.au>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neil Brown <neilb@suse.de>
Date: Mon, Nov 13, 2006 at 08:43:54PM +1100
> On Monday November 13, neilb@suse.de wrote:
> > 
> > Can you try reverting this patch (patch -p1 -R) ?
> > 
> 
> Yes, I'm confident that reverting that patch will fix your problem.
> I actually found a number of errors while tracking this down :-(

Oops. Do you have some kind of test-suite to run on md-devices before
releasing a patch? I didn't think my hardware was that exotic.

I had a scary moment just now, since 2.6.19-rc5-mm1 without your patch
wanted to fsck the volume, and started repairing errors which didn't
exist on disk. Luckily, it stopped before inode 64, and I was able to
fsck the volume on an earlier kernel without apparent damage.

Still, a test suite seems like a good idea. Also, getting Andrew to
either add this as a hot-fix or release -mm2 would be a good idea,
IMVHO.


> The following patch makes everything happy for me, but I'll be
> revising it and splitting it up before submitting it (Andrew: please
> don't just grab it from here :-)

It works for me. I can mount the partition, read it, create files, all
is OK.

> Thanks again for the report.

No problem - I'm glad to be able to do something back for all your (yes,
that's you, kernel developers) hard work. If this had actually corrupted
my hdtv streams collection, I would have been a trifle less
enthousiastic, of course.

Kind regards,
Jurriaan
-- 
Sir Humphrey: "It is characteristic of all committee discussions and
decisions that every member has a vivid recollection of them and that
every member's recollection of them differs violently from every other
member's recollection."
	Yes Prime Minister
Debian (Unstable) GNU/Linux 2.6.19-rc5-mm1 2x4826 bogomips load 0.48
