Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278695AbRKFIrM>; Tue, 6 Nov 2001 03:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278701AbRKFIrC>; Tue, 6 Nov 2001 03:47:02 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:20964 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S278673AbRKFIqt>; Tue, 6 Nov 2001 03:46:49 -0500
Date: Tue, 6 Nov 2001 10:57:28 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: <matt@eee.nott.ac.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: PCI interrupts 
Message-ID: <Pine.LNX.4.33.0111061041001.7663-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Clark said...
>(b) if it shouldn't have a unique number do I have to share the
>interrupt (with the usb controller) or can I change it to
>another address (by writing to the config space?)?
>If I have to share it how do I do this- (my card will generate a
>lot of interrupt traffic)?.
Assuming i386

>From my limited knowledge about the IRQ handling subsystems, you would
call arch/i386/irq.c:request_irq() with the appropriate flags, ie
SA_SHIRQ and any others you may require. I *think* you might also be able
to do dev->irq = irq_num and then do your request_irq() but you might
require a bit of voodoo inbetween.

Regards,
	Zwane Mwaikambo

