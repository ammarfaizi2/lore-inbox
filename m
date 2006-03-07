Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932303AbWCGUHg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbWCGUHg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 15:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306AbWCGUHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 15:07:35 -0500
Received: from silver.veritas.com ([143.127.12.111]:61488 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932303AbWCGUHf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 15:07:35 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.02,172,1139212800"; 
   d="scan'208"; a="35539639:sNHT24449412"
Date: Tue, 7 Mar 2006 20:08:29 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: 2.6.16-rc5-mm3: revert early-alignment.patch
Message-ID: <Pine.LNX.4.61.0603071953540.4346@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 07 Mar 2006 20:07:34.0389 (UTC) FILETIME=[C5F16250:01C64222]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've reverted x86_64-mm-i386-early-alignment.patch from 2.6.16-rc5-mm3:
cache_line_size() 0 gave me a divide-by-0 in kmem_cache_init().

On one machine (i386 UP) - the others (i386 SMP and x86_64 SMP) having
no trouble at all.

Some years ago, the life-cycle of boot_cpu_data was rather convoluted,
and different on UP from SMP: perhaps it still is, and that's why the
difference.  But I've not delved deeper, expecting you or Andi to grasp
it a lot quicker.

(I never tried -mm2, so wouldn't have noticed if that patch was in -mm2.)

Hugh
