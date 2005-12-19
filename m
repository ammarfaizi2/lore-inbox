Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbVLSPKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbVLSPKh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 10:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbVLSPKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 10:10:37 -0500
Received: from EXCHG2003.microtech-ks.com ([65.16.27.37]:44896 "EHLO
	EXCHG2003.microtech-ks.com") by vger.kernel.org with ESMTP
	id S932157AbVLSPKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 10:10:37 -0500
From: "Roger Heflin" <rheflin@atipa.com>
To: "'Jan Engelhardt'" <jengelh@linux01.gwdg.de>
Cc: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: Dianogsing a hard lockup
Date: Mon, 19 Dec 2005 09:19:06 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-Index: AcYDOMoUoy7x89o8TkiE6QBb3WXdBABdokog
In-Reply-To: <1134844883.11227.11.camel@mindpipe>
Message-ID: <EXCHG2003SAQV6uPDVn00000602@EXCHG2003.microtech-ks.com>
X-OriginalArrivalTime: 19 Dec 2005 15:04:45.0641 (UTC) FILETIME=[8C4DF390:01C604AD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Lee Revell
> Sent: Saturday, December 17, 2005 12:41 PM
> To: Jan Engelhardt
> Cc: Linux Kernel Mailing List
> Subject: Re: Dianogsing a hard lockup
> 
> On Sat, 2005-12-17 at 17:09 +0100, Jan Engelhardt wrote:
> > Hi list,
> > 
> > 
> > some time after I load drivers (any, rt2500 or via ndiswrap) for a 
> > rt2500-based wlan card, the box locks up hard. Sysrq does 
> not work, so 
> > I suppose it is during irq-disabled context. How could I find out 
> > where this happens?
> 
> 
> First, stick to rt2500 as you won't get help with binary only 
> drivers here.
> 
> Try to reproduce the problem from the console, you're more 
> likely to get a usable Oops.
> 
> Check the driver code & make sure it can't get stuck looping 
> in the interrupt handler due to an unhandled IRQ.  Add printks.
> 
> Finally report it to the rt2500 maintainer.

Jan,

I got the rt2500usb driver to blow up nicely if I used the
default ieee* routines from the kernel and not the ones that
came with the rt2500 drivers, you might want to verify which
ieee* that you are using.  Using the ones that came with the
rt2500 seem to work, or at least not crash the kernel out.

                          Roger

