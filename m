Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129523AbQLYMDx>; Mon, 25 Dec 2000 07:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129707AbQLYMDe>; Mon, 25 Dec 2000 07:03:34 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:1747 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129523AbQLYMDW>; Mon, 25 Dec 2000 07:03:22 -0500
Message-ID: <3A473192.ED7EE89C@uow.edu.au>
Date: Mon, 25 Dec 2000 22:37:54 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.0test13pre4ac2
In-Reply-To: <E149bsl-0005NV-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> 2.4.0test13pre4-ac2
>
> o       Make smp cpu halt synchronous                   (Andi Kleen)

errr, Andi. 

We're asking all the other CPUs to call stop_this_cpu(), and then waiting
for them to complete the call.

But stop_this_cpu() never returns, so the machine gets stuck.

What were you trying to do here, BTW?

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
