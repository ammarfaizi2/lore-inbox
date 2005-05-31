Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261584AbVEaVlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbVEaVlY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 17:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbVEaVlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 17:41:23 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:30848 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261604AbVEaVkK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 17:40:10 -0400
Date: Tue, 31 May 2005 23:39:53 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Bernd Eckenfels <ecki@lina.inka.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RAID-5 design bug (or misfeature)
Message-ID: <20050531213953.GC9614@elf.ucw.cz>
References: <E1DcXfR-0000zf-00@calista.eckenfels.6bone.ka-ip.net> <Pine.LNX.4.58.0505300440550.15088@artax.karlin.mff.cuni.cz> <1117454144.2685.174.camel@localhost.localdomain> <Pine.LNX.4.58.0505301759550.6859@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505301759550.6859@artax.karlin.mff.cuni.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > At that point your stripes *are*
> > inconsistent. If it didn't mark them as failed then you wouldn't know it
> > was corrupted after a power restore. You can then clean it fsck it,
> > restore it,
> > use mdadm as appropriate to restore the volume and check it.
> 
> I can't because mdadm is on that volume ... I solved it by booting from
> floppy and editing raid superblocks with disk hexeditor but not every user
> wants to do it; there should be at least kernel boot parameter for
> it.

Well, you should not use hexedit... just boot from rescue cd and run
mdadd from it. No need to pollute kernel with that one.

								Pavel
