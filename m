Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316819AbSEVBJm>; Tue, 21 May 2002 21:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316820AbSEVBJl>; Tue, 21 May 2002 21:09:41 -0400
Received: from fep02-mail.bloor.is.net.cable.rogers.com ([66.185.86.72]:16232
	"EHLO fep02-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id <S316819AbSEVBJk>; Tue, 21 May 2002 21:09:40 -0400
Message-ID: <008b01c2012d$69db21c0$0601a8c0@CHERLYN>
From: =?iso-8859-1?Q?Andr=E9_Bonin?= <kernel@bonin.ca>
To: "Greg KH" <greg@kroah.com>, <linux-usb-devel@lists.sourceforge.net>
Cc: <linux-kernel@vger.kernel.org>, <Linux-usb-users@lists.sourceforge.net>
In-Reply-To: <20020520223132.GC25541@kroah.com>
Subject: Re: What to do with all of the USB UHCI drivers in the kernel?
Date: Tue, 21 May 2002 21:10:04 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0088_01C2010B.E09B7E30"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at fep02-mail.bloor.is.net.cable.rogers.com from [24.112.234.58] using ID <bonin@rogers.com> at Tue, 21 May 2002 21:09:32 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0088_01C2010B.E09B7E30
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit


----- Original Message -----
From: "Greg KH" <greg@kroah.com>
To: <linux-usb-devel@lists.sourceforge.net>
Cc: <linux-kernel@vger.kernel.org>; <Linux-usb-users@lists.sourceforge.net>
Sent: Monday, May 20, 2002 6:31 PM
Subject: What to do with all of the USB UHCI drivers in the kernel?


>
> Ok, now that 2.5.16 is out, we have a total of 4 different USB UHCI
> controller drivers in the kernel!  That's about 3 too many for me :)
>
> So what to do?  I propose the following:
>
>   From now until July 1, I want everyone to test out both the uhci-hcd
>   and usb-uhci-hcd drivers on just about every piece of hardware they
>   can find.  This includes SMP, UP, preempt kernels, big and little
>   endian machines, and loads of different types of USB devices.

The UHCI driver never recognizes my hardware.  The OHCI driver (in the
2.4.18 kernel) does however.  My Asus A7M266-D doesn't have an onboard USB
but they ship an add-on card with the motherboard (made by Asus).

I attached the relevant syslogs and kernel logs for a boot-up with the UHCI
driver.  The USB startup is towards the end.

List of USB devices attached:

1) AsusTek USB enhanced Host Controller
2) Logitech USB Camera (QuickCam Web)
3) NEC PCI to USB Open Host Controller
4) NEC PCI to USB Open Host Controller
5) USB Root Hub x2 (Must belong to the USB hub on my monitor, ViewSonic
G773-2)
6) USB Root Hub x2 (Must belong to the USB hub on my monitor, ViewSonic
G773-2)
7) Microsoft IntelliMouse Optical (imPs2)

Thanks!

>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

*****************************************************
André Bonin
Computer Engineering Technologist
Ottawa (Ontario)
Canada
*****************************************************

------=_NextPart_000_0088_01C2010B.E09B7E30
Content-Type: application/octet-stream;
	name="syslog"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="syslog"

May 21 20:36:20 Cherlyn kernel: klogd 1.4.1#10, log source =3D =
/proc/kmsg started.=0A=
May 21 20:36:20 Cherlyn kernel: uhci.c: USB Universal Host Controller =
Interface driver v1.1=0A=
May 21 20:36:20 Cherlyn kernel: usb.c: registered new driver usblp=0A=
May 21 20:36:20 Cherlyn kernel: printer.c: v0.12: USB Printer Device =
Class driver=0A=
May 21 20:36:20 Cherlyn kernel: Initializing USB Mass Storage driver...=0A=
May 21 20:36:20 Cherlyn kernel: usb.c: registered new driver usb-storage=0A=
May 21 20:36:20 Cherlyn kernel: USB Mass Storage support registered.=0A=
May 21 20:36:20 Cherlyn kernel: usb.c: registered new driver hiddev=0A=
May 21 20:36:20 Cherlyn kernel: usb.c: registered new driver hid=0A=
May 21 20:36:20 Cherlyn kernel: hid-core.c: v1.31:USB HID core driver=0A=
May 21 20:36:20 Cherlyn kernel: usb.c: registered new driver usbscanner=0A=
May 21 20:36:20 Cherlyn kernel: scanner.c: 0.4.6:USB Scanner Driver=0A=
May 21 20:36:20 Cherlyn kernel: mice: PS/2 mouse device common for all =
mice=0A=
May 21 20:36:21 Cherlyn /usr/sbin/gpm[221]: oops() invoked from =
gpn.c(454)=0A=
May 21 20:36:21 Cherlyn /usr/sbin/gpm[221]: Repeating into ImPS2 =
protocol not yet implemented :-(: File exists=0A=
May 21 20:36:22 Cherlyn lpd[234]: restarted=0A=

------=_NextPart_000_0088_01C2010B.E09B7E30
Content-Type: application/octet-stream;
	name="kern.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="kern.log"

May 21 20:36:20 Cherlyn kernel: Linux version 2.5.17 (root@Cherlyn) (gcc =
version 2.95.4 20011002 (Debian prerelease)) #4 SMP Tue May 21 20:26:15 =
EST 2002=0A=
...=0A=
May 21 20:36:20 Cherlyn kernel: uhci.c: USB Universal Host Controller =
Interface driver v1.1=0A=
May 21 20:36:20 Cherlyn kernel: usb.c: registered new driver usblp=0A=
May 21 20:36:20 Cherlyn kernel: printer.c: v0.12: USB Printer Device =
Class driver=0A=
May 21 20:36:20 Cherlyn kernel: Initializing USB Mass Storage driver...=0A=
May 21 20:36:20 Cherlyn kernel: usb.c: registered new driver usb-storage=0A=
May 21 20:36:20 Cherlyn kernel: USB Mass Storage support registered.=0A=
May 21 20:36:20 Cherlyn kernel: usb.c: registered new driver hiddev=0A=
May 21 20:36:20 Cherlyn kernel: usb.c: registered new driver hid=0A=
May 21 20:36:20 Cherlyn kernel: hid-core.c: v1.31:USB HID core driver=0A=
May 21 20:36:20 Cherlyn kernel: usb.c: registered new driver usbscanner=0A=
May 21 20:36:20 Cherlyn kernel: scanner.c: 0.4.6:USB Scanner Driver=0A=
May 21 20:36:20 Cherlyn kernel: mice: PS/2 mouse device common for all =
mice=0A=

------=_NextPart_000_0088_01C2010B.E09B7E30--

