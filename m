Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317324AbSFCJEV>; Mon, 3 Jun 2002 05:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317323AbSFCJEU>; Mon, 3 Jun 2002 05:04:20 -0400
Received: from [195.63.194.11] ([195.63.194.11]:25611 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317324AbSFCJES>; Mon, 3 Jun 2002 05:04:18 -0400
Message-ID: <3CFB231E.7010806@evision-ventures.com>
Date: Mon, 03 Jun 2002 10:04:46 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Anthony Spinillo <tspinillo@linuxmail.org>, linux-kernel@vger.kernel.org
Subject: Re: INTEL 845G Chipset IDE Quandry
In-Reply-To: <20020602101628.4230.qmail@linuxmail.org> <3CFA73C3.9010902@evision-ventures.com> <20020602233043.A11698@ucw.cz> <3CFAF4A0.5010702@evision-ventures.com> <20020603104747.C13158@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Mon, Jun 03, 2002 at 06:46:24AM +0200, Martin Dalecki wrote:
> 
>>Vojtech Pavlik wrote:
>>
>>>On Sun, Jun 02, 2002 at 09:36:35PM +0200, Martin Dalecki wrote:
>>>
>>>
>>>>Anthony Spinillo wrote:
>>>>
>>>>
>>>>>Back to my original problem, will there be a fix before 2010? ;)
>>>>
>>>>Well since you have already tyred yourself to poke at it.
>>>>Well please just go ahead and atd an entry to the table
>>>>at the end of piix.c which encompasses the device.
>>>>Do it by copying over the next familiar one and I would
>>>>be really geald if you could just test whatever this
>>>>worked. If yes well please send me just the patch and
>>>>I will include it.
>>>
>>>
>>>Note it works with 2.5 already. We have the device there.
>>
>>Yes after looking it up I realized it's already there.
> 
> 
> But as Alan pointer out, in 2.4 the missing PCI ID isn't the problem -
> it would work with no tuning without it, but the fact the on-board BIOS
> incorrectly assigns io-ranges to the PCI device is a problem we may have
> on 2.5 as well.


Well I don't know that much about the ever changing PCI/ACPI support
in kernel - the only thing I could imagine
would be that we sanitize the handling of it at the generic
"chipset quirk handling" there. Right during the "bios table
scan" time... (I mean drivers/pci/quirks.c)

The following function there looks like the right tool for this
purpose:

static void __init quirk_io_region(struct pci_dev *dev, unsigned region, 
unsigned size, int nr)

Well after looking closer I'm convinced that this is
the right place... will you have a look at this plase...
I'm more then busy enbough with other things right now.

