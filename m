Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262366AbTESIGU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 04:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262367AbTESIGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 04:06:20 -0400
Received: from unthought.net ([212.97.129.24]:32917 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S262366AbTESIGS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 04:06:18 -0400
Date: Mon, 19 May 2003 10:19:14 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Anders Karlsson <anders@trudheim.com>
Cc: Riley Williams <Riley@Williams.Name>,
       Clemens Schwaighofer <cs@tequila.co.jp>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Two RAID1 mirrors are faster than three
Message-ID: <20030519081914.GB14971@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Anders Karlsson <anders@trudheim.com>,
	Riley Williams <Riley@Williams.Name>,
	Clemens Schwaighofer <cs@tequila.co.jp>,
	LKML <linux-kernel@vger.kernel.org>
References: <BKEGKPICNAKILKJKMHCACEECDAAA.Riley@Williams.Name> <1052995874.3248.20.camel@tor.trudheim.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1052995874.3248.20.camel@tor.trudheim.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 15, 2003 at 11:51:14AM +0100, Anders Karlsson wrote:
...
> No, it should not cause problems as when you add the split-off copy back
> into the mirror, it is treated as 'stale' and will get synchronised with
> the original. 

Correct

If this was not the case, background resynchronization of standard
2-disk RAID-1 would be a really horrible feature (with half the reads
returning stale data from the new disk)...

> 
> I would be very surprised if the Linux software md driver worked any
> diffrently than this. Perhaps someone that knows it in-depth can add to
> the conversation?

Unless there's bugs in the driver, your description is correct  :)

> 
> With the facilities of LVM 'snapshots' now being available, this
> practice of splitting off one copy from a three-way mirror is perhaps
> becoming redundant, but people will likely take the approach of "if it
> ain't broken, don't fix it" and leave old backup methods as they are.
> So if you work in the sysadm field, you might well come across this
> practice.

The really good argument for N>2 disk RAID-1 is still the seek-time and
multiple-readers performance benefits which you won't be addressing with
LVM snapshots.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
