Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316081AbSEJUsD>; Fri, 10 May 2002 16:48:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316090AbSEJUsC>; Fri, 10 May 2002 16:48:02 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:58559 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S316081AbSEJUsC>; Fri, 10 May 2002 16:48:02 -0400
Date: Fri, 10 May 2002 22:47:58 +0200
From: Jan Hudec <bulb@ucw.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: kill task in TASK_UNINTERRUPTIBLE
Message-ID: <20020510204758.GA19106@artax.karlin.mff.cuni.cz>
Mail-Followup-To: Jan Hudec <bulb@ucw.cz>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3CD9B44F.4A023A70@mvista.com> <Pine.LNX.4.21.0205090140240.32715-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2002 at 01:49:35AM +0200, Roman Zippel wrote:
> > > Except for processes accessing NFS files while the NFS server is down:
> > > they will be stuck in TASK_UNINTERRUPTIBLE until the NFS server comes
> > > back up again.
> > 
> > A REALLY good argument for puting timeouts on your NSF mounts!  Don't
> > leave home without them.
> 
> Use "mount -o intr" and you can kill the process.

Could someone please explain to me how this works? IIRC NFS uses
generic_file_read as most other filesystems. And whe WaitOnPage in there
sleeps in uninterruptible state. I was told, that though it would be
easy to change here, it's almost impossible in page-fault, because
trying to handle a signal might trigger the very same page-fault again.

--------------------------------------------------------------------------------
                  				- Jan Hudec `Bulb' <bulb@ucw.cz>
