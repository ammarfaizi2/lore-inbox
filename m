Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313309AbSDJQmG>; Wed, 10 Apr 2002 12:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313314AbSDJQmF>; Wed, 10 Apr 2002 12:42:05 -0400
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:13746 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP
	id <S313309AbSDJQmF>; Wed, 10 Apr 2002 12:42:05 -0400
Date: Wed, 10 Apr 2002 09:40:22 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: 2.5.8-pre3: kernel BUG at usb.c:849!
 (preempt_count 1)
To: Johannes Erdfelt <johannes@erdfelt.com>,
        Duncan Sands <duncan.sands@math.u-psud.fr>
Cc: Kernel List <linux-kernel@vger.kernel.org>, rml@tech9.net,
        linux-usb-devel@lists.sourceforge.net
Message-id: <06da01c1e0ae$69106ce0$6800000a@brownell.org>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
In-Reply-To: <E16vHsQ-0000Jy-00@baldrick> <20020410114144.N8314@sventech.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > UP x86 K6 system running 2.5.8-pre3 with preemption.
> > Using usb-uhci.  I got the following bug when powering off:
> >
> > usb.c: USB disconnect on device 3
> > ...

Does the same BUG happen with "uhci"?

And what usb device driver(s) were supposed to have stopped
using "device 3"?  I've only noticed such device refcounting bugs
being caused by the USB device drivers with bad disconnect()
routines, not usbcore or any of the host controller drivers, but of
course that can change.

- Dave



