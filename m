Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311706AbSCNSTR>; Thu, 14 Mar 2002 13:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311707AbSCNSTI>; Thu, 14 Mar 2002 13:19:08 -0500
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:5393 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S311706AbSCNSS7>; Thu, 14 Mar 2002 13:18:59 -0500
Message-ID: <3C90E983.5AC769B8@ngforever.de>
Date: Thu, 14 Mar 2002 11:18:43 -0700
From: Thunder from the hill <thunder@ngforever.de>
Organization: The LuckyNet Administration
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.8-26mdk i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
CC: root@chaos.analogic.com, Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
Subject: Re: IO delay, port 0x80, and BIOS POST codes
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:

> On Thu, 14 Mar 2002, Martin Wilck wrote:
> 
> 
> >Hello,
> >
> >the BIOS on our machines (Phoenix) uses IO-port 0x80 for storing
> >POST codes, not only during sytem startup, but also for messages
> >generated during SMM (system management mode) operation.
> >I have been told other BIOSs do the same.
> >
> >Unfortunately we can't read this information because Linux uses
> >port 80 as "dummy" port for delay operations. (outb_p and friends,
> >actually there seem to be a more hard-coded references to port
> >0x80 in the code).
> >
> >It seems this problem was always there, just nobody took notice of it yet
> >(at least in our company). Sometimes people wondered about the weird POST
> >codes displayed in the LCD panel, but who cares once the machine is up...
> >
> >Would it be too outrageous to ask that this port number be changed, or
> >made configurable?
> >
> >Martin
> 
> This is a 'N' year-old question. Do you know of a port that is
> guaranteed to exist on the Intel/PC/AT class machine? If so, submit
> a patch.  I proposed using 0x19h (DMA scratch register) several
> years ago, but it was shot down for some reason. Then I proposed
> 0x42 (PIT Misc register), that too was declared off-limits. So
> I suggested that the outb to 0x80 be changed to an inp, saving 
> %eax on the stack first. That too was shot down. So, you try
> something... and good luck.
I also remember this been discussed anually. Making it configurable with
a warning might be a solution, but that's nothing we could decide. Maybe
add a config option? It night be a [DANGEROUS] one, so the guys and gals
who might compile are warned of changing this.
I think the problem is that on PC arch anything is quite limited.

Thunder
