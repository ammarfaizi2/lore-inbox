Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129050AbQKGTYH>; Tue, 7 Nov 2000 14:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129258AbQKGTXr>; Tue, 7 Nov 2000 14:23:47 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:19729 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129050AbQKGTXc>;
	Tue, 7 Nov 2000 14:23:32 -0500
Message-ID: <3A0856A8.11A12A94@mandrakesoft.com>
Date: Tue, 07 Nov 2000 14:23:20 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: tytso@mit.edu
CC: david@linux.com, alan@redhat.org, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 Status / TODO page (Updated as of 2.4.0-test10)
In-Reply-To: <E13rj9s-0003c4-00@the-village.bc.nu> <3A032828.6B57611F@linux.com> <3A0329DA.38A90824@mandrakesoft.com> <200011072021.eA7KLYG23520@trampoline.thunk.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tytso@mit.edu wrote:
> 
>    Date: Fri, 03 Nov 2000 16:10:50 -0500
>    From: Jeff Garzik <jgarzik@mandrakesoft.com>
> 
>    Part of that might be that serial doesn't support hotplug without
>    patching.
> 
> Did the patch which I sent out a few weeks ago actually work?  I haven't
> had time to get back to it, but I now have a cardbus card, so it's on my
> todo list....

I do not have CardBus card, so I can't test it.  Did you make sure to
have a pci_driver::remove function?  That is a requirement for PCI
hotplug.  Otherwise, your driver's probe routine will never be called.

I have a built-in Xircom modem on my Toshiba laptop, and it works great
with your patch.

	Jeff


-- 
Jeff Garzik             | "When I do this, my computer freezes."
Building 1024           |          -user
MandrakeSoft            | "Don't do that."
                        |          -level 1
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
