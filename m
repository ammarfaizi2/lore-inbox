Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132616AbRDBGtb>; Mon, 2 Apr 2001 02:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132618AbRDBGtV>; Mon, 2 Apr 2001 02:49:21 -0400
Received: from atacama.four-d.de ([129.247.190.4]:60678 "EHLO four-d.de")
	by vger.kernel.org with ESMTP id <S132616AbRDBGtN>;
	Mon, 2 Apr 2001 02:49:13 -0400
Date: Mon, 2 Apr 2001 08:46:47 +0200 (=?X-UNKNOWN?Q?Westeurop=E4ische_Sommerzeit?=)
From: Thomas Pfaff <tpfaff@gmx.net>
To: Steven Walter <srwalter@yahoo.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.2: System clock slows down under load
In-Reply-To: <F0E13277A26BD311944600500454CCD029BEBA@antarctica.intern.net>
Message-ID: <Pine.WNT.4.33.0104020837110.215-100000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Mar 2001, Steven Walter wrote:

> On Tue, Mar 27, 2001 at 01:42:39PM +0200, Thomas Pfaff wrote:
> > Hi all,
> >
> > i decided to make a test for the 2.4 kernel on my old hardware (Gigabyte
> > EISA/VLB with an AMD 486 DX4 133). The kernel boots fine but there is one
> > strange thing: The system clock slows down under load, after a make
> > dep in the linux src directory it is about 2 minutes behind. This appears
> > both in 2.4.1 and in 2.4.2 (I have not tried 2.4.0 yet).
> >
> > I have attached a gzipped dmesg.
> >
> > Any ideas ?
>
> I notice that you're using fbcon from your dmesg.  There was a
> discussion about this a while back, and it was determined that fbcon
> runs with interrupts disabled for unhealthily long period of time.  This
> causes it to miss timer interrupts, and the system lock get behind.  See
> if this slowdown occurs with vgacon.  If it does, its probably just a
> cheap crystal on the motherboard.
>
> --
> -Steven
> Freedom is the freedom to say that two plus two equals four.
>
>
>

You are right. If i compile with vgacon it works fine.

I would be really glad if vesa fbcon in 2.4 would run without that problem
like in all 2.2 kernels i have installed. It is the easiest way to get X
and virtual consoles on my S3 graphic card.

Thanks,

Thomas


