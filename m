Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936563AbWLBSzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936563AbWLBSzQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 13:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936565AbWLBSzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 13:55:16 -0500
Received: from mailer-b2.gwdg.de ([134.76.10.29]:34282 "EHLO mailer-b2.gwdg.de")
	by vger.kernel.org with ESMTP id S936563AbWLBSzO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 13:55:14 -0500
Date: Sat, 2 Dec 2006 19:53:38 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Pavel Machek <pavel@ucw.cz>
cc: Shaohua Li <shaohua.li@intel.com>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch]VMSPLIT_2G conflicts with PAE
In-Reply-To: <20061202130544.GC4773@ucw.cz>
Message-ID: <Pine.LNX.4.61.0612021952250.25553@yvahk01.tjqt.qr>
References: <1164944925.1918.5.camel@sli10-conroe.sh.intel.com>
 <20061202130544.GC4773@ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> PAGE_OFFSET is 0x78000000 with VMSPLIT_2G, this address is in the middle
>> of the second pgd entry with pae enabled. This breaks assumptions
>> (address is aligned to pgd entry's address) in a lot of places like
>> pagetable_init. Fixing the assumptions is hard (eg, low mapping). SO I
>> just changed the address to 0x80000000.
>
>Do we allow user entering arbitrary value here? In any case, it would
>be nice to document alignment requirements of this one, because
>otherwise someone *will* get it wrong.

There was a reason 0x78000000 was chosen
http://marc.theaimsgroup.com/?l=linux-kernel&m=113690073801820&w=2

Though further back in 
http://marc.theaimsgroup.com/?l=linux-kernel&m=113689790817521&w=2
0x80000000 was indeed posted.


	-`J'
-- 
