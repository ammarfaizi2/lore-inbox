Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267610AbUIGGeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267610AbUIGGeq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 02:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267628AbUIGGeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 02:34:46 -0400
Received: from web11906.mail.yahoo.com ([216.136.172.190]:35848 "HELO
	web11906.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267610AbUIGGen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 02:34:43 -0400
Message-ID: <20040907063442.3574.qmail@web11906.mail.yahoo.com>
Date: Mon, 6 Sep 2004 23:34:42 -0700 (PDT)
From: Mike Mestnik <cheako911@yahoo.com>
Subject: Re: [BUG] r200 dri driver deadlocks
To: Felix =?ISO-8859-1?Q?=20=22K=FChling=22?= <fxkuehl@gmx.de>,
       Lee Revell <rlrevell@joe-job.com>
Cc: diablod3@gmail.com, dri-devel@lists.sf.net, linux-kernel@vger.kernel.org
In-Reply-To: <20040906125115.0d49db62.felix@trabant>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Felix Kühling <fxkuehl@gmx.de> wrote:

> On Sun, 05 Sep 2004 20:14:43 -0400
> Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > On Sun, 2004-09-05 at 16:18, Patrick McFarland wrote:
> [snip]
> > > 
> > > That shouldn't matter, should it? The userland stuff should never
> lock
> > > the machine up.
> > > I'll test it anyhow, though.
> > 
> > No, it shouldn't.  Anything that directly accesses hardware belongs in
> > the kernel.  How to fix this is a pretty hot topic now.
> 
> That's not the whole truth. There are just too many ways to lock up
> those 3D chips. For instance I fixed a lockup in the r100 driver where
> the order in which state changing commands were sent to the hardware
> would cause a lockup. Each individual state changing command is
> perfectly valid. Finding all permutations that trigger a lockup would
> have been too much of a hassle and may not even have been true for all
> supported hardware out there. So we made the user-space driver emit
> state changing commands in a fixed order, which seems to work
> everywhere.
> 
Dose the DRM varify that the cmds are in this order?  Why not just have
the DRM 'sort' the cmds?  A simple bouble sort would have no more overhead
then the check for correct order, but it would fix missordered cmd
streams.

Once this is done the statement holds true, userland stuff should never...

> Regars,
>   Felix
> 
> > 
> > Lee
> > 
> 
> | Felix Kühling <fxkuehl@gmx.de>                     http://fxk.de.vu |
> | PGP Fingerprint: 6A3C 9566 5B30 DDED 73C3  B152 151C 5CC1 D888 E595 |
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by BEA Weblogic Workshop
> FREE Java Enterprise J2EE developer tools!
> Get your free copy of BEA WebLogic Workshop 8.1 today.
> http://ads.osdn.com/?ad_idP47&alloc_id808&op=click
> --
> _______________________________________________
> Dri-devel mailing list
> Dri-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/dri-devel
> 



		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - Send 10MB messages!
http://promotions.yahoo.com/new_mail 
