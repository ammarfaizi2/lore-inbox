Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261829AbSK3VSw>; Sat, 30 Nov 2002 16:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262838AbSK3VSw>; Sat, 30 Nov 2002 16:18:52 -0500
Received: from smtp-03.inode.at ([62.99.194.5]:22970 "EHLO smtp.inode.at")
	by vger.kernel.org with ESMTP id <S261829AbSK3VSv> convert rfc822-to-8bit;
	Sat, 30 Nov 2002 16:18:51 -0500
Content-Type: text/plain; charset=US-ASCII
From: Patrick Petermair <black666@inode.at>
Reply-To: black666@inode.at
To: linux-kernel@vger.kernel.org
Subject: Re: Problem with via82cxxx and vt8235
Date: Sat, 30 Nov 2002 22:27:23 +0100
User-Agent: KMail/1.4.3
References: <200211300129.32580.black666@inode.at> <1038667380.17209.2.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1038667380.17209.2.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211302227.23253.black666@inode.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox:
> On Sat, 2002-11-30 at 00:29, Patrick Petermair wrote:
> > Hi!
> >
> > I have a MSI KT3Ultra2 Motherboard with a VT8235 southbridge. I'm
> > currently running kernel 2.4.19 - unfortunately it doesn't detect the
> > southbridge, so I cannot enable dma.
> > I tried the patch from Vojtech Pavlik (via82cxxx), but then it hangs
> > at boot:
>
> Try the -ac tree firstly

Thanks Alan, now dma works perfect!
How come this code isn't in the official 2.4.20 kernel?

The only strange thing now is that uname doesn't know my cpu:

starbase:/# uname -a
Linux starbase 2.4.20-ac1 #1 Sam Nov 30 18:43:15 CET 2002 i686 unknown 
unknown GNU/Linux
starbase:/#

But it gets recognized during boot:

starbase:/# dmesg | grep -i AMD
CPU: AMD Athlon(tm) XP 2200+ stepping 00
starbase:/#

starbase:/# cat /proc/cpuinfo | grep -i AMD
vendor_id       : AuthenticAMD
model name      : AMD Athlon(tm) XP 2200+
starbase:/#


But hey, I can live with that - I have dma now :-)
Just curious, what's causing this.

Thanks so much...
Patrick




