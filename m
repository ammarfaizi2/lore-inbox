Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbTIEAfz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 20:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbTIEAfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 20:35:55 -0400
Received: from postino4.prima.com.ar ([200.42.0.162]:39685 "HELO
	postino4.prima.com.ar") by vger.kernel.org with SMTP
	id S261369AbTIEAfx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 20:35:53 -0400
Subject: Re: [PATCH] ide_cs w/TCQ
From: Matias Alejo Garcia <kernel@matiu.com.ar>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
In-Reply-To: <200309042304.30885.bzolnier@elka.pw.edu.pl>
References: <1062710823.1794.30.camel@runner>
	 <200309042304.30885.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Message-Id: <1062724903.4325.5.camel@runner>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 04 Sep 2003 21:21:43 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-09-04 at 17:04, Bartlomiej Zolnierkiewicz wrote:

> 3) initialize ide_dma_queued_on to __ide_dma_queued_on()
> 
> because drive->using_dma is checked inside __ide_dma_queud_on,
> but that looks stupid to assign it in DMA-unaware driver :-).

Ok :-) then How it should be done? 3)?

I just found that when I eject the CF I get <see below>
I that already corrected, should I try to solve that?

thanks!
matías

-- 
matías <-> http://matiu.com.ar


Sep  4 16:55:32 runner kernel: Device 'ide2' does not have a release()
function, it is broken and must be fixed.
Sep  4 16:55:32 runner kernel: Badness in device_release at
drivers/base/core.c:85
Sep  4 16:55:32 runner kernel: Call Trace:
Sep  4 16:55:32 runner kernel:  [<c021e9f1>] device_release+0x41/0x50
Sep  4 16:55:32 runner kernel:  [<c01d88e9>] kobject_cleanup+0x29/0x40
Sep  4 16:55:32 runner kernel:  [<c021ed0b>] device_unregister+0xb/0x20
Sep  4 16:55:32 runner kernel:  [<c0238b14>] ide_unregister+0x314/0x850
Sep  4 16:55:32 runner kernel:  [<c0121847>] printk+0x127/0x150
[bla bla bla]


