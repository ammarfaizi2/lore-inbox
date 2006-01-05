Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbWAEWH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbWAEWH5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 17:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbWAEWH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 17:07:57 -0500
Received: from fep01-0.kolumbus.fi ([193.229.0.41]:5464 "EHLO
	fep01-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S1751167AbWAEWHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 17:07:55 -0500
Date: Fri, 6 Jan 2006 00:09:01 +0200 (EET)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: makisara@kai.makisara.local
To: Ryan Richter <ryan@tau.solarneutrino.net>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Linus Torvalds <torvalds@osdl.org>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: Fw: crash on x86_64 - mm related?
In-Reply-To: <20060105201249.GB1795@tau.solarneutrino.net>
Message-ID: <Pine.LNX.4.63.0601052357100.8036@kai.makisara.local>
References: <Pine.LNX.4.64.0512120928110.15597@g5.osdl.org>
 <1134409531.9994.13.camel@mulgrave> <Pine.LNX.4.64.0512121007220.15597@g5.osdl.org>
 <1134411882.9994.18.camel@mulgrave> <20051215190930.GA20156@tau.solarneutrino.net>
 <1134705703.3906.1.camel@mulgrave> <20051226234238.GA28037@tau.solarneutrino.net>
 <Pine.LNX.4.63.0512271807130.4955@kai.makisara.local>
 <20060104172727.GA320@tau.solarneutrino.net> <Pine.LNX.4.63.0601042334310.5087@kai.makisara.local>
 <20060105201249.GB1795@tau.solarneutrino.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jan 2006, Ryan Richter wrote:

> On Wed, Jan 04, 2006 at 11:48:52PM +0200, Kai Makisara wrote:
> > > Here's what I got:
> 
> Another one.  I can't keep running this kernel - nearly all of our
> backup tapes are erased now.  If a drive were to fail today, we would
> lose hundreds of GB of irreplacible data.  I'm going back to 2.6.11.3
> until we have a full set of backups again.
> 
Yes, don't risk the backups. If you don't want to change the kernel, you 
can load the st module with the option try_direct_io=0. If you do this, st 
will use the driver's buffer for reading and writing and you don't see 
this problem.

If you later have an opportunity to try the patch Linus suggested, it 
might provide interesting information. However, if all goes well, the st 
driver will not be using these mapping functions in 2.6.16 any more (see 
Mike Christie's changes in "[GIT PATCH] SCSI update for 2.6.15" sent to 
linux-scsi by James Bottomley yesterday). I am not sure this fixes your 
problem but it certainly changes the code that is being debugged.

-- 
Kai
