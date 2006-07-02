Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbWGBFij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbWGBFij (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 01:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbWGBFij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 01:38:39 -0400
Received: from tornado.reub.net ([202.89.145.182]:14285 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S932233AbWGBFii (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 01:38:38 -0400
Message-ID: <44A75BE0.2090604@reub.net>
Date: Sun, 02 Jul 2006 17:38:40 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 3.0a1 (Windows/20060701)
MIME-Version: 1.0
To: Helge Hafting <helgehaf@aitel.hist.no>
CC: linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au
Subject: Re: 2.6.17-mm4 raid bugs & traces
References: <20060629013643.4b47e8bd.akpm@osdl.org> <20060701111153.GA10855@aitel.hist.no> <20060701162532.GA14933@aitel.hist.no>
In-Reply-To: <20060701162532.GA14933@aitel.hist.no>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/07/2006 4:25 a.m., Helge Hafting wrote:
> More mm4 raid-1 troubles.

> More than a little irritating, I need the SATA raid-1 to be in sync
> so lilo can install mm5 for me. 18 hours. 

Have you looked at enabling write-intent bitmaps on your raid-1 arrays?

With all the grief I have been having with RAID-1 recently, bitmaps have saved 
me very very serious amounts of time resyncing the array.

Typically after my raid array has had devices/partitions kicked out (such as 
when loading -mm5) it takes only 2-3 seconds to bring each non-fresh 
device/partition back into the array and back up to sync (as opposed to 18 
hours...).

Neil wrote a good posting at http://lkml.org/lkml/2005/12/4/118 about it (which 
should be a FAQ entry in itself).

reuben
