Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261215AbVGYPW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbVGYPW1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 11:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbVGYPW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 11:22:27 -0400
Received: from EXCHG2003.microtech-ks.com ([65.16.27.37]:34588 "EHLO
	EXCHG2003.microtech-ks.com") by vger.kernel.org with ESMTP
	id S261215AbVGYPWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 11:22:25 -0400
From: "Roger Heflin" <rheflin@atipa.com>
To: "'zvi Dubitzki'" <zvidubitzki@hotmail.com>, <linux-kernel@vger.kernel.org>
Subject: RE: accessing CD fs from initrd
Date: Mon, 25 Jul 2005 10:25:20 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <BAY17-F4D75DC4B383C374A1BCD3BCCA0@phx.gbl>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
thread-index: AcWQ4djX7vvA1GztSXiJLv1JaXMfeAASq99w
Message-ID: <EXCHG2003yxdZjfNLnl00000512@EXCHG2003.microtech-ks.com>
X-OriginalArrivalTime: 25 Jul 2005 14:20:21.0220 (UTC) FILETIME=[FD765240:01C59123]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


/dev/cdrom is a link to the proper device, if that link is not
on the initrd /dev/cdrom won't work.

I previously had some statically linked linuxrc C code (I don't
have the code anymore- it was a work-for-hire), that scanned
the various locations that the cd could be (/dev/hd[abcd...])
and looked for specific files that it expected to be on the
cd, once it found it it setup real-root-dev to be proper for
that device.

This work rather nicely in situations where the location of
the cd drive was not the same from one machine to another,
and was rather simple to write.

                        Roger 

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of zvi Dubitzki
> Sent: Monday, July 25, 2005 2:28 AM
> To: linux-kernel@vger.kernel.org
> Subject: accessing CD fs from initrd
> 
> Hi there
> 
> I want to be CC-ed on a possible answer to the following question.
> I have not found yet an answer to the question in the Linux archives.
> 
> In need access the CD filesystem (iso9660) from within the 
> Linux initrd or right after that (make it root fs).
> I need an example for that since allocating enough ramdisk 
> space (ramdisk_size=90k in kernel command line)  + loading 
> the cdrom.o module at the initrd did not help  mount the CD 
> device (/dev/cdrom)  at the initrd Also I need know how to 
> pivot between the initrd and the CD filesystem
> 
> I am actually using Isolinux/syslinux, but can make test on a 
> regular Linux .
> Any pointer to a literature will also be welcomed .
> 
> thanks
> 
> Zvi Dubitzki
> 
> _________________________________________________________________
> FREE pop-up blocking with the new MSN Toolbar - get it now! 
> http://toolbar.msn.click-url.com/go/onm00200415ave/direct/01/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

