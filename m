Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268293AbUHLB5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268293AbUHLB5n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 21:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268308AbUHLB5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 21:57:43 -0400
Received: from stokkie.demon.nl ([82.161.49.184]:50354 "HELO stokkie.net")
	by vger.kernel.org with SMTP id S268293AbUHLB5l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 21:57:41 -0400
Date: Thu, 12 Aug 2004 03:57:38 +0200 (CEST)
From: "Robert M. Stockmann" <stock@stokkie.net>
To: linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <Pine.LNX.4.44.0408120347290.1628-100000@hubble.stokkie.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.2 (ftp://crashrecovery.org/pub/linux/amavis/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 04 Aug 2004, H.Rosmanith wrote:

> hi,
>  
> I've written a patch for cdrecord/cdrtools. I've sent it to Joerg Schilling
> already, but got no answer so far. Probably he's on vaccation.
>  
> I'm sending this to LKML too, because I've read about some ... nebulosity
> with respect to scsi device numbering as used by cdrtools.
>  
> To cut a long story short: the patch avoids cdrecord having to use the
> "virtual" scsi device numbering in the form of "ATAPI:x.y.z" and allows
> you to use the name of the device, e.g. /dev/hdc instead.
>  
> By removing the IDE to virtual scsi bus/host/lun mapping, a lot of confusion
> can be avoided especially if you have a lot devices of this kind in one
> system.
>  
> with kind regards,
> Herbert "herp" Rosmanith
>  
> Version: cdrtools-2.01a34
>  
> Solution: when the device specified in dev= starts with "/dev/hd" and
> this device can be found in /proc/ide, then cdrecord (and all
> it's components, such as e.g. cdrdao) is forced to use the
> ATAPI driver.
>  
> The patch is really very short and works at least on our system.
>  
> with kind regards,
> Herbert Rosmanith

Its indeed not straight forward to use cdrtools-2.0x together with
kernel 2.6.x . As an aid for the user, i wrote a small HOWTO for using 
cdrtools together with kernel 2.6, with special focus on retrieval
of which device names to use. The small HOWTO can be found on :

http://crashrecovery.org/oss-dvd/HOWTO-ossdvd.html

regards,

Robert
-- 
Robert M. Stockmann - RHCE
Network Engineer - UNIX/Linux Specialist
crashrecovery.org  stock@stokkie.net

