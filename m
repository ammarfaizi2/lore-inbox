Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030259AbVLSEoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030259AbVLSEoF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 23:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030263AbVLSEoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 23:44:05 -0500
Received: from nessie.weebeastie.net ([220.233.7.36]:785 "EHLO
	bunyip.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S1030259AbVLSEoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 23:44:04 -0500
Date: Mon, 19 Dec 2005 15:43:15 +1100
From: CaT <cat@zip.com.au>
To: Neil Brown <neilb@suse.de>
Cc: linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: anticipatory scheduler and raid rebuild
Message-ID: <20051219044315.GJ4212@zip.com.au>
References: <20051213052329.GM4212@zip.com.au> <17317.62101.886020.592277@cse.unsw.edu.au> <20051219011800.GI4212@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051219011800.GI4212@zip.com.au>
Organisation: Furball Inc.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On this part of it:

On Mon, Dec 19, 2005 at 12:18:00PM +1100, CaT wrote:
> I'm going to see if the same thing happens rsyncing from the 80GB Maxtor to
> the 160GB seagate. I'll also probably upgrade the kernel (it IS rather

I did a cp instead. 

Maxtor -> Seagate: manageable load (2min on/2min off)
USB -> Seagate: looks ok for about 15-30seconds and load starts
   climbing. I stopped the cp at approx 50 and it kept on climbing until
   it hit 93 and then started backing off. It's been maybe 5 minutes and
   the server still has not recovered though the load is still dropping
   (I can tell it has not recovered yet as the queue keeps on climbing -
   in the m->s side of things the queue begins dropping off almost
   immediately) - reads from disks are slow (10 seconds to read an 88
   entry die with ls -la and possible longer to write a 1k text file
   that was just opened). About 4-5 minuts later still the queue finally
   starts to drop.
Maxtor -> USB: just fine.

Not sure if this is of interested. The kernel may well be too old to
make it so. It may be that not even the io scheduler is at issue but the
behaviour looks so similar to that of the raid rebuild behaviour I
described that I figured I'd follow up.

If it's of no interest then I'll drop it.

> old and I have a downtime schedueled soon so I should be able to do
> this) to a recent 2.6.14. I figured I'd throw this into the mix as the

I don't think this'll happen as the next outage is too close to make
this of (much) use.

-- 
    "To the extent that we overreact, we proffer the terrorists the
    greatest tribute."
    	- High Court Judge Michael Kirby
