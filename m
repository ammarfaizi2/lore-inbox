Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750924AbWA2L0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbWA2L0T (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 06:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750923AbWA2L0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 06:26:19 -0500
Received: from mail.gmx.de ([213.165.64.21]:43994 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750822AbWA2L0S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 06:26:18 -0500
X-Authenticated: #428038
Date: Sun, 29 Jan 2006 12:26:13 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: bzolnier@gmail.com, mrmacman_g4@mac.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, acahalan@gmail.com
Subject: Re: CD writing in future Linux try #2 [ was: Re: CD writing in future Linux (stirring up a hornets' nest) ]
Message-ID: <20060129112613.GA29356@merlin.emma.line.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	bzolnier@gmail.com, mrmacman_g4@mac.com,
	linux-kernel@vger.kernel.org, acahalan@gmail.com
References: <58cb370e0601270837h61ac2b03uee84c0fa9a92bc28@mail.gmail.com> <43DCA097.nailGPD11GI11@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43DCA097.nailGPD11GI11@burner>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling schrieb am 2006-01-29:

> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> 
> > I address this to everybody not only to Joerg:
> >
> > [*] As this is my thread now discussing SG_IO on /dev/hd* vs /dev/sg*
> > is BANNED.  Please continue discussing this in the old thread. :-)
> 
> If we also bann discussions that try to claim cdrecord -scanbus is
> unneeded or unwanted, no problem.

The real issue is that the Linux kernel support for -scanbus looks
different than your blueprints. Looks as though the most promising
approach is to tell libscg about it, as annoying though it may be.

> Well it is obvious that the numbers are present inside Linux, otherwise
> Linux could not return useful numbers in case that ide-scsi is used.
> Note that we are talking about SCSI devices (in case the actual user
> of libscg is cdrecord, we talk about CD/DVD writers).

CD/DVD writers wtih SCSI interface have nearly died out.

> If you read the Debian bug reports, you will find that many users are confused 
> because cdrecord -scanbus will not list all possible devices.

That's what I believe to be cdrecord/libscg bugs:

1) libscg or cdrecord does not automatically probe all available
   transports, but only SCSI:

2) libscg or cdrecord aborts ATA: scans as soon as one device probe
   returns EPERM, which lets devices that resmgr made accessible
   disappear from the list.

-- 
Matthias Andree
