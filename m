Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266132AbUALMoL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 07:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266141AbUALMoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 07:44:11 -0500
Received: from [212.239.225.130] ([212.239.225.130]:641 "EHLO
	precious.kicks-ass.org") by vger.kernel.org with ESMTP
	id S266132AbUALMoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 07:44:04 -0500
From: Jan De Luyck <lkml@kcore.org>
To: Bart Samwel <bart@samwel.tk>
Subject: Re: [PATCH] Laptop-mode v7 for linux 2.6.1
Date: Mon, 12 Jan 2004 13:43:34 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, Dax Kelson <dax@gurulabs.com>,
       Kiko Piris <kernel@pirispons.net>, Bartek Kania <mrbk@gnarf.org>,
       Simon Mackinlay <smackinlay@mail.com>
References: <3FFFD61C.7070706@samwel.tk> <200401121212.44902.lkml@kcore.org> <4002836A.8050908@samwel.tk>
In-Reply-To: <4002836A.8050908@samwel.tk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401121343.34688.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 January 2004 12:22, Bart Samwel wrote:(
> Jan De Luyck wrote:
> > Patch applied, kernel built, laptop_mode activated, but my disk just
> > doesn't want to spin down...
>
> [...]
>
> > But the disk never spins down. Not that I can tell, hdparm -C /dev/hda
> > always tells me active/idle, and the sdsl tool also reports 100% disk
> > spinning...
> >
> > anything else I have to activate/check?
>
> Two things to try:
>
> 1. Check your HD with hdparm -I /dev/hdX, and see what it says at the
> "Standby timer values:" entry. Mine says:
>
> Standby timer values: spec'd by Standard, with device specific minimum

Mine gives:

Standby timer values: spec'd by Vendor, no device specific minimum

(is an HITACHI_DK23EA-40)

> smart_spindown script instead (I posted this a while ago, with one of
> the laptop_mode patches).

Will do.

> 2. Stop klogd, do "echo 1 > /proc/sys/vm/block_dump" and see which
> process keeps your disk spun up using dmesg.

Welll.... i see no READs, and the writes i see is spamd, kmail, pdflush, 
reiserfs/0.

Jan
-- 
The only possible interpretation of any research whatever in the `social
sciences' is: some do, some don't.
		-- Ernest Rutherford

