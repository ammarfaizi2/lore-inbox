Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273269AbRJQG2i>; Wed, 17 Oct 2001 02:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274766AbRJQG2T>; Wed, 17 Oct 2001 02:28:19 -0400
Received: from ictmac01.ict.uni-karlsruhe.de ([129.13.127.116]:24328 "EHLO
	mail.ict.uni-karlsruhe.de") by vger.kernel.org with ESMTP
	id <S274752AbRJQG2G>; Wed, 17 Oct 2001 02:28:06 -0400
Message-ID: <3BCD2510.9633D2BD@ict.uni-karlsruhe.de>
Date: Wed, 17 Oct 2001 08:28:32 +0200
From: =?iso-8859-1?Q?J=F6rg?= Ziuber <ziuber@ict.uni-karlsruhe.de>
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Thomas Hood <jdthood@mail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP BIOS patch against 2.4.12-ac2
In-Reply-To: <E15t6nz-000205-00@the-village.bc.nu>
		<1003202856.12542.57.camel@thanatos> 
		<3BCBE89C.ADD98E21@ict.uni-karlsruhe.de> <1003268655.12542.67.camel@thanatos>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Hood wrote:
> 
> On Tue, 2001-10-16 at 03:58, Jörg Ziuber wrote:
> > I tested the updated patch against 2.4.12-ac2 on a Sony Vaio PCG-FX205K.
> > You can see in the appendix output, no oops.
> >
> > But, one Problem:
> > If I attach an USB device to the laptop it will not initialize and I get
> > the kernel messages, you will find in the last 10 lines of the output.
> > Amazing: If I cause permament traffic with a working device on IRQ 9
> > (e.g. a ping via eth0), the USB device will be recognized and works,
> > even though muuuuch slower.
> 
> Is this problem related to the PnP BIOS patch?  That is,
> do you have the same problem with a kernel that lacks the
> patch?

Maybe it is related.
This is at least a Sony Vaio problem, because attaching the same USB
device to other PCs with the same (kernel)installation works without
problems.
It was checked to be USB-device-independent with the Vaio (same problem
with any device).
Because USB even works on the Vaio under Windows, the USB developers
(uhci) told me to look in linux-kernel for the PCI/IRQ programmers due
to a potentially broken BIOS ("IRQ routing problem")- that's where I am
now (?).

A kernel without the patch results in the same non-recognition
(non-USB-number-assignment) of the USB device, but when booting I get
errors concerning a multiple reservation of IRQ9. With the patch there
are no errors of that kind (see last mail). And the "feature", that USB
works when the shared interrupt is busy (same effect with unpatched
kernel), makes me feel that there is a IRQ problem, specific to Sony
Vaio. So, the PnP-BIOS-patch is my hope because it cares about Sony Vaio
(BIOS/IRQ?) specials.

Very hopefully,
-- 
J. Ziuber
ziuber@ict.uni-karlsruhe.de
