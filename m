Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129532AbRAFJ72>; Sat, 6 Jan 2001 04:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129806AbRAFJ7T>; Sat, 6 Jan 2001 04:59:19 -0500
Received: from smtp1.mail.yahoo.com ([128.11.69.60]:25868 "HELO
	smtp1.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129431AbRAFJ7L>; Sat, 6 Jan 2001 04:59:11 -0500
X-Apparently-From: <p?gortmaker@yahoo.com>
Message-ID: <3A56E983.343007BC@yahoo.com>
Date: Sat, 06 Jan 2001 04:46:43 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.2.18 i486)
MIME-Version: 1.0
To: Aschwin van der Woude <aschwin@sofis.fi>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, becker@scyld.com,
        linux-net@vger.kernel.org
Subject: Re: Kernel halts rock solid on assigning ip (ne2k-pci)
In-Reply-To: <3A55D540.1FA574D9@sofis.fi>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aschwin van der Woude wrote:
> 
> I have a problem with a network-driver.
> The ne2k-pci modules loads fine, no problem at all. Everything works
> like a sunshine.
> But as soon as I try to assign an IP-adress the whole system halts
> rock-solid, the magic sysrq combinations don't even work anymore.
> 
> I am not sure if this is due to an IRQ-conflict. But I do know it all
> happens to work perfectly fine with 2.4.0-test10. This happens on both
> 2.4.0-prerelease and the 2.4.0-kernel.
> 
> I attached some info about my configuration. I hope you/somebody can
> help me solve this, I am eager to start using 2.4.0.
> So far I have been very happy using 2.4.0-test10.

The test11 patch has the ne2k-pci changes for FD support, and the
test12 patch has the Tx timeout relocation in 8390 (which ne2k-pci
uses).  Can you see which one of those (if either) causes the
breakage?  You should be able to put the 8390.c and ne2k-pci.c
from test10 directly into 2.4.0 proper (one at a time and then
both if required) to see which (if either) is responsible.

Thanks,
Paul.


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
