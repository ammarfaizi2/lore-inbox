Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264300AbTIIU77 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 16:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264418AbTIIU7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 16:59:42 -0400
Received: from mail.velocity.net ([208.3.88.4]:14019 "EHLO mail.velocity.net")
	by vger.kernel.org with ESMTP id S264300AbTIIU6x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 16:58:53 -0400
Subject: Re: linux 2.4.X and Rocket 1540 SATA
From: Dale Blount <dale@velocity.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1063128440.4956.22.camel@dale.velocity.net>
References: <1063128440.4956.22.camel@dale.velocity.net>
Content-Type: text/plain
Message-Id: <1063141132.4956.39.camel@dale.velocity.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 09 Sep 2003 16:58:52 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-09-09 at 13:27, Dale Blount wrote:
> Hello,
> 
> I'm trying to get a HighPoint Rocket SATA (4 port) card working with
> kernel 2.4.X.  Currently it hangs just after detecting hdc (IDE cdrom).
> If I append hdg=noprobe hdi=noprobe, etc the box boots fine, but the
> SATA drives are no where to be found.  I'm currently using 2.4.22-ac1 to
> support the onboard intel SATA which works fine. 
> 
> I'm not sure what other information you'd need to help me debug this,
> but I'm willing to provide whatever is needed.
> 

I hate to reply to myself, but I've realized more information may be
needed.  The HPT card uses the hpt374 chip (ATA chipset that has had
linux support for at least a year or so).  I've also tried disabling the
onboard PATA ports (incase they are stomping on ideX) with no success. 
I noticed in the kernel config help that the hpt366 driver requires
"ide-probe" during boot, which is probably why noprobe lets the
boot-process continue but kills the drive's access.

This is the last line in the boot process when it hangs:
hdc: ATAPI 52X CD-ROM drive, 120kB Cache, DMA

Is there anyway to figure out why this card doesn't work?

Thanks again,

Dale


> Thanks,
> 
> Dale
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

