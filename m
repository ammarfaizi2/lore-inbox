Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267846AbTBKNtZ>; Tue, 11 Feb 2003 08:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267853AbTBKNtZ>; Tue, 11 Feb 2003 08:49:25 -0500
Received: from poup.poupinou.org ([195.101.94.96]:57123 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP
	id <S267846AbTBKNtZ>; Tue, 11 Feb 2003 08:49:25 -0500
Date: Tue, 11 Feb 2003 14:59:10 +0100
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.60] swsuspend -> BUG at drivers/ide/ide-disk.c:1557
Message-ID: <20030211135910.GB25632@poup.poupinou.org>
References: <20030211131151.GA1262@k3.hellgate.ch> <20030211132132.GA20750@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030211132132.GA20750@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.4i
From: Ducrot Bruno <poup@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2003 at 02:21:32PM +0100, Pavel Machek wrote:
> 
> 
> > Is software suspend in Vanilla 2.5.60 supposed to work? A modified shutdown
> > (using the reboot(2) magic) triggers the BUG_ON in idedisk_suspend. A quick
> > check with older 2.5.x indicates this problem has been around for a
> > while.
> 
> 
> It works for me in 2.5.59. I'm now downloading 2.5.60.
> 
> Replacing 
> 
> BUG_ON (HWGROUP(drive)->handler);
> 
> with
> 
> while(HWGROUP(drive)->handler);
> 
> 
> might do the trick, but also might corrupt the data badly.

IMHO s/might/will/g

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page
