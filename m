Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261434AbVAGSZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbVAGSZd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 13:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261526AbVAGSXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 13:23:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:50340 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261434AbVAGSUW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 13:20:22 -0500
X-Authenticated: #9962044
From: marvin24@gmx.de
To: Matthew Wilcox <matthew@wil.cx>
Subject: Re: Sym2 driver timeouts on powerstacks
Date: Fri, 7 Jan 2005 19:20:19 +0100
User-Agent: KMail/1.7.2
References: <200501041354.50294.marvin24@gmx.de> <20050107144822.GS27371@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20050107144822.GS27371@parcelfarce.linux.theplanet.co.uk>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501071920.19867.marvin24@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Matt,

in the meantime I checked 2.6.8 kernel and this one works fine. There were 
some changes in the interrupt code in in version 2.6.9 I think, so I second 
your opinion that the real problem is not the scsi driver, but some irq 
problems. Other people (on linuxppc-dev@ozlab.org) also noted this.
Unfortunatly, I have no direct access to this machine anymore to do some 
debuging, but I'm sure this will come up again in the (far) future - so be 
warned...

Anyway, thanks for your help

Marc


Am Freitag, 7. Januar 2005 15:48 schrieben Sie:
> On Tue, Jan 04, 2005 at 01:54:49PM +0100, Marc Dietrich wrote:
> > I'm trying to get a 2.6.10 kernel to run on a Motorola Powerstack II
> > (Utah). This is a PReP (powerpc) machine.
>
> I just had a thought:
>
> sym0: SCSI BUS has been reset.
> scsi0 : sym-2.1.18m
> elevator: using anticipatory as default io scheduler
> sym0:0:0:ccb @c7d9ac00 using tag 256.
> sym0: queuepos=2.
> sym0:0:0: ABORT operation started.
> sym0:0:0: ABORT operation timed-out.
> sym0:0:0: DEVICE RESET operation started.
> sym0:0:0: DEVICE RESET operation timed-out.
> sym0:0:0: BUS RESET operation started.
> sym0:0:0: BUS RESET operation timed-out.
> sym0:0:0: HOST RESET operation started.
> sym0:0:0:ccb @c7d9ac00 freeing tag 256.
> sym0: SCSI BUS has been reset.
>
> This is sym2's typical behaviour when it receives no interrupts.
> I think if you were to NFS-root this box, you'd see equal problems with
> the network driver.  Try asking on the powerpc lists, see if there's a
> known interrupt routing problem.
