Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289490AbSAOPuw>; Tue, 15 Jan 2002 10:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289979AbSAOPuf>; Tue, 15 Jan 2002 10:50:35 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:2564 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S289490AbSAOPuI>; Tue, 15 Jan 2002 10:50:08 -0500
Message-Id: <200201151550.g0FFo4Z00346@aslan.scsiguy.com>
To: Markus Walser <walser@scs.ch>
cc: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx bus speed 
In-Reply-To: Your message of "Tue, 15 Jan 2002 16:30:02 +0100."
             <3C444AFA.8000605@scs.ch> 
Date: Tue, 15 Jan 2002 08:50:04 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi
>I've an aic7899: Ultra160 Wide scsi controller with a few disks
>under an alpha ds20 running.
>Now I'm having troubles getting 160MB/s bus speed on the
>actual kernels (2.4.18pre2/2.5.2pre9). On the kernel 2.2.18 and
>the redhat kernels 2.4.3-12, 2.4.9-13 I get full speed of 160MB/s.
>But on the new kernel I get just 80MB/s per bus.

You probably have IBM drives that say they are SCSI-2 yet can do
160 speeds.  There is a check in the driver that prevents it from
negotiating from SCSI-2 drives so as to not blow up on SCSI-2 devices
that don't support the new negotiation message type.  I have a fix
to work around IBM's mistake in the next driver release.

--
Justin
