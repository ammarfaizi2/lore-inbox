Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751215AbWCNJVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbWCNJVh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 04:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbWCNJVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 04:21:36 -0500
Received: from silver.veritas.com ([143.127.12.111]:61873 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751215AbWCNJVg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 04:21:36 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.02,189,1139212800"; 
   d="scan'208"; a="35844064:sNHT25446008"
Date: Tue, 14 Mar 2006 09:22:35 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Dave Jones <davej@redhat.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: signal_cache slab corruption.
In-Reply-To: <20060313181524.GA26234@redhat.com>
Message-ID: <Pine.LNX.4.61.0603140921270.5164@goblin.wat.veritas.com>
References: <20060313181524.GA26234@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 14 Mar 2006 09:21:35.0826 (UTC) FILETIME=[B0EE4320:01C64748]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Mar 2006, Dave Jones wrote:

> I got into the office today to find my workstation that was running
> a kernel based on .16rc5-git9 was totally unresponsive.
> After rebooting, I found this in the logs.
> 
> slab signal_cache: invalid slab found in partial list at ffff8100e3a48080 (11/11).
> slab signal_cache: invalid slab found in partial list at ffff81007ecc6100 (11/11).
> slab: Internal list corruption detected in cache 'signal_cache'(11), slabp ffff810037ec0998(12). Hexdump:
> 
> 000: c0 60 d9 7e 00 81 ff ff 00 61 cc 7e 00 81 ff ff
> 010: a8 09 ec 37 00 81 ff ff a8 09 ec 37 00 81 ff ff
> 020: 0c 00 00 00 00 00 00 00 57 d0 1d 07 01 00 00 00
> 030: 00 00 00 00
> ----------- [cut here ] --------- [please bite here ] ---------
> Kernel BUG at mm/slab.c:2598

Dave, please post the diff -u between your mm/slab.c and the -rc5-git9
mm/slab.c (or any other vanilla version): you've got your own debugging
enabled, which means we can't decipher this properly.  (Not that I'm
expecting to do any better myself than with previous slab corruptions.)

Thanks,
Hugh
