Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314459AbSE1OGh>; Tue, 28 May 2002 10:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316309AbSE1OGh>; Tue, 28 May 2002 10:06:37 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:39418 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314459AbSE1OGf>; Tue, 28 May 2002 10:06:35 -0400
Subject: Re: bluesmoke, machine check exception, reboot
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Corin Hartland-Swann <cdhs@commerce.uk.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L2.0205281432450.27799-100000@buffy.commerce.uk.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 28 May 2002 16:09:00 +0100
Message-Id: <1022598540.4123.89.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-05-28 at 14:46, Corin Hartland-Swann wrote:
> CPU 1: Machine Check Exception: 0000000000000004
> Bank 1: b200000000000115
> Kernel panic: CPU context corrupt
>
> How do you work out what the numbers mean? Is there some kind of reference
> to it, or are you just Alan "decodes machine check exceptions in his head"
> Cox :) From the code it seems to be some kind of MCG status and MC0 status
> - but of course, I have no idea what that means...

I contemplate them in zen peace and they speak to me 8). The MCE value
is the flags from the control register. The Bank n value is a dump of
the register that explains what the fault is. The decoding rules are in
the Intel Pentium III documentation set.

> After checking the logs (above) I found that the two times this has
> happened it has managed to write it to the logs. Is the fact that it
> sync()d a good indication that it will manage to reboot OK?

Is the fact the airbag deployed a good indication that it will deploy if
you keep crashing into walls ? Its logging a CPU error where it decides
the CPU is in an unrecoverable state. The odds are pretty good but each
time you are taking the risk it won't, and if its a hardware problem
that it might simply drop dead for good.

Alan

