Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272218AbRIEQTK>; Wed, 5 Sep 2001 12:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272223AbRIEQTB>; Wed, 5 Sep 2001 12:19:01 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:10551 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S272220AbRIEQSx>; Wed, 5 Sep 2001 12:18:53 -0400
Date: Wed, 5 Sep 2001 12:19:14 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200109051619.f85GJEo07592@devserv.devel.redhat.com>
To: reality@delusion.de, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: USB device not accepting new address
In-Reply-To: <mailman.999666181.21742.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.999666181.21742.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have just come across another USB address problem, which happens
> sporadically and is not easy to reproduce.

>   1: [cfefa240] link (00000001) e0 IOC Stalled CRC/Timeo Length=7ff MaxLen=7ff
>   DT1 EndPt=0 Dev=0, PID=69(IN) (buf=00000000)

If usb_set_address() ends in timeouts, something is bad with the
hadrware, most likely. Microcode crash in the device, perhaps.
Someone, I think it was Oliver, posted a patch that retries
usb_set_address(). It may help you, look in linux-usb-devel
archives.

-- Pete
