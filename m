Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317333AbSFCJiH>; Mon, 3 Jun 2002 05:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317339AbSFCJiG>; Mon, 3 Jun 2002 05:38:06 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:62851 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S317333AbSFCJiF>;
	Mon, 3 Jun 2002 05:38:05 -0400
Date: Mon, 3 Jun 2002 11:37:53 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
        Anthony Spinillo <tspinillo@linuxmail.org>,
        linux-kernel@vger.kernel.org
Subject: Re: INTEL 845G Chipset IDE Quandry
Message-ID: <20020603113753.B13637@ucw.cz>
In-Reply-To: <20020602101628.4230.qmail@linuxmail.org> <3CFA73C3.9010902@evision-ventures.com> <20020602233043.A11698@ucw.cz> <3CFAF4A0.5010702@evision-ventures.com> <20020603104747.C13158@ucw.cz> <3CFB231E.7010806@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2002 at 10:04:46AM +0200, Martin Dalecki wrote:

> Well I don't know that much about the ever changing PCI/ACPI support
> in kernel - the only thing I could imagine
> would be that we sanitize the handling of it at the generic
> "chipset quirk handling" there. Right during the "bios table
> scan" time... (I mean drivers/pci/quirks.c)
> 
> The following function there looks like the right tool for this
> purpose:
> 
> static void __init quirk_io_region(struct pci_dev *dev, unsigned region, 
> unsigned size, int nr)
> 
> Well after looking closer I'm convinced that this is
> the right place... will you have a look at this plase...
> I'm more then busy enbough with other things right now.

The PCI code under normal circumstances can fix the allocation problems
by itself (without any special quirks code), but in this case it simply
fails. Do you still have the original e-mail with the dmesg? I'd like to
look at that again ...

-- 
Vojtech Pavlik
SuSE Labs
