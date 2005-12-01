Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932431AbVLATxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbVLATxV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 14:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932429AbVLATxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 14:53:21 -0500
Received: from solarneutrino.net ([66.199.224.43]:8197 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S932427AbVLATxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 14:53:20 -0500
Date: Thu, 1 Dec 2005 14:53:12 -0500
To: Kai Makisara <Kai.Makisara@kolumbus.fi>
Cc: Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       ryan@tau.solarneutrino.net
Subject: Re: Fw: crash on x86_64 - mm related?
Message-ID: <20051201195311.GA7236@tau.solarneutrino.net>
References: <20051129092432.0f5742f0.akpm@osdl.org> <Pine.LNX.4.63.0512012040390.5777@kai.makisara.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0512012040390.5777@kai.makisara.local>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2005 at 09:18:33PM +0200, Kai Makisara wrote:
> I have installed amanda and learned to use it enough to do experiments 
> with my main system. Unfortunately I have not been able to see any oopses.

Thanks a lot for doing this!  Our backups run every other night and
usually write 15-20GB to tape, and it was 2 weeks before we hit this.
So it's not very easy to reproduce.  They ran again last night (with the
patch) without incident.

There's one more thing that might be interesting: the morning before
this crash happened, this machine mysteriously rebooted for no apparent
reason.  There was nothing in the logs.  Unfortunately, the BIOS screen
wipes out the last ~24 lines of serial console output on reboot, so all
I can say is that if anything was printed it was much less than 24
lines.  There are other machines on the same UPS so it wasn't a power
glitch.  And it had just had an uptime of 170-some days with 2.6.11.3
(which had some annoying bugs but was stable), so it's not exactly prone
to random reboots...

I didn't think it was worth mentioning since I knew nothing about what
happened, but I noticed that it happened exactly one hour after the
6:37am cron job (updatedb etc.) - the same one that caused it to crash
the next day after the oopses during the backups.  Might it be related?

Let me know if there's any more info I can provide.

-ryan
