Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268454AbTGIRUk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 13:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268460AbTGIRUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 13:20:40 -0400
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:50441 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id S268454AbTGIRUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 13:20:37 -0400
From: "Alan Shih" <alan@storlinksemi.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: Question regarding DMA xfer to user space directly
Date: Wed, 9 Jul 2003 10:35:15 -0700
Message-ID: <ODEIIOAOPGGCDIKEOPILKEBGCMAA.alan@storlinksemi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <1057677742.4358.36.camel@dhcp22.swansea.linux.org.uk>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2727.1300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Next question would be what are the steps that the driver need to ping user
pages before setting up the xfer?

Thanks.

-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
Sent: Tuesday, July 08, 2003 8:22 AM
To: Alan Shih
Cc: Linux Kernel Mailing List
Subject: Re: Question regarding DMA xfer to user space directly


On Maw, 2003-07-08 at 15:50, Alan Shih wrote:
> Is there a provision in MM for DMA transfer to user space directly without
> allocating a kernel buffer?

Yes. Its used both for O_DIRECT I/O (direct to disk I/O from userspace)
and for things like tv capture cards. The kernel allows a driver to pin
user pages and obtain mappings for them. Note that for large systems
user pages may be above the 32bit boundary so you need DAC capable
hardware to get the best results

