Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261362AbVBNIyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbVBNIyN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 03:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261372AbVBNIyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 03:54:13 -0500
Received: from postman2.arcor-online.net ([151.189.20.157]:22461 "EHLO
	postman.arcor.de") by vger.kernel.org with ESMTP id S261362AbVBNIxN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 03:53:13 -0500
Date: Mon, 14 Feb 2005 09:53:20 +0100
From: Tino Keitel <tino.keitel@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: Droebbel <droebbel.melta@gmx.de>
Subject: Re: [Problem] slow write to dvd-ram since 2.6.7-bk8
Message-ID: <20050214085320.GA4910@dose.home.local>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Droebbel <droebbel.melta@gmx.de>
References: <1108301794.9280.18.camel@localhost.localdomain> <20050213142635.GA2035@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050213142635.GA2035@animx.eu.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 13, 2005 at 09:26:35 -0500, Wakko Warner wrote:
> Droebbel wrote:
> > On recent kernels, writing to DVD-RAM is much slower than to be
> > expected. A 3x Writer should do about 1.9MB/s including automatic
> > verify. This is what I get with 2.6.7 up to bk7. However, from 2.6.7-bk8
> > to 2.6.10 write speed is as low as 600 to 1000 kB/s. The drive's head
> > jumps a lot more with these kernels. Reading is ok.
> > 
> > I tested UDF and ext2 filesystems,
> > DMA is ok according to hdparm,
> > I set taskfile-io on and off when building the kernels,
> > and I compared the settings for the io-scheduler.
> > 
> > The drive is connected via onboard via82xx ide or usb2 external (both
> > works perfectly with hd).
> > 
> > The drive is a LG GSA-4163B; a GSA-4120 had the same problem as far as I
> > remember.
> > 
> > Medium: Panasonic 3x
> > 
> > Could not find any kernel error messages.
> 
> I have:
> Host: scsi1 Channel: 00 Id: 00 Lun: 00
>   Vendor: HL-DT-ST Model: DVDRAM GSA-4160B Rev: A300
>   Type:   CD-ROM                           ANSI SCSI revision: 02
> 
> I also notice this with 2.6.10.  I think I also had it with 2.6.8.1 but I
> don't remember, it's been a while.  The media I use is maxell DRM47 ver 2

I also have low write performance (around 300 kb/s) with several 2.6
kernels (2.6.7 to 2.6.9-mm1) and I can hear the head jump around when I
use ext2 or UDF. It will be fast when written directly to the device
without a file system using dd.  The drive is a LG GSA-4040B. I tried
several media types from Panasonic and EMTEC.

I'll try to test if the problem disappears with 2.6.6.

Regards,
Tino
