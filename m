Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbVBMOSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbVBMOSl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 09:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbVBMOSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 09:18:41 -0500
Received: from animx.eu.org ([216.98.75.249]:16826 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S261252AbVBMOSh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 09:18:37 -0500
Date: Sun, 13 Feb 2005 09:26:35 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: Droebbel <droebbel.melta@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Problem] slow write to dvd-ram since 2.6.7-bk8
Message-ID: <20050213142635.GA2035@animx.eu.org>
Mail-Followup-To: Droebbel <droebbel.melta@gmx.de>,
	linux-kernel@vger.kernel.org
References: <1108301794.9280.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108301794.9280.18.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Droebbel wrote:
> On recent kernels, writing to DVD-RAM is much slower than to be
> expected. A 3x Writer should do about 1.9MB/s including automatic
> verify. This is what I get with 2.6.7 up to bk7. However, from 2.6.7-bk8
> to 2.6.10 write speed is as low as 600 to 1000 kB/s. The drive's head
> jumps a lot more with these kernels. Reading is ok.
> 
> I tested UDF and ext2 filesystems,
> DMA is ok according to hdparm,
> I set taskfile-io on and off when building the kernels,
> and I compared the settings for the io-scheduler.
> 
> The drive is connected via onboard via82xx ide or usb2 external (both
> works perfectly with hd).
> 
> The drive is a LG GSA-4163B; a GSA-4120 had the same problem as far as I
> remember.
> 
> Medium: Panasonic 3x
> 
> Could not find any kernel error messages.

I have:
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: HL-DT-ST Model: DVDRAM GSA-4160B Rev: A300
  Type:   CD-ROM                           ANSI SCSI revision: 02

I also notice this with 2.6.10.  I think I also had it with 2.6.8.1 but I
don't remember, it's been a while.  The media I use is maxell DRM47 ver 2
(whatever that means).  I don't notice any jumping, but the system is quite
noisy as it is.  I have this same drive at work in a usb2 box but haven't
had the opportunity to try dvdram.

The DVDRAM above is not using ide-scsi emulation, it has a hardware scsi-ide
converter from Acard.  (I already have my ide ports used).  The scsi
controller is an adaptec dual u320 onboard (supermicro x5da8)

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
