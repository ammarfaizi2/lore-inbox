Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319338AbSIFTOS>; Fri, 6 Sep 2002 15:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319341AbSIFTOS>; Fri, 6 Sep 2002 15:14:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30982 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S319338AbSIFTOS>;
	Fri, 6 Sep 2002 15:14:18 -0400
Date: Fri, 6 Sep 2002 20:18:56 +0100
From: Matthew Wilcox <willy@debian.org>
To: minyard@acm.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Version 2 of the Linux IPMI driver
Message-ID: <20020906201856.F26580@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The lanana guy is not available for a while, so I'm not getting a device
> number in the near future, but I think it's ready for the 2.5 release.
> Does this need more time, or is it ready for inclusion?

I don't think you should be using a device number at all.  ioctl is Evil
(TM) and it's perfectly possible to write an IPMI driver which uses
neither an ioctl nor a chaacter device.  Voila:

http://ftp.linux.org.uk/pub/linux/willy/patches/bmc.diff

yes, it was stupid to call it BMC instead of IPMI.  i was handed a pile
of junk that'd been half-heartedly ported from windows.  however, the
principle is sound, you don't need ioctl, nor a character device.

-- 
Revolutions do not require corporate support.
