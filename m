Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312545AbSCVO1p>; Fri, 22 Mar 2002 09:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312540AbSCVO1f>; Fri, 22 Mar 2002 09:27:35 -0500
Received: from harley.unix-ag.uni-siegen.de ([141.99.42.44]:15082 "EHLO
	harley.unix-ag.uni-siegen.de") by vger.kernel.org with ESMTP
	id <S312537AbSCVO1P>; Fri, 22 Mar 2002 09:27:15 -0500
Date: Fri, 22 Mar 2002 15:25:42 +0100
From: Fionn Behrens <Fionn.Behrens@unix-ag.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMP IRQ management issues in 2.4.x
Message-Id: <20020322152542.36250f11.fionn@unix-ag.org>
In-Reply-To: <E16oAlY-0006Qc-00@the-village.bc.nu>
Organization: United Fools Of Bugaloo
X-Mailer: Sylpheed version 0.7.4claws (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2002 22:10:36 +0000 (GMT)
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> > Mar 21 09:56:41 localhost kernel: hde: write_intr: status=0xd0 { Busy }
> > Mar 21 09:56:41 localhost kernel: ide2: reset: success
> > Mar 21 09:56:41 localhost kernel: hde: status error: status=0x58 {
> > DriveReady                                                    
> > SeekComplete DataRequest }
> 
> That doesnt look like an interrupt problem to be honest. Perhaps nvdriver
> is triggering something else
> 
> (the Busy is the drive saying its still waiting for something)

Just wanted to close the issue by saying it came out that it actually is NOT an IRQ problem.

Another close look at "hdparm -I" vs. "harparm -v" (and syslog) revealed that the hard disks had been configured for UDMA mode 5 by the controller (probably at boot time) while the Linux kernel set them to some IO mode.

Having found this out, I really wonder how the disks managed to work under any circumstances at all.

thanks for your hints and reading,

	Fionn
-- 
I believe we have been called by history to lead the world.
                                                       G.W. Bush, 2002-03-01
