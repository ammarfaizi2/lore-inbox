Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262694AbTJ3Rgr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 12:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262703AbTJ3Rgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 12:36:47 -0500
Received: from main.gmane.org ([80.91.224.249]:63186 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262694AbTJ3Rgp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 12:36:45 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: WG:  EIO DM-8401H ATA133 IDE Controller Card ( Silicon Image
 Chip ?!?)
Date: Thu, 30 Oct 2003 20:36:43 +0300
Message-ID: <20031030203643.56474e23.vsu@altlinux.ru>
References: <S261606AbTJ3JsA/20031030094800Z+24028@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Newsreader: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-alt-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Oct 2003 10:47:52 +0100 Michael Labuschke wrote:

> Hi
> I bought an IDE Controller the other day ( non RAID version)
> See  http://www.ivmm.com/eio/products_dm8401h.html
> As ist stated there should be linux support.
> No the problem is
> (output from  cat /proc/pci
> 
>   Bus  0, device  17, function  0:
>     Unknown mass storage controller: PCI device 1283:8212 (Integrated
> Technology Express, Inc.) (rev 17).
>       IRQ 11.
>       Master Capable.  No bursts.  Min Gnt=8.Max Lat=8.
>       I/O at 0xd800 [0xd807].
>       I/O at 0xdc00 [0xdc03].
>       I/O at 0xe000 [0xe007].
>       I/O at 0xe400 [0xe403].
>       I/O at 0xe800 [0xe80f].

http://www.ite.com.tw/productInfo/Download.html#IT8212%20ATA133%20Controller

The driver is complete shit... they do locking this way:

...
static spinlock_t io_request_lock	= SPIN_LOCK_UNLOCKED;
...

