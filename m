Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932368AbWCHHvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbWCHHvn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 02:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbWCHHvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 02:51:42 -0500
Received: from smtp-out-01.utu.fi ([130.232.202.171]:28657 "EHLO
	smtp-out-01.utu.fi") by vger.kernel.org with ESMTP id S932368AbWCHHvm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 02:51:42 -0500
Date: Wed, 08 Mar 2006 09:51:38 +0200
From: Jan Knutar <jk-lkml@sci.fi>
Subject: Re: [PATCH] mm: yield during swap prefetching
In-reply-to: <200603081228.05820.kernel@kolivas.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, ck@vds.kolivas.org
Message-id: <200603080951.38316.jk-lkml@sci.fi>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <200603081013.44678.kernel@kolivas.org>
 <20060307172337.1d97cd80.akpm@osdl.org> <200603081228.05820.kernel@kolivas.org>
User-Agent: KMail/1.6.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 March 2006 03:28, Con Kolivas wrote:

> Anything that does disk access delays prefetch fine. Things that only do heavy 
> cpu do not delay prefetch. Anything reading from disk will be noticeable 
> during 3d gaming.

What exactly makes the disk accesses noticeable? Is it because they steal
time from the disk that the game otherwise would need, or do the disk accesses
themselves consume noticeable amounts of CPU time? 
Or, do bits of the game's executable drop from memory to make room for the
new stuff being pulled in from memory, causing the game to halt while it waits
for its pages to come back? On a related note, through advanced use of
handwaving and guessing, this seems to be the thing that kills my destop
experience (*buzzword alert*) most often. Checksumming a large file
seems to be less of an impact than things that seek alot, like updatedb.

I remember playing vegastrike on my linux desktop machine few years ago,
the game leaked so much memory that it filled my 2G swap rather often,
unleashing OOM killer mayhem. I "solved" this by putting swap on floppy at
lower priority than the 2G, and a 128M swap file as "backup" at even lower
priority than the floppy. I didn't notice the swapping to harddrive, but when it
started to swap to floppy, it made the game run a bit slower for a few seconds,
plus the floppy light went on, and I knew I had 128M left to  save my position
and quit.

If I needed floppy to make disk access noticeable on my very low end
machine... What are these new fancy things doing to make HD access
noticeable?
