Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262719AbTKNO50 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 09:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262725AbTKNO50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 09:57:26 -0500
Received: from dsl093-039-041.pdx1.dsl.speakeasy.net ([66.93.39.41]:51164 "EHLO
	raven.beattie-home.net") by vger.kernel.org with ESMTP
	id S262719AbTKNO5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 09:57:24 -0500
Subject: Re: serverworks usb under 2.4.22
From: Brian Beattie <beattie@beattie-home.net>
To: rico-linux-kernel@patternassociates.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031114012426.26647.qmail@patternassociates.com>
References: <20031114012426.26647.qmail@patternassociates.com>
Content-Type: text/plain
Message-Id: <1068821840.835.2.camel@kokopelli>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 14 Nov 2003 09:57:21 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-11-13 at 20:24, rico-linux-kernel@patternassociates.com
wrote:
> >From:	Brian Beattie <beattie@beattie-home.net>
> >Date:	Thu, 13 Nov 2003 19:17:02 -0500
> >...
> >I've got a system with a Super Micro P3 dual processor board.  This
> >board uses the Serverworks chipset and the 2.4.22 kernel is unable to
> >allocate an IRQ when initializing the USB (usb-ohic) interface.  This
> >board works fine under 2.4.20 and 2.4.21.
> 
> Transcript of kernel messages...?

from dmesg:

usb.c: registered new driver hub
host/usb-uhci.c: $Revision: 1.275 $ time 09:19:46 Nov 14 2003
host/usb-uhci.c: High bandwidth mode enabled
host/usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
host/usb-ohci.c: USB OHCI at membase 0xf88a8000, IRQ -19
host/usb-ohci.c: usb-00:0f.2, ServerWorks OSB4/CSB5 OHCI USB Controller
usb.c: new USB bus registered, assigned bus number 1
host/usb-ohci.c: request interrupt -19 failed
usb.c: USB bus 1 deregistered


from lspci

00:0f.2 USB Controller: ServerWorks OSB4/CSB5 USB Controller (rev 04)
(prog-if 10 [OHCI])
        Subsystem: ServerWorks: Unknown device 0220
        Flags: medium devsel, IRQ -19
        Memory at fcafe000 (32-bit, non-prefetchable) [size=4K]
        
-- 
Brian Beattie            | Experienced kernel hacker/embedded systems
beattie@beattie-home.net | programmer, direct or contract, short or
www.beattie-home.net     | long term, available immediately.

"Honor isn't about making the right choices.
It's about dealing with the consequences." -- Midori Koto


