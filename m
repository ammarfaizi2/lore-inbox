Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267806AbTBKNLr>; Tue, 11 Feb 2003 08:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267807AbTBKNLr>; Tue, 11 Feb 2003 08:11:47 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:64525 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S267806AbTBKNLq>; Tue, 11 Feb 2003 08:11:46 -0500
Date: Tue, 11 Feb 2003 14:21:32 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [2.5.60] swsuspend -> BUG at drivers/ide/ide-disk.c:1557
Message-ID: <20030211132132.GA20750@atrey.karlin.mff.cuni.cz>
References: <20030211131151.GA1262@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030211131151.GA1262@k3.hellgate.ch>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> Is software suspend in Vanilla 2.5.60 supposed to work? A modified shutdown
> (using the reboot(2) magic) triggers the BUG_ON in idedisk_suspend. A quick
> check with older 2.5.x indicates this problem has been around for a
> while.


It works for me in 2.5.59. I'm now downloading 2.5.60.

Replacing 

BUG_ON (HWGROUP(drive)->handler);

with

while(HWGROUP(drive)->handler);


might do the trick, but also might corrupt the data badly.

> I can provide additional information incl. call trace if anyone's
> interested.
> 
> Roger

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
