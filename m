Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318691AbSHVJL6>; Thu, 22 Aug 2002 05:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318693AbSHVJL6>; Thu, 22 Aug 2002 05:11:58 -0400
Received: from mailserver1.hrz.tu-darmstadt.de ([130.83.126.41]:29967 "EHLO
	mailserver1.hrz.tu-darmstadt.de") by vger.kernel.org with ESMTP
	id <S318691AbSHVJL5>; Thu, 22 Aug 2002 05:11:57 -0400
Message-ID: <3D64AB95.DC8FD965@hrzpub.tu-darmstadt.de>
Date: Thu, 22 Aug 2002 11:15:01 +0200
From: Jens Wiesecke <j_wiese@hrzpub.tu-darmstadt.de>
X-Mailer: Mozilla 4.75 [de] (Windows NT 5.0; U)
X-Accept-Language: de
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org, rohan@myeastern.com, jh@ionium.org
Subject: Re: P4 with i845E not booting with 2.4.19 / 3.5.31
References: <3D6245DC.3A189656@hrzpub.tu-darmstadt.de>
		<3D62482D.4030500@myeastern.com>  <3D6355C5.6A51E11E@hrzpub.tu-darmstadt.de> <1029936975.26425.21.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Alan Cox wrote:
> 
> On Wed, 2002-08-21 at 09:56, Jens Wiesecke wrote:
> > Can anybody tell me if there is a possibility to further debug my boot
> > problem, for example enabling  more verbose boot messages ?
> 
> If you have a serial port then yes booting with serial console support
> enabled and something capturing ttyS0 (COM1) will give you data earlier
> than the console is initialized

... sounds like a very good idea but will take a while since I gave away
all my serial port stuff ...

I tested several kernels and now I can say that kernels up to
2.4.19-pre6 do boot on my i845E board (Chaintech 9EJL) only if I pass
mem=512M as parameter at boot time (I use syslinux 1.75 with a floppy).
If I use kernels from 2.4.19-pre7 onwards I can't boot at all even if I
pass mem=512M as parameter. The last kernel I tested was 2.4.20-pre4 and
the problem is the same. 

This behaviour is totally the same as Justin Heesemann reported with his
i845G board. For me it seems that the new i845E and i845G chipsets have
some trouble with the boot code.
As I'm no kernel expert at all I can't tell you if this is due to some
hardware problems e.g. buggy BIOS.

So again my question: Can I do anything to help to debug this problem ?

Best regards
-- 
Jens Wiesecke
Institute for Macromolecular Chemistry

e-mail: j_wiese@hrzpub.tu-darmstadt.de
