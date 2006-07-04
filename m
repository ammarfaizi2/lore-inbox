Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbWGDM4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbWGDM4h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 08:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbWGDM4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 08:56:37 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:51861 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1750818AbWGDM4h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 08:56:37 -0400
Date: Tue, 4 Jul 2006 14:52:27 +0200
To: Valdis.Kletnieks@vt.edu
Cc: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: ext4 features
Message-ID: <20060704125227.GC11458@aitel.hist.no>
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de> <20060701170729.GB8763@irc.pl> <20060701174716.GC24570@cip.informatik.uni-erlangen.de> <20060701181702.GC8763@irc.pl> <20060703202219.GA9707@aitel.hist.no> <44A98D5A.5030508@tmr.com> <200607032150.k63LoM4H027543@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607032150.k63LoM4H027543@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.11+cvs20060403
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2006 at 05:50:22PM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Mon, 03 Jul 2006 17:34:18 EDT, Bill Davidsen said:
> > I think he is talking about another problem. RAID addresses detectable
> > failures at the hardware level. I believe that he wants validation after
> > the data is returned (without error) from the device. While in most
> > cases if what you wrote and what you read don't match it's memory,
> > improving the chances of catching the error is useful, given that
> > non-server often lacks ECC on memory, or people buy cheaper non-parity
> > memory.
> 
> There's other issues as well.  Why do people run 'tripwire' on boxes that
> have RAID on them?

To notice hacking.  RAID protects against hardware failure, it does
_not_ protect against any change that comes through the normal
filesystem channels.  RAID doesn't help the slightest against
viruses and hackers.  RAID is _not_ a backup, when a hacker
(or a user error) changes an important file, it is changed
in all mirrors of a raid-1 set, and raid-5 checksums are updated
so the change becomes valid.  But tripwire will notice that
a protected file changed.

Helge Hafting
