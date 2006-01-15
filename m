Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbWAOVEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWAOVEp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 16:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750864AbWAOVEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 16:04:45 -0500
Received: from pb142.tychy.sdi.tpnet.pl ([217.96.251.142]:30349 "EHLO
	daper.net") by vger.kernel.org with ESMTP id S1750825AbWAOVEo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 16:04:44 -0500
Date: Sun, 15 Jan 2006 22:04:43 +0100
From: Damian Pietras <daper@daper.net>
To: Peter Osterlund <petero2@telia.com>
Cc: Phillip Susi <psusi@cfl.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: Problems with eject and pktcdvd
Message-ID: <20060115210443.GA6096@daper.net>
References: <20060115123546.GA21609@daper.net> <43CA8C15.8010402@cfl.rr.com> <20060115185025.GA15782@daper.net> <43CA9FC7.9000802@cfl.rr.com> <m3ek39z09f.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3ek39z09f.fsf@telia.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2006 at 09:47:40PM +0100, Peter Osterlund wrote:
> Phillip Susi <psusi@cfl.rr.com> writes:
> 
> > Damian Pietras wrote:
> > > On Sun, Jan 15, 2006 at 12:53:25PM -0500, Phillip Susi wrote:
> > > Neither Ubuntu kernel nor this patch fixes the problem.
> > >
> > 
> > You might want to try it under dapper then.  If you still have that
> > problem, then it's got to be busted hardware.  You might try updating
> > the firmware in the drive.
> 
> The irq timeout problem might be broken hardware/firmware, but there
> is a problem with drive locking and the pktcdvd driver.
> 
> If you do
> 
> 	pktsetup 0 /dev/hdc
> 	mount /dev/hdc /mnt/tmp
> 	umount /mnt/tmp
> 
> the door will be left in a locked state. (It gets unlocked when you
> run "pktsetup -d 0" though.) However, if you do:
> 
> 	pktsetup 0 /dev/hdc
> 	mount /dev/pktcdvd/0 /mnt/tmp
> 	umount /mnt/tmp

Thanks!

It works this way without any irq timeout. Unfortunately I can't use it
as a workaround, because CD-R media must be mounted with '-o ro' or I
get 'pktcdvd: Wrong disc profile (9)', so I can't just put it in fstab
and use 'mount /media/cdrom' for both CD-R and RW discs.

This is very new model and I hope they will release new firmware soon.

-- 
Damian Pietras
