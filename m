Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266320AbUBLKFw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 05:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266324AbUBLKFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 05:05:51 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:32128 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S266320AbUBLKFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 05:05:41 -0500
Date: Thu, 12 Feb 2004 10:15:23 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200402121015.i1CAFN4C000841@81-2-122-30.bradfords.org.uk>
To: Giuliano Pochini <pochini@shiny.it>, Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <XFMail.20040212104215.pochini@shiny.it>
References: <XFMail.20040212104215.pochini@shiny.it>
Subject: Re: ext2/3 performance regression in 2.6 vs 2.4 for small interl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Giuliano Pochini <pochini@shiny.it>:
> 
> On 12-Feb-2004 Andrea Arcangeli wrote:
> 
> > the main difference is that 2.4 isn't in function of time, it's in
> > function of requests, no matter how long it takes to write a request,
> > so it's potentially optimizing slow devices when you don't care about
> > latency (deadline can be tuned for each dev via
> > /sys/block/*/queue/iosched/).
> 
> IMHO it's the opposite. Transfer speed * seek time of some
> slow devices is lower than fast devices. For example:
> 
> Hard disk  raw speed= 40MB/s   seek time =  8ms
> MO/ZIP     raw speed=  3MB/s   seek time = 25ms
> 
> One seek of HD costs about 320KB, while on a slow drive it's
> only 75KB.

Hmmm, but I would imagine that most hard disks have much larger caches
than are popular on removable cartridge drives...

John.
