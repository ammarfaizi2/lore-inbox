Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932747AbWGBSuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932747AbWGBSuJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 14:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932754AbWGBSuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 14:50:09 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:9102 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932747AbWGBSuH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 14:50:07 -0400
Date: Sun, 2 Jul 2006 20:46:04 +0200
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au
Subject: Re: 2.6.17-mm4 raid bugs & traces
Message-ID: <20060702184604.GA497@aitel.hist.no>
References: <20060629013643.4b47e8bd.akpm@osdl.org> <20060701111153.GA10855@aitel.hist.no> <20060701162532.GA14933@aitel.hist.no> <44A75BE0.2090604@reub.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44A75BE0.2090604@reub.net>
User-Agent: Mutt/1.5.11+cvs20060403
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 02, 2006 at 05:38:40PM +1200, Reuben Farrelly wrote:
> On 2/07/2006 4:25 a.m., Helge Hafting wrote:
> >More mm4 raid-1 troubles.
> 
> >More than a little irritating, I need the SATA raid-1 to be in sync
> >so lilo can install mm5 for me. 18 hours. 
> 
> Have you looked at enabling write-intent bitmaps on your raid-1 arrays?
> 
Didn't know about those. I solved this by rebooting into
2.6.16-rc6-mm2, where the resync is one hour.  2.6.15 must have bad
SATA drivers.
> With all the grief I have been having with RAID-1 recently, bitmaps have 
> saved me very very serious amounts of time resyncing the array.
> 
> Typically after my raid array has had devices/partitions kicked out (such 
> as when loading -mm5) it takes only 2-3 seconds to bring each non-fresh 
> device/partition back into the array and back up to sync (as opposed to 18 
> hours...).
> 
> Neil wrote a good posting at http://lkml.org/lkml/2005/12/4/118 about it 
> (which should be a FAQ entry in itself).

Thanks for the tip. I now have write intent bitmaps enabled on all
my arrays.

Helge Hafitng
