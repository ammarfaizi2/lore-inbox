Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268107AbUIFP1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268107AbUIFP1d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 11:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268137AbUIFP1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 11:27:33 -0400
Received: from 134.gymko.ba.gtsi.sk ([62.168.65.134]:58312 "EHLO eloth.gjh.sk")
	by vger.kernel.org with ESMTP id S268107AbUIFP1X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 11:27:23 -0400
Date: Mon, 6 Sep 2004 17:27:07 +0200 (CEST)
From: Jozef Vesely <vesely@gjh.sk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jakub Vana <gugux@centrum.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: x86 - Realmode BIOS and Code calling module
In-Reply-To: <1092311802.21978.22.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0409061703510.31771-100000@eloth.gjh.sk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 12 Aug 2004, Alan Cox wrote:

> On Iau, 2004-08-12 at 10:36, Jakub Vana wrote:
> > Hello,
> >
> > I have written Linux Kernel module that allows you to call BIOS
> > interupts, Far services or your own code.
>
> Why is this better than LRMI in user mode. To do BIOS calls safely
> you need to be very careful about things like PCI locking, I/O
> emulation and the ROM scribbling in strange places. LRMI can handle this
> in user space as does x86emu in Xorg.
>

In-kernel BIOS calls are useful:
I (and many others) have experienced problems with resuming from ACPI S3
state. Some graphic cards need to have their state saved before suspend
and restored after resume, otherwise the screen stays blank. VESA BIOS
call 0x4f04, does exactly that.

Yes it can be done from userspace, but at the time devices are woken up,
userspace processes are still sleeping. And if something goes wrong with
device wakeup (not uncommon thing with ACPI :-) ), you end up with a
backtrace on a blank screen :-(. (Modern laptops do not have serial port
to hook up terminal to.)

to Jakub:
You promised to put that code somewhere on the net, could
you please send me an URL.

Thank you


Jozef Vesely
vesely@gjh.sk


