Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129870AbQKXTXJ>; Fri, 24 Nov 2000 14:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130030AbQKXTW7>; Fri, 24 Nov 2000 14:22:59 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:32562 "EHLO
        the-village.bc.nu") by vger.kernel.org with ESMTP
        id <S129870AbQKXTWp>; Fri, 24 Nov 2000 14:22:45 -0500
Subject: Re: do_initcalls bug
To: pavel@suse.cz (Pavel Machek)
Date: Fri, 24 Nov 2000 18:53:13 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (kernel list)
In-Reply-To: <20001124164812.A2115@bug.ucw.cz> from "Pavel Machek" at Nov 24, 2000 04:48:12 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13zNyF-0000HI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> static void __init do_initcalls(void)
> {
>         initcall_t *call;
> 
>         call = &__initcall_start;
>         do {
>                 early_printk("[%lx]\n", call);
>                 (*call)();
>                 call++;
>         } while (call < &__initcall_end);
> }
> 
> In case there are no initcalls to be called, it just simply
> crashes. Ouch.

Known problem. Fixed in 2.2.x. Linus didn't want to take the patches because
2.4 'always had initcalls'

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
