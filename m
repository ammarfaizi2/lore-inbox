Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261202AbVFABoC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbVFABoC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 21:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbVFABoC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 21:44:02 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:60058 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261202AbVFABnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 21:43:55 -0400
Date: Wed, 1 Jun 2005 03:43:54 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Bernd Eckenfels <ecki@lina.inka.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RAID-5 design bug (or misfeature)
In-Reply-To: <20050531213953.GC9614@elf.ucw.cz>
Message-ID: <Pine.LNX.4.58.0506010337050.15736@artax.karlin.mff.cuni.cz>
References: <E1DcXfR-0000zf-00@calista.eckenfels.6bone.ka-ip.net>
 <Pine.LNX.4.58.0505300440550.15088@artax.karlin.mff.cuni.cz>
 <1117454144.2685.174.camel@localhost.localdomain>
 <Pine.LNX.4.58.0505301759550.6859@artax.karlin.mff.cuni.cz>
 <20050531213953.GC9614@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 31 May 2005, Pavel Machek wrote:

> Hi!
>
> > > At that point your stripes *are*
> > > inconsistent. If it didn't mark them as failed then you wouldn't know it
> > > was corrupted after a power restore. You can then clean it fsck it,
> > > restore it,
> > > use mdadm as appropriate to restore the volume and check it.
> >
> > I can't because mdadm is on that volume ... I solved it by booting from
> > floppy and editing raid superblocks with disk hexeditor but not every user
> > wants to do it; there should be at least kernel boot parameter for
> > it.
>
> Well, you should not use hexedit... just boot from rescue cd and run
> mdadd from it. No need to pollute kernel with that one.

Hi!

I think editing superblock with hexedit is less dangerous than using
raid-tools --- with editor I know what changes I have made and I can
revert them. With raid-tools, if you create wrong /etc/raidtab (original
was on failed volume too), it will trash superblocks completely.

I still think it's stupid that Linux modifies RAID superblocks into
irreversible state.

BTW. that server doesn't have CD drive. It was installed from network.

Mikulas

> 								Pavel
>
