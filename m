Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263302AbTC0Qx2>; Thu, 27 Mar 2003 11:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263300AbTC0Qx2>; Thu, 27 Mar 2003 11:53:28 -0500
Received: from chaos.analogic.com ([204.178.40.224]:29584 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S263302AbTC0Qx1> convert rfc822-to-8bit; Thu, 27 Mar 2003 11:53:27 -0500
Date: Thu, 27 Mar 2003 12:06:59 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Edgardo Hames <ehames@scdt.frc.utn.edu.ar>
cc: linux-kernel@vger.kernel.org
Subject: Re: Error accessing memory between 0xc0000 and 0x100000
In-Reply-To: <200303271325.30514.ehames@scdt.frc.utn.edu.ar>
Message-ID: <Pine.LNX.4.53.0303271201540.5879@chaos>
References: <200303251308.36565.ehames@scdt.frc.utn.edu.ar>
 <Pine.LNX.4.53.0303251119420.29139@chaos> <200303271325.30514.ehames@scdt.frc.utn.edu.ar>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Mar 2003, Edgardo Hames wrote:

> El Mar 25 Mar 2003 13:21, Richard B. Johnson escribió:
>
> > On Tue, 25 Mar 2003, Edgardo Hames wrote:
> > > Hi everybody. I'm trying to write a simple device driver to read and
> > > write memory at addresses beween 0xc0000 and 0x100000, but when I try to
> > > load the module I get the following error:
> >
> > Check out ioremap(). Although the addresses you show are already
> > mapped, you need to access them with the "cookie" returned from
> > ioremap().
>
> I tried ioremap'ing the addresses and now it doesn't oops, but I keep reading
> 255 no matter what I write to that address. I have no device at that
> addresses, but what I'm trying to do is reading and writing to that memory
> area like it was a file.
>
> Thanks,
> Edgardo

Do you know that there are RAM where you are reading/writing?
If there is nothing there, your read will have all bits set.

Also, the cookie returned from ioremap() is __not__ a pointer!
You need to read/write using the appropriate macros. See
../linux-n.n/include/asm/io.h for details.



Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

