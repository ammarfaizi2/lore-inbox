Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265742AbUAKDdT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 22:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265744AbUAKDdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 22:33:19 -0500
Received: from fmr06.intel.com ([134.134.136.7]:6281 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S265742AbUAKDdO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 22:33:14 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: Cannot boot after new Kernel Build
Date: Sun, 11 Jan 2004 11:33:08 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84015255CD@PDSMSX403.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Cannot boot after new Kernel Build
Thread-Index: AcPXlk0ULdWCOnhYTUqHw/4m2TUbWgAXWIzA
From: "Zhu, Yi" <yi.zhu@intel.com>
To: "Alex" <alex@meerkatsoft.com>, "Christian Kivalo" <valo@valo.at>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 11 Jan 2004 03:33:09.0162 (UTC) FILETIME=[A202C0A0:01C3D7F3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Make sure what's your root device with `rdev'.

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Alex
> Sent: Sunday, January 11, 2004 12:20 AM
> To: Christian Kivalo
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Cannot boot after new Kernel Build
> 
> 
> Hi,
> yes I already tried /dev/hda3 but still get the same errors 
> when booting.
> 
> Alex
> 
> Christian Kivalo wrote:
> 
> >>Hi,
> >>I tried changing the fstab, removing the LABLE from the grub.conf, 
> >>removing initrd from it and also tried to boot with /dev/hda3.  
> >>Nothing works, still the same problem.
> >>    
> >>
> >
> >hi!
> >
> >you don't have to change your fstab, there should everything ok with 
> >you fstab.
> >
> >you should change the root= entry in your grub configuration to your 
> >actual root partition. if you don't know what partition your root is 
> >on, do a 'df' and look where '/' is mounted on.
> >
> >the second line of df output should read somewhat similar to:
> >/dev/sda2              4806936   1611232   2951516  36% /
> >
> >that's my fileserver where /dev/sda2 is mounted as '/'.
> >
> >your root= in grub config should read somewhat like this:
> >root=/dev/hda1)
> >
> >hth
> >christian
> >
> >  
> >
> >>Alex
> >>
> >>    
> >>
> >
> >-
> >To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" 
> >in the body of a message to majordomo@vger.kernel.org More majordomo 
> >info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> >
> >
> >  
> >
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> Please read the 
> FAQ at  http://www.tux.org/lkml/
> 
