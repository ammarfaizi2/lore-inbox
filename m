Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317211AbSGCQtO>; Wed, 3 Jul 2002 12:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317194AbSGCQtJ>; Wed, 3 Jul 2002 12:49:09 -0400
Received: from mail.clsp.jhu.edu ([128.220.34.27]:53469 "EHLO
	mail.clsp.jhu.edu") by vger.kernel.org with ESMTP
	id <S317184AbSGCQru>; Wed, 3 Jul 2002 12:47:50 -0400
Date: Wed, 3 Jul 2002 05:04:00 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Andrew Morton <akpm@zip.com.au>, Miles Lane <miles@megapathdsl.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Automatically mount or remount EXT3 partitions with EXT2 when alaptop is powered by a battery?
Message-ID: <20020703030400.GB474@elf.ucw.cz>
References: <1024948946.30229.19.camel@turbulence.megapathdsl.net> <3D18A273.284F8EDD@zip.com.au> <20020626011340.A13410@redhat.com> <3D1A0A63.BB5F0C33@zip.com.au> <20020702142331.D2877@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020702142331.D2877@redhat.com>
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Yes, that would be better.  We do want to be able to change it
> > on the fly.  So how about:
> > 
> > 	mount /dev/what /mnt/where -o commit_interval=5
> > and
> > 	mount /mnt/where -o remount,commit_interval=3000
> 
> I just implemented that on the way back from OLS, will check it in
> shortly.

Nice... with -o remount possibility it might be even usefull for
noflushd.

Hmm....

Does mount /dev/hda1 -o remount,commit_interval=3000 work? If no we'll
have some ugly parsing of /proc/mounts to be added into noflushd...
									Pavel

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
