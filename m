Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314389AbSE1MsK>; Tue, 28 May 2002 08:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314396AbSE1MsJ>; Tue, 28 May 2002 08:48:09 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:37113 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314389AbSE1MsJ>; Tue, 28 May 2002 08:48:09 -0400
Subject: Re: bluesmoke, machine check exception, reboot
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Corin Hartland-Swann <cdhs@commerce.uk.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L2.0205281301440.27799-100000@buffy.commerce.uk.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 28 May 2002 14:50:37 +0100
Message-Id: <1022593837.4124.78.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-05-28 at 13:19, Corin Hartland-Swann wrote:
> I have a Dual PIII-1000 running 2.4.18, and am occasionally getting the
> following error:
> 
> > CPU 1: Machine Check Exception: 000000000000000004
> > Bank 1: f200000000000115
> > Kernel panic: CPU context corrupt
> 
> This results in a hard lock (unable to use magic SysRQ key to sync or
> reboot, etc). I located these errors in arch/i386/kernel/bluesmoke.c in
> the function intel_machine_check(). From what I have read on lkml it is
> probably a result of the processor overheating and causing errors.

It may even be a faulty processor. If you are running the processor to
spec and your heatsink/fan/voltage all check out you may want to see
about getting the CPU replaced. Thats a data cache l1 read error it
appears

> meantime is there anything I can do to get the machine to reboot after the
> panic? After the last time that this happened, I set
> /proc/sys/kernel/panic to 10, but it hasn't happened since then so I can't
> tell whether it will work. The error listed above is the entire error
> before the machine fails - there is no register dump or anything after
> that.

That /proc setting should cause a reboot although after an MCE all
things are a little undefined

> Do you think it will manage to reboot with a hopelessly confused
> processor?

Should do

