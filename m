Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129568AbQLaL74>; Sun, 31 Dec 2000 06:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129703AbQLaL7q>; Sun, 31 Dec 2000 06:59:46 -0500
Received: from mail.zmailer.org ([194.252.70.162]:58886 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S129568AbQLaL7a>;
	Sun, 31 Dec 2000 06:59:30 -0500
Date: Sun, 31 Dec 2000 13:28:50 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: scheduling problem test13-pre7
Message-ID: <20001231132850.C28963@mea-ext.zmailer.org>
In-Reply-To: <Pine.Linu.4.10.10012311014280.1247-100000@mikeg.weiden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.Linu.4.10.10012311014280.1247-100000@mikeg.weiden.de>; from mikeg@wen-online.de on Sun, Dec 31, 2000 at 10:42:26AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 31, 2000 at 10:42:26AM +0100, Mike Galbraith wrote:
> Hi,
> 
> While running iozone, I notice severe stalls of vmstat output
> despite vmstat running SCHED_RR and mlockall().

   Lets eliminate the obvious:

   - Are you running with IDE disk ?
   - Does   hdparm  /dev/hda(whatever)    report:

	/dev/hda:
	 unmaskirq    =  0 (off)
	 using_dma    =  0 (off)

   The IKD uses local interrupts, so this isn't necessarily true...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
