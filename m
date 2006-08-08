Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932535AbWHHIH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932535AbWHHIH3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 04:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932558AbWHHIH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 04:07:29 -0400
Received: from mail.baslerweb.com ([145.253.187.130]:39056 "EHLO
	mail.baslerweb.com") by vger.kernel.org with ESMTP id S932535AbWHHIH2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 04:07:28 -0400
MIME-Version: 1.0
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Tue, 8 Aug 2006 10:07:08 +0200
Message-ID: <C5A8FDEFF7647F4C9CB927D7DEB30773019AC43C@AHR075S.basler.corp>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.18-rc4 jffs2 problems
Thread-index: Aca6urg6oV298rgyTjWXfvBATJKIMQABdoDQ
From: "Koeller, T." <Thomas.Koeller@baslerweb.com>
To: "Artem B. Bityutskiy" <dedekind@yandex.ru>,
       "Richard Purdie" <rpurdie@rpsys.net>
Cc: "linux-mtd" <linux-mtd@lists.infradead.org>,
       "LKML" <linux-kernel@vger.kernel.org>
X-SecurE-Mail-Gateway: Version: 5.00.3.1 (smtpd: 6.53.8.7) Date: 20060808080427Z
Subject: RE: 2.6.18-rc4 jffs2 problems
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: linux-mtd-bounces@lists.infradead.org 
> [mailto:linux-mtd-bounces@lists.infradead.org] On Behalf Of 
> Artem B. Bityutskiy
> Sent: Tuesday, August 08, 2006 9:15 AM
> To: Richard Purdie
> Cc: linux-mtd; LKML
> Subject: Re: 2.6.18-rc4 jffs2 problems
> 
> Richard Purdie wrote:
> > JFFS2 error: (472) jffs2_get_inode_nodes: short read at 
> 0x074e84: 68 instead of 380.
> > JFFS2 error: (472) jffs2_do_read_inode_internal: cannot 
> read nodes for ino 153, returned error is -5
> > 
> This looks like an MTD problem, not JFFS2.
> 
> Try to reproduce this on the mtdram flash emulator. Also, 
> please, check 
> if mtd->writesize is correct at your setup (I suppose your 
> flash is NOR 
> and it has to be 1).
> 
> -- 
> Best Regards,
> Artem B. Bityutskiy,
> St.-Petersburg, Russia.
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
> 

I am currently updating a nand flash driver that used to work
with kernel 2.6.16-rc4 to current git. Doing so, I encountered
exactly this problem, but suspected a problem with my driver,
of course. However, so far I have not been able to find out
what's wrong. Another symptom I observed is that when doing
'ls -l /dev/mtdblock0', the size displayed is zero.

tk
----------------------------------------------- 
Thomas Koeller, Software Development 

Basler Vision Technologies 
An der Strusbek 60-62 
22926 Ahrensburg 
Germany 

Tel +49 (4102) 463-390 
Fax +49 (4102) 463-46390

mailto:Thomas.Koeller@baslerweb.com 
http://www.baslerweb.com 

