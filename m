Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261798AbUEFOXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbUEFOXG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 10:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262438AbUEFOXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 10:23:05 -0400
Received: from piggy.rz.tu-ilmenau.de ([141.24.4.8]:55008 "EHLO
	piggy.rz.tu-ilmenau.de") by vger.kernel.org with ESMTP
	id S261798AbUEFOW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 10:22:56 -0400
Date: Thu, 6 May 2004 16:22:47 +0200
From: "Mario 'BitKoenig' Holbe" <Mario.Holbe@RZ.TU-Ilmenau.DE>
To: Henrik Persson <nix@syndicalist.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange DMA-errors and system hang with Promise 20268
Message-ID: <20040506142247.GC22719@darkside.22.kls.lan>
Mail-Followup-To: Mario 'BitKoenig' Holbe <Mario.Holbe@RZ.TU-Ilmenau.DE>,
	Henrik Persson <nix@syndicalist.net>, linux-kernel@vger.kernel.org
References: <1078602426.16591.8.camel@vega> <200405052339.i45NdXsx003369@darkside.22.kls.lan> <1083849053.6994.10.camel@vega>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1083849053.6994.10.camel@vega>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2004 at 03:10:54PM +0200, Henrik Persson wrote:
> On Thu, 2004-05-06 at 01:39, Mario 'BitKoenig' Holbe wrote:
> > just to verify things: what is your io_32bit set to?
> io_32bit                0               0               3               rw

Well, it was a chance :) However, I had io_32bit=1 but I
also had a freeze even after setting it back to 0.

> And well. I don't have any problems nowadays. Not a freeze since I sent
> that mail. Strange indeed.

I found a few things: 1st: it happens when the disk is
loaded: best way to freeze the system here is a find over
a big subtree (something around 60.000 files in lots of
directories, ext2), better some of them in parallel
and even better some find -print0 | xargs -0 cat > /dev/null.
But even there: it doesnt happen all time, the chances
just grow up.
2nd: it seems, the disk spins down short before the error
appears. At least all time when I was in front of the
machine when the problem appeared, I heard the disk spinning
down - just as if it was gone to standby mode.
But it was definitely loaded before (I hear the head seeks
and then the spindown). And no, I dont have any automated
spindown like noflushd or something like that.

CC:ing to lkm again. Probably this helps somehow.


regards,
   Mario
-- 
[mod_nessus for iauth]
<delta> "scanning your system...found depreciated OS...found
        hole...installing new OS...please reboot and reconnect now"
