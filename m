Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132264AbRCVX6t>; Thu, 22 Mar 2001 18:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132257AbRCVX6b>; Thu, 22 Mar 2001 18:58:31 -0500
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:14749 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S132246AbRCVX41>; Thu, 22 Mar 2001 18:56:27 -0500
Date: Thu, 22 Mar 2001 15:53:21 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: USB oops Linux 2.4.2ac6
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Message-id: <176a01c0b32b$47e305c0$6800000a@brownell.org>
MIME-version: 1.0
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset="iso-8859-1"
Content-transfer-encoding: 7bit
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <20010228175009.A27630@devserv.devel.redhat.com>
 <3ABA8737.82BD7ACA@cypress.com>
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I found the problem.
> CONFIG_DEBUG_SLAB "Debug memory allocation"
> in the 2.4.2-ac series doesn't work with USB.
> 
> 2.4.2-ac5 just booted and found the mouse correctly.
> On to ac-21 now...

I just glanced at Alan's change list, it didn't have patches
that seemed to cover that (vs ac20).

You might see what sort of luck you have with the patches
I posted to linux-usb-devel earlier today.  At least both
usb-ohci and usb-uhci enumerated even after configuring
in slab debugging ... but there are bugs yet to be found.
Maybe it deserves a CONFIG_DEBUG_PCI_POOL to
decouple autopoisoning from CONFIG_DEBUG_SLAB.


> Did David Brownell's patch to disable OHCI loading
> on the AMD-756 make it into the source trees?

It's been sent to Linus.  Unless/until someone learns the
vendor fix and implements it, it seems to be the best way
to prevent the 756-specific USB problems (happening
most with lowspeed devices like mice).

- Dave


