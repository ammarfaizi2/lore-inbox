Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268308AbUHLCAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268308AbUHLCAP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 22:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268330AbUHLCAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 22:00:14 -0400
Received: from scl-ims.phoenix.com ([216.148.212.222]:39121 "EHLO
	scl-ims.phoenix.com") by vger.kernel.org with ESMTP id S268308AbUHLCAK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 22:00:10 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Re: [linux-usb-devel] USB shared interrupt problem
Date: Wed, 11 Aug 2004 19:00:09 -0700
Message-ID: <5F106036E3D97448B673ED7AA8B2B6B3015B6477@scl-exch2k.phoenix.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [linux-usb-devel] USB shared interrupt problem
thread-index: AcR81aVwROXttqhZRwK/tlAWvvzluQDOOjdw
From: "Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, "Pete Zaitcev" <zaitcev@redhat.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <linux-usb-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 12 Aug 2004 02:00:09.0250 (UTC) FILETIME=[18864020:01C48010]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>In SMM mode the USB controller isn't connected to the PCI IRQ 
>line. That
>is one thing that is done in the changeover. It also seems to 
>be causing
>problems with EHCI hand over on NVidia boards still.
>

Well, in my case I have legacy free BIOS, so it is not in SMM mode,
and USB controller seems to be connected to PCI IRQ line and generating
interrupts. For UHCI though patch resets the controller, thus disabling 
interrupts, and fixing the problem. It might not work for OHCI in legacy
free
system, since there is no reset/interrupt disable for it in the patch.

Let me know if I missed something...

BTW, I talked to BIOS developers on this. 
They basically recommended 2 possible solutions:
 - try to not share UHCI irq line or
 - enable native support (or at list disable interrupts) early during
boot.

Aleks.
