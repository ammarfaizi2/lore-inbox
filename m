Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129031AbRBHPV1>; Thu, 8 Feb 2001 10:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129290AbRBHPVQ>; Thu, 8 Feb 2001 10:21:16 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:32774 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S129031AbRBHPVC>; Thu, 8 Feb 2001 10:21:02 -0500
Message-ID: <3A82B947.BA4368DE@Hell.WH8.TU-Dresden.De>
Date: Thu, 08 Feb 2001 16:20:39 +0100
From: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Organization: Dept. Of Computer Science, Dresden University Of Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-ac5 i686)
X-Accept-Language: en, de-DE
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PS/2 Mouse/Keyboard conflict and lockup
In-Reply-To: <E14Qm1u-0002nf-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > I'm not sure whether this is related to the ominous ps/2 mouse bug
> > you have been chasing, but this problem is 100% reproducible and
> > very annoying.
> 
> It isnt but it might be related to which 2.2.19pre you are running (if any)

No, at that time I was running 2.4.1-ac5.

> Does downgrading the bios fix it. If so then I suspect you need to talk to
> the BIOS vendor.  You might find that turning off USB legacy keyboard/mouse
> emulation helps too

Downgrading the Bios does fix it, but that just shadows the ACPI bugs that
cause the problem. With 1003 + ACPI, mouse and keyboard both work,
but I've seen spurious scancode problems and keyboard weirdness that I
reported to lkml a week or two ago. 1005D + ACPI completely mess up PS/2
mouse and keyboard and lock them up after a while.

The solution is not to use ACPI until that is fixed. It appears that without
ACPI everything is working perfectly.

-Udo.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
