Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263494AbTC2TtP>; Sat, 29 Mar 2003 14:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263495AbTC2TtP>; Sat, 29 Mar 2003 14:49:15 -0500
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:18829 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S263494AbTC2TtO>; Sat, 29 Mar 2003 14:49:14 -0500
Subject: Re: [TRIVIAL] Cleanup in fs/devpts/inode.c
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: john@grabjohn.com
Cc: =?ISO-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
       LKML <linux-kernel@vger.kernel.org>, trivial@rustcorp.com.au
In-Reply-To: <200303291829.h2TITPPi000418@81-2-122-30.bradfords.org.uk>
References: <200303291829.h2TITPPi000418@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1048968024.600.19.camel@teapot>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 29 Mar 2003 21:00:24 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-29 at 19:29, john@grabjohn.com wrote:
> > this patch un-complicates a small piece of code of the dev/pts
> > filesystem and decreases the size of the object code by 8 bytes
> > for my build. Yay! :)
> 
> > -		err = PTR_ERR(devpts_mnt);
> > -		if (!IS_ERR(devpts_mnt))
> > -			err = 0;
> > +		if (IS_ERR(devpts_mnt))
> > +			err = PTR_ERR(devpts_mnt);
> 
> Why not use
> 
> err = (IS_ERR(devpts_mnt) ? err = 0 : PTR_ERR(devpts_mnt));

Ugg! That's really ugly! ;-)

________________________________________________________________________
        Felipe Alfaro Solana
   Linux Registered User #287198
http://counter.li.org

