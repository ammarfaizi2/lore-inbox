Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266199AbTBPJo6>; Sun, 16 Feb 2003 04:44:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266200AbTBPJo5>; Sun, 16 Feb 2003 04:44:57 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:13756 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S266199AbTBPJov>;
	Sun, 16 Feb 2003 04:44:51 -0500
Date: Sun, 16 Feb 2003 10:54:16 +0100
From: Jens Axboe <axboe@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 365] New: Raid-0 causes kernel BUG at drivers/block/ll_rw_blk.c:1996
Message-ID: <20030216095416.GT26738@suse.de>
References: <5630000.1045364322@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5630000.1045364322@[10.10.2.4]>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 15 2003, Martin J. Bligh wrote:
> 
> http://bugme.osdl.org/show_bug.cgi?id=365
> 
>            Summary: Raid-0 causes kernel BUG at
>                     drivers/block/ll_rw_blk.c:1996
>     Kernel Version: 2.5.61
>             Status: NEW
>           Severity: blocking
>              Owner: bugme-janitors@lists.osdl.org
>          Submitter: harisri@bigpond.com
> 
> 
> Distribution: RH 8.0
> Hardware Environment: Athlon, AMD 761 (AMD North Bridge, VIA South bridge),
> IDE Hard drives
> Software Environment: Gnu C 3.2, Linux C Library 2.2.93,
> raidtools-1.00.2-3.3 Problem Description: 2.5.61 oops while trying to
> activate raid-0 volumes. Please refer the thread
> http://marc.theaimsgroup.com/?l=linux-kernel&m=103830814911111&w=2 for more
> information from Neil Brown, Jens Axboe and Andrew Morton.
> 
> Steps to reproduce: Try to enable raid-0 volumes under 2.5.49 to 2.5.61

Known bug, raid0 doesn't accept a full PAGE_CACHE_SIZE page at any
offset, and the api relies on that. Fix is probably to add the sub-page
split stuff.

-- 
Jens Axboe

