Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130807AbRAKLmf>; Thu, 11 Jan 2001 06:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131045AbRAKLmS>; Thu, 11 Jan 2001 06:42:18 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:16311 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S130807AbRAKLl5>; Thu, 11 Jan 2001 06:41:57 -0500
Message-ID: <3A5D9D87.8A868F6A@uow.edu.au>
Date: Thu, 11 Jan 2001 22:48:23 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0 i586)
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
> clones) in my BP-6 system, I've been experiencing intermittent network hangs. A
> hang manifests itself as a total failure to communicate through either network
> card, and can only be solved by rebooting. Removing and reloading the modules
> does not fix the problem, only a reboot works.
> 

Losing both NICs at the same time could be the elusive "APIC
stops generating interrupts" problem.

Do you get any transmit timeout messages in the logs?  If
so, send them.

Does it happen with a uniprocessor build?

Are you able to boot with the `noapic' LILO option?
If so, does that make it stop?

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
