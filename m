Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130382AbRAJW0f>; Wed, 10 Jan 2001 17:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130571AbRAJW0Z>; Wed, 10 Jan 2001 17:26:25 -0500
Received: from colorfullife.com ([216.156.138.34]:10512 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S130382AbRAJW0E>;
	Wed, 10 Jan 2001 17:26:04 -0500
Message-ID: <3A5CE07D.BD36D71C@colorfullife.com>
Date: Wed, 10 Jan 2001 23:21:49 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Frank de Lange <frank@unternet.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware 
 related?
In-Reply-To: <20010110223015.B18085@unternet.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank de Lange wrote:
> 
> Hi'all,
> 
> Ever since I put two ethernet-cards (cheap Winbond W89C940 based PCI NE2K
> clones) in my BP-6 system, I've been experiencing intermittent network hangs.
>

Which driver do you use? The driver in 2.4.0 contains several bugfixes.
If that driver still hangs then I'll double check the documentation.

> A
> hang manifests itself as a total failure to communicate through either network
> card, and can only be solved by rebooting. Removing and reloading the modules
> does not fix the problem, only a reboot works.
> 

That's different from my problems:
unload+reload always fixed my problems with the unpatch winbond-840
driver.

> which should work, they are
> NON-busmastering cards after all...),
third line in w840_probe1():

	pci_set_master().

And the documentation begins with
W89C840F
	PCI Bus Master Fast Ethernet LAN Controller.


--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
