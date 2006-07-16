Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751278AbWGPPx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbWGPPx5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 11:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbWGPPx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 11:53:57 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:56024 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751275AbWGPPx4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 11:53:56 -0400
Date: Sun, 16 Jul 2006 17:53:33 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Yuri van Oers <yvanoers@xs4all.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: SCSI device order changed
In-Reply-To: <20060716171547.W18821-100000@xs3.xs4all.nl>
Message-ID: <Pine.LNX.4.61.0607161751590.3179@yvahk01.tjqt.qr>
References: <20060716171547.W18821-100000@xs3.xs4all.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Hard disks are sda thru sdd, the devices start at sde. That is, up until I
>booted 2.6.17 _with_ the external devices attached. The kernel swapped
>the order of the cards: devices start at sda, and the disks come after,
>which means it can't find / on sda.
>
>I found a related post here: http://lkml.org/lkml/2005/12/3/192
>which suggests this situation arose around 2.6.15. It also says ordering
>can't be guaranteed. If that's the final verdict, I'll simply swap the
>cards on the PCI bus and be done with it.
>
And then, hope it does not change again?

It usually depends on link time order (when compiled in) or module load 
order (with initrd), both of which, esp. the latter, can be fine-tuned to 
the user's needs.

Also note CONFIG_BLK_DEV_OFFBOARD.



Jan Engelhardt
-- 
