Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270719AbTGNTSM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 15:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266106AbTGNTSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 15:18:12 -0400
Received: from stud.tb.fh-muenchen.de ([129.187.138.35]:33727 "HELO
	stud.fh-muenchen.de") by vger.kernel.org with SMTP id S270719AbTGNTRZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 15:17:25 -0400
Subject: [Fwd: Re: 2.6.0-test1: include/linux/pci.h inconsistency?]
From: Lars Duesing <ld@stud.fh-muenchen.de>
To: linux-bugs@nvidia.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: University of Applied Sciences, Students Council
Message-Id: <1058211049.9676.14.camel@ws1.intern.stud.fh-muenchen.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 14 Jul 2003 21:30:49 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi People!
First of all, thanks for your superb nforce2-chipset!

As kernel-development is going very fast today, we do have big troubles
to get your unified drivers to work.
As you may know kernel version 2.6-test1 was shipped earlier this day.
There had many design-changes, and your network-driver doesn't work at
all with the new kernel. As I have been told by many people it should
not be the big problem to release a fully gpled network-driver. It is
nearly not possible at the moment for instance to boot linux via network
on this board, due to your binary code (it must be a module).
It would be very fine if you could think over it, and release your
driver fully under gpl, to incorporate this driver into normal kernel
development. 
Our problem is at the moment, that your driver is not compilable at all,
due to changed structs in include/linux/pci.h (pci_driver->driver_data
is obsoleted).

It would be nice if you could help us!

This mail is CCed to the linux-kernel-mailing-list.

Greetings,

	Lars Duesing
	Munich University Of Applied Sciences, Students' Council

-----Weitergeleitete Nachricht-----
From: Jeff Garzik <jgarzik@pobox.com>
To: Lars Duesing <ld@stud.fh-muenchen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1: include/linux/pci.h inconsistency?
Date: 14 Jul 2003 11:40:06 -0400

On Mon, Jul 14, 2003 at 05:06:06PM +0200, Lars Duesing wrote:
> btw: this driver_data is used by the networking part of the
> nforce2-driver. If anybody knows a hint, tell me. 

If nVidia had a clue, they would have used the portability wrappers
created specifically for this purpose:  pci_{get,dev}_drvdata.  This
works in 2.4, 2.5, and with the kcompat[1] toolkit, 2.2 also.


> Else I will try to wake up someone at nvidia.

Wake up someone at nVidia and get them to work with open source
net drivers.

I bet it works with amd8111e.c with a little modification, for example.

	Jeff



[1] http://sf.net/projects/gkernel/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

