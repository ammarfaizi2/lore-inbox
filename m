Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263146AbTESTa2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 15:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263131AbTESTa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 15:30:27 -0400
Received: from web41606.mail.yahoo.com ([66.218.93.106]:49759 "HELO
	web41606.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263185AbTESTaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 15:30:24 -0400
Message-ID: <20030519194317.20999.qmail@web41606.mail.yahoo.com>
Date: Mon, 19 May 2003 12:43:17 -0700 (PDT)
From: Pawan Deepika <pawan_deepika@yahoo.com>
Subject: [linux 2.4.18] via-rhine.c
To: linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 I am learning device driver only now. I was going
through the source code in via-rhine.c. What I
understand till now is that in Memory-mapped devices,
I/O operation is performed using
read(b/w/l)/write(b/w/l) functions while in IO mapped
devices it is done using in/out(b/w/l). Am I right?

But in via-rhine.c I notice use of inb and outb even
in memory mapped case(code is shown below)

------------------------------------------------------
#ifdef USE_MEM
530 static void __devinit enable_mmio(long ioaddr, int
chip_id)
531 {
532         int n;
533         if (chip_id == VT3043 || chip_id ==
VT86C100A) {
534                 /* More recent docs say that this
bit is reserved ... */
535                 n = inb(ioaddr + ConfigA) | 0x20;
536                 outb(n, ioaddr + ConfigA);
537         } else if (chip_id == VT6102) {
538                 n = inb(ioaddr + ConfigD) | 0x80;
539                 outb(n, ioaddr + ConfigD);
540         }
541 }
542 #endif
-----------------------------------------------------

Can anyone tell me how does it work here? Also, don't
we need to allocate I/O ports(using request_region() )
before performing any inb/outb operations?

Please advise.

Thanks & regards,
Deepika

__________________________________
Do you Yahoo!?
The New Yahoo! Search - Faster. Easier. Bingo.
http://search.yahoo.com
