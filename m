Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315370AbSE2OAL>; Wed, 29 May 2002 10:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315334AbSE2OAK>; Wed, 29 May 2002 10:00:10 -0400
Received: from sm14.texas.rr.com ([24.93.35.41]:53229 "EHLO sm14.texas.rr.com")
	by vger.kernel.org with ESMTP id <S315337AbSE2N75>;
	Wed, 29 May 2002 09:59:57 -0400
Subject: Re: [PATCH] 2.5.18 IDE 73
From: Gerald Champagne <gerald@io.com>
To: linux-kernel@vger.kernel.org
Cc: dalecki@evision-ventures.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 29 May 2002 08:59:44 -0500
Message-Id: <1022680784.2945.24.camel@wiley>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>- ide_driveid_update is gone. We don't report the drive id through 
> /proc/ide and we don't have to update it any longer on the fly. Still 
> someone out there complaining that it went away!?

But the id information is still available through the ioctl interface. 
ide_driveid_update was used to update the dma_ultra, dma_mword, and
dma_lword fields in the id structure after changing the rate with an
ioctl command.  Won't these fields be wrong if the rate is changed after
initialization?  Won't "hdparm -i" show outdated and incorrect
information.

It's good to see the duplicate identify routine go away, but the ioctl
shouldn't return incorrect information.  Can the remaining identify
routine be modified and called directly from the ioctl that returns the
id information?

Gerald



