Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265575AbRGOCHp>; Sat, 14 Jul 2001 22:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265647AbRGOCHf>; Sat, 14 Jul 2001 22:07:35 -0400
Received: from 64.5.206.104 ([64.5.206.104]:7174 "EHLO
	terbidium.openservices.net") by vger.kernel.org with ESMTP
	id <S265575AbRGOCH2>; Sat, 14 Jul 2001 22:07:28 -0400
Date: Sat, 14 Jul 2001 22:07:17 -0400 (EDT)
From: Ignacio Vazquez-Abrams <ignacio@openservices.net>
To: <aset@bellatlantic.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux USB boot hang
In-Reply-To: <3B509CA6.6E7EE91@bellatlantic.com>
Message-ID: <Pine.LNX.4.33.0107142205040.3475-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.7 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Jul 2001 aset@bellatlantic.com wrote:

> Hello,
>
> I compiled and installed Linux-2.4.5smp on a dual 300 MHz Pentium II
> running Red Hat 7.0 with gcc 2.96. The motherboard has two sets of USB
> headers but there are no USB ports. If I configure the kernel with USB
> modules, at boot linux complains repeatedly:
>
>     hub.c: Cannot  enable port 1 of hub 1, disabling port.
>     hub.c: Maybe USB cable is bad?
>     hub.c: Cannot enable port 2 of hub 1, disabling port.
>     hub.c: Maybe USB cable is bad?
>
>  I don't know how to get out of this, so I just wait for it to time out
> to finish booting. If I don't configure the kernel for a USB controller
> then the during the boot process it complains that it can't find the
> usb-uhci module and the boot process hangs at sendmail. Again I wait for
> the time-out for the boot process to finish.  How do I fix this dilemma.
> Is there some way I can modifiy hub.c to stop looking for ports 1 and 2?
>
> Thanks, from a Linux newbie.
>
> Don Werder
> aset@bellatlantic.net

Add "append=nousb" to lilo.conf. RH looks for this and skips loading the USB
module if it exists.

It's not hanging at sendmail; it just can't find the IP address for your
machine.

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>

