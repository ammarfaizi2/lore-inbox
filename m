Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264950AbTANT04>; Tue, 14 Jan 2003 14:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264983AbTANT04>; Tue, 14 Jan 2003 14:26:56 -0500
Received: from h-64-105-35-14.SNVACAID.covad.net ([64.105.35.14]:12167 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S264950AbTANT0z>; Tue, 14 Jan 2003 14:26:55 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 14 Jan 2003 11:35:42 -0800
Message-Id: <200301141935.LAA00806@adam.yggdrasil.com>
To: felix-linuxkernel@fefe.de, linux-kernel@vger.kernel.org
Subject: Re: usb broken in 2.5?
Cc: greg@kroah.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
>On Tue, Jan 14, 2003 at 03:44:35AM +0100, Felix von Leitner wrote:
>> In 2.5.57 USB does not work. [...]

>This sounds like the old iterrupt routing problem that ACPI causes at
>times, and not a USB problem (the interrupts aren't getting to the
>controller, nothing the USB controller can do about that...)

	In case it helps you to know this, I'm looking into a similar
problem in 2.5.57-58 which may be related to what you (Felix) are
reporting.

	For some reason that I haven't figured out, USB keyboard and
mouse that are recognized in 2.5.56 are not recognized by 2.5.57 or
2.5.58, even though lsusb sees them.  This is the case on the two
different systems that I tried (with a different keyboard and
a different mouse).

	There were no changes to drivers/acpi between 2.5.56 and
2.5.57, and booting with acpi=off does not eliminate this problem.
There were few changes to usb between 2.5.56 and 2.5.57.  So, I
suspect that USB no longer working is a side-effect of some other
change.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

