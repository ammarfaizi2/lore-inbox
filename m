Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265727AbTAHKrm>; Wed, 8 Jan 2003 05:47:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266038AbTAHKrm>; Wed, 8 Jan 2003 05:47:42 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:16397 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S265727AbTAHKrl>; Wed, 8 Jan 2003 05:47:41 -0500
Date: Wed, 8 Jan 2003 11:56:21 +0100
From: Jan Kara <jack@suse.cz>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.54 - quota support
Message-ID: <20030108105621.GC16556@atrey.karlin.mff.cuni.cz>
References: <20030106003801.GA522@mail.muni.cz> <3E18E2F0.1F6A47D0@digeo.com> <20030106103656.GA508@mail.muni.cz> <20030106144842.GD24714@atrey.karlin.mff.cuni.cz> <20030106151908.GA640@mail.muni.cz> <20030107164028.GC6719@atrey.karlin.mff.cuni.cz> <20030108012133.GA725@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030108012133.GA725@mail.muni.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Jan 07, 2003 at 05:40:28PM +0100, Jan Kara wrote:
> >   Reporting 'No such device' was actually bug which was introduced some
> > time ago but nobody probably noticed it... It was introduce when quota
> > code was converted from device numbers to 'bdev' structures.
> >   I also fixed one bug in quotaon() call however I'm not sure wheter it
> > could cause the freeze. Anyway patch is attached, try it and tell me
> > about the changes.
> 
> Hmm, quotaon / with init=/bin/sh seems to work OK, quota accounting is made and
> repquota displays normal info.
  OK, so one bug fixed.

> However with normal startup quotaon / still freezes :-(
  :( So I'll search for more bugs...

> Btw, does anyone know why mount is failing for so long time while using with
> automount? Process mount is in uninterruptible sleep for more than 10 secs until
> reports no disc in cdrom. (the same for my usb camera when autofs try to mount
> it while it is not connected).


									Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
