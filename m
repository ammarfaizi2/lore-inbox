Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130329AbQLKXoG>; Mon, 11 Dec 2000 18:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130147AbQLKXn4>; Mon, 11 Dec 2000 18:43:56 -0500
Received: from APh-Aug-101-1-1-87.abo.wanadoo.fr ([193.251.41.87]:7940 "EHLO
	sawtooth.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S129908AbQLKXnq>; Mon, 11 Dec 2000 18:43:46 -0500
From: Benjamin Herrenschmidt <bh40@calva.net>
To: James Simmons <jsimmons@suse.com>,
        FrameBuffer List <linux-fbdev@vuser.vu.union.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.X patches for fbcon
Date: Tue, 12 Dec 2000 00:12:42 +0100
Message-Id: <19341105164426.29128@192.168.1.10>
In-Reply-To: <Pine.LNX.4.21.0012111416050.296-100000@euclid.oak.suse.com>
In-Reply-To: <Pine.LNX.4.21.0012111416050.296-100000@euclid.oak.suse.com>
X-Mailer: CTM PowerMail 3.0.6 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>--- atyfb.c	Mon Dec 11 14:28:19 2000
>+++ atyfb.c.orig	Wed Oct  4 22:22:28 2000
>@@ -2796,7 +2796,7 @@
>      * works on iMacs as well as the G3 powerbooks. - paulus
>      */
>     if (default_vmode == VMODE_CHOOSE) {
>-	if ((Gx == LG_CHIP_ID)||(Gx == LI_CHIP_ID)||(Gx == LP_CHIP_ID))
>+	if (Gx == LG_CHIP_ID)
> 	    /* G3 PowerBook with 1024x768 LCD */
> 	    default_vmode = VMODE_1024_768_60;

That one is wrong. The machine type must be probed differently. Also, some
wallstreet's have a different screen (passive matrix) which is 800x600. I'm
trying to find a way to probe for it and will come up with a patch for this
In the meantime, passing the vmode is the correct solution.

Ben.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
