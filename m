Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289671AbSBSEdp>; Mon, 18 Feb 2002 23:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289685AbSBSEdf>; Mon, 18 Feb 2002 23:33:35 -0500
Received: from mx7.sac.fedex.com ([199.81.194.38]:27910 "EHLO
	mx7.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S289671AbSBSEdV>; Mon, 18 Feb 2002 23:33:21 -0500
Date: Tue, 19 Feb 2002 12:31:35 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: marsaro@interearth.com
Subject: Re: eepro100 slow after reboot (fwd)
Message-ID: <Pine.LNX.4.44.0202191224460.29610-100000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 02/19/2002
 12:33:17 PM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 02/19/2002
 12:33:19 PM,
	Serialize complete at 02/19/2002 12:33:19 PM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Just to shared with you all that comparing the eepro100 vs. e100, the e100
seems more reliable.

I had so much problem with eepro100 running like a turtle everytime after
reboot, but after switching to e100, the problem simply went away!


Thanks,
Jeff
[ jchua@fedex.com ]

---------- Forwarded message ----------
Date: Fri, 4 Jan 2002 22:39:45 -0800
From: Jon <marsaro@interearth.com>
To: Jeff Chua <jeffchua@silk.corp.fedex.com>
Subject: Re: eepro100 slow after reboot

I had a similar problem recently and had to lock the ports down on the Cisco
switch (What I had). Seems that there was sensitivity depending upon which
version of Cisco IOS I flashed to and if I used the eepro (Becker / scyld
driver) or the base (SuSE SLES) e100 driver from Intel. After swaping
drivers and forcing with options= and swapping IOS for a week I found that
e100 works ok with IOS 12.1, eepro worked best on IOS 11.x or 12.1 only if I
forced both the driver and switch. Mind you the system would come up at 100
mbs full-duplex, but when I put load over the wire with ttcp, the switch
would flap until I locked it in IOS using eepro. I also used both SuSE SLES
and RH 7.1, same on all the above.

Regards,

Jon


Regards,

Jon
----- Original Message -----
From: "Jeff Chua" <jeffchua@silk.corp.fedex.com>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
Cc: "Jeff Chua" <jchua@fedex.com>
Sent: Friday, January 04, 2002 8:14 PM
Subject: eepro100 slow after reboot


>
> Linux 2.4.x to 2.4.18pre1 on both HP LH6000r and LH4r has the same
> problem with the eepro100. Network (rcp) became very slow after warn
> reboot.
>
> I've tried both with "modprobe eepro100" (10BT) and "modprobe eepro100
> options=0x30" (100BT) and each time after a warm reboot, the network came
> to a crawl. The only way is to cold reset by power off/on the system.
>
> Here's the card ("modprobe eepro100 options=0x30") ...
>
> eth0: OEM i82557/i82558 10/100 Ethernet, 00:30:6E:01:A8:8D, IRQ 18.
>   Receiver lock-up bug exists -- enabling work-around.
>   Board assembly 506495-096, Physical connectors present: RJ45
>   Primary interface chip i82555 PHY #1.
>   Forcing 100Mbs full-duplex operation.
>   General self-test: passed.
>   Serial sub-system self-test: passed.
>   Internal registers self-test: passed.
>   ROM checksum self-test: passed (0x04f4518b).
>   Receiver lock-up workaround activated.
>
>
> Thanks,
> Jeff
> [ jchua@fedex.com ]
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

