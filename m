Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262382AbRENTJu>; Mon, 14 May 2001 15:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262394AbRENTJm>; Mon, 14 May 2001 15:09:42 -0400
Received: from thimm.dialup.fu-berlin.de ([160.45.217.207]:28933 "EHLO
	pua.physik.fu-berlin.de") by vger.kernel.org with ESMTP
	id <S262382AbRENTJX>; Mon, 14 May 2001 15:09:23 -0400
Date: Mon, 14 May 2001 21:05:56 +0200
From: Axel Thimm <Axel.Thimm@physik.fu-berlin.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH 2.4.5.1: Fix Via interrupt routing issues
Message-ID: <20010514210556.A3371@pua.nirvana>
In-Reply-To: <3AFEC426.50B00B78@mandrakesoft.com> <20010514172104.A2160@pua.nirvana> <3B0004F7.4C54E2E4@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B0004F7.4C54E2E4@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Mon, May 14, 2001 at 12:16:55PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc: list trimmed]

On Mon, May 14, 2001 at 12:16:55PM -0400, Jeff Garzik wrote:
> Axel Thimm wrote:
> > On Sun, May 13, 2001 at 01:28:06PM -0400, Jeff Garzik wrote:
> > > For those of you with Via interrupting routing issues (or
> > > interrupt-not-being-delivered issues, etc), please try out this patch
> > > and let me know if it fixes things.  It originates from a tip from
> > > Adrian Cox... thanks Adrian!
> > 
> > Unfortunately the patch does not trigger here. nr_ioapics is zero on my UP
> > KT133A board. Was this patch for MP only?
> 
> Not for MP only, but mostly such:  UP systems with IO-APIC, or MP
> systems.

What about the following dmesg logs:

> Local APIC disabled by BIOS -- reenabling.
> Found and enabled local APIC!
> [...]
> Using local APIC timer interrupts.
> calibrating APIC timer ...

Don't they imply an APIC?

Anyway, I am sending the dmesg with "#define DEBUG 1" in pci-i386.h. It is a
2.4.4-ac5 defconfig kernel, but 2.4.4 has the same errors. System is an
MS-6330 v3.0 (MSI K7T Turbo), KT133A, Duron 700. I you have any idea, how I
could fix the pirq table I'd be glad to test further.

Regards, Axel.
-- 
Axel.Thimm@physik.fu-berlin.de
