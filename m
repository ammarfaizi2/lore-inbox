Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129765AbQKWKlG>; Thu, 23 Nov 2000 05:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131651AbQKWKk6>; Thu, 23 Nov 2000 05:40:58 -0500
Received: from cerebus-ext.cygnus.co.uk ([194.130.39.252]:10490 "EHLO
        passion.cygnus") by vger.kernel.org with ESMTP id <S129765AbQKWKkp>;
        Thu, 23 Nov 2000 05:40:45 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <E13yikV-0006ZQ-00@the-village.bc.nu> 
In-Reply-To: <E13yikV-0006ZQ-00@the-village.bc.nu> 
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: maillist@chello.nl (Igmar Palsenberg), schwab@suse.de (Andreas Schwab),
        middelink@polyware.nl (Pauline Middelink),
        linux-kernel@vger.kernel.org
Subject: Re: linux-2.2.18-pre19 asm/delay.h problem? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 23 Nov 2000 10:10:26 +0000
Message-ID: <8307.974974226@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


alan@lxorguk.ukuu.org.uk said:
> > |> Can't we change that to :
> > |> #error "Udelay..."
> > 
> > No.
> 
> ?? I think I'm missing something here.
> preprocessor stuff is done too early for this 

We were talking about

#if 0
/* Don't turn this on, fix your code instead */

void __bad_udelay(int c)
{
#error you broke it. read the damn comment
}
#endif

... so that when people search the tree for __bad_udelay they find this, 
and if they're silly enough to change the 0 to a 1 then it'll still break.

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
