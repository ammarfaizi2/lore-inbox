Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310609AbSCHAEy>; Thu, 7 Mar 2002 19:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310608AbSCHAEp>; Thu, 7 Mar 2002 19:04:45 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:35063
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S310609AbSCHAEa>; Thu, 7 Mar 2002 19:04:30 -0500
Date: Thu, 7 Mar 2002 16:05:04 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] preempt-kernel on 2.4.19-pre2-ac2 bugfix
Message-ID: <20020308000504.GE28141@matchmail.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20020307232105.GD28141@matchmail.com> <E16j7aU-0004CX-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16j7aU-0004CX-00@the-village.bc.nu>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2002 at 11:46:17PM +0000, Alan Cox wrote:
> > I'm using 2.4.19-pre2-ac2-prmpt which is only patched with:
> > preempt-kernel-rml-2.4.19-pre2-ac2-3
> > And it looks like the VM accounting has been messed up.
> 
> I don't support pre-empt. If you can duplicate that without pre-empt then
> its interesting, but not its not implausible
> 
> > Committed AS:   366712 kB
> > 
> > As you can see, it says I'm using 366MB (roughly) of ram, but I'm only about
> > 95mb into swap with 128mb of ram.
> 
> That is the worst case swap usage based on the current allocations made by
> the system. My laptop for example isnt into swap at all but has a worst
> case of about 60Mb of swap.
> 
> > Alan, do you want me to try without preempt, or do you already have any
> > other reports like this?
> 
> No others, also knowing what it is actually running would be useful.
> 

I'm running kde, mutt, mozilla, make -j5 kernel compile on a loop for the
last coupld days.  I wasn't using this much address space with the same work
load yesterday, so that's why I think there is a bug there.  

Although, I seem to recall running the same compile loop on a larger system
(2x666 mhz p3 512mb ram, vnc, no local Xserver) on a previous (2.4.18-rc-ac)
kernel without any other patches. 

This machine is a 350 p2 with 128mb ram.

00:00.0 Host bridge: Intel Corp. 440BX/ZX - 82443BX/ZX Host bridge (rev 02)
00:01.0 PCI bridge: Intel Corp. 440BX/ZX - 82443BX/ZX AGP bridge (rev 02)
00:07.0 ISA bridge: Intel Corp. 82371AB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corp. 82371AB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corp. 82371AB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corp. 82371AB PIIX4 ACPI (rev 02)
00:0c.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 02)
00:0d.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 08)
01:00.0 Display controller: Texas Instruments TVP4020 [Permedia 2] (rev 01)

Mike
