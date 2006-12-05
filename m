Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758492AbWLEVrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758492AbWLEVrs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 16:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759339AbWLEVrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 16:47:41 -0500
Received: from mailer.gwdg.de ([134.76.10.26]:58434 "EHLO mailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758771AbWLEVrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 16:47:36 -0500
Date: Tue, 5 Dec 2006 22:40:21 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       hch@infradead.org, viro@ftp.linux.org.uk, linux-fsdevel@vger.kernel.org,
       mhalcrow@us.ibm.com
Subject: Re: [PATCH 24/35] Unionfs: Readdir state
In-Reply-To: <11652354712296-git-send-email-jsipek@cs.sunysb.edu>
Message-ID: <Pine.LNX.4.61.0612052238320.18570@yvahk01.tjqt.qr>
References: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
 <11652354712296-git-send-email-jsipek@cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>+	/* Round it up to the next highest power of two. */
>+	mallocsize--;
>+	mallocsize |= mallocsize >> 1;
>+	mallocsize |= mallocsize >> 2;
>+	mallocsize |= mallocsize >> 4;
>+	mallocsize |= mallocsize >> 8;
>+	mallocsize |= mallocsize >> 16;
>+	mallocsize++;

Interesting idea how to do it. This could be made a kernel-wide function and
be used by other subsystems (they sure do have find-next-power-of-two too). But
that another time another patch.


	-`J'
-- 
