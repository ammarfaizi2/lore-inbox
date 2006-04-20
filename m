Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750870AbWDTTdb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbWDTTdb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 15:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbWDTTdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 15:33:31 -0400
Received: from EXCHG2003.microtech-ks.com ([24.124.14.122]:26618 "EHLO
	EXCHG2003.microtech-ks.com") by vger.kernel.org with ESMTP
	id S1750870AbWDTTdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 15:33:31 -0400
Message-ID: <4447E209.4050802@atipa.com>
Date: Thu, 20 Apr 2006 14:33:29 -0500
From: Roger Heflin <rheflin@atipa.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Roger Heflin <rheflin@atipa.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: sata_mv issues with more than 1 disk in FC5 2.6.16-1.2096
References: <4447C183.3040000@atipa.com>
In-Reply-To: <4447C183.3040000@atipa.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Apr 2006 19:25:30.0808 (UTC) FILETIME=[2FF27B80:01C664B0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Heflin wrote:
> Hello,
> 
> I know the FC5 2.6.16-1.2096 is based off of one of the 2.6.16
> stable releases.   I am not sure exactly which one this is based
> on.
> 
> I have several machines with this controller, the ones with a single
> disks all work correctly using the Marvell controller.
> 
> An identical MB/controller/chassis fails when there are 2 disks
> using software mirroring.  We have tested with 2 separate chassis,
> both exhibit the same failure.
> 
> Moving the 2 disks to a different built-in sata controller
> (sata_nv) results in the disks and the mirror working
> correctly.
> 
> The errors that it returns are:
> ata4: status=0xd0 { Busy }
> ata2: status=0xd0 { Busy }
> And the machine is terribly slow while this error is happening.
> The error appears to be happening when the disks are trying
> to be mounted.
> 
> We have tested the disk on a couple of different combinations of
> ports and this does not seem to change anything.
> 
> The single disk machines don't get this error like the 2 disk
> machines, though  they do get this error, every 30 minutes
> or so (probably from  smartd), but this error does not
> appear to be causing issues.
> Apr 19 16:26:19 lab229 kernel: ata1: status=0xd0 { Busy }
> Apr 19 16:26:19 lab229 kernel: ATA: abnormal status 0xD0 on
>     port 0xFFFFC2001012211C
> 
> Any thoughts?
> 
>                                 Roger


And at least one FC5 2.6.15 variant has the same behavior, so it
is not just on the 2.6.16.x variants.

                               Roger
