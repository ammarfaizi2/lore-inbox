Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263530AbRFAOXo>; Fri, 1 Jun 2001 10:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263531AbRFAOXY>; Fri, 1 Jun 2001 10:23:24 -0400
Received: from ausxc10.us.dell.com ([143.166.98.229]:50447 "EHLO
	ausxc10.us.dell.com") by vger.kernel.org with ESMTP
	id <S263530AbRFAOXM>; Fri, 1 Jun 2001 10:23:12 -0400
Message-ID: <CDF99E351003D311A8B0009027457F140810E482@ausxmrr501.us.dell.com>
From: Matt_Domsch@Dell.com
To: katz@advanced.org, linux-kernel@vger.kernel.org
Subject: RE: 2.4.[35] + Dell Poweredge 8450 + Oops on boot
Date: Fri, 1 Jun 2001 09:22:24 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> my config settings .. The settings, and kernels I'm trying (at least
> 2.4.3-ac9) work on other Dell boxes here, such as the 2450, and 6350
> (with same internals, ie the raid (dual channel) + nic)...
> 
>   Quick spec of the box is:
> 	Dell PowerEdge 8450
> 	4x550 Xeon / 2gig
> 	Onboard Adaptec SCSI
> 	AMI MegaRaid Single Channel 16mb
>       Dual Port Intel EtherExpress Pro/100+

Can you check the firmware on the PERC 2/SC?  (You claim you tried a
different system with a dual-channel, but that would be the PERC 2/DC).
There's a bug in the megaraid driver for some versions of the PERC 2/SC
firmware which can cause an oops when the megaraid driver loads.  It's fixed
by upgrading to v3.13 firmware, available by link on
http://domsch.com/linux.  That *shouldn't* be the problem, as I don't see
the megaraid sign-on message, but it could be.

Also, the onboard SCSI adapter isn't an Adaptec, it's a Symbios 810.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer
Dell Linux Solutions
www.dell.com/linux


