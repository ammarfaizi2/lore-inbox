Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267553AbTA3Q5W>; Thu, 30 Jan 2003 11:57:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267558AbTA3Q5W>; Thu, 30 Jan 2003 11:57:22 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:20104
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267553AbTA3Q5W>; Thu, 30 Jan 2003 11:57:22 -0500
Subject: Re: BUG: [2.4.18+] IDE Race Condition
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ross Biro <rossb@google.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E3959CA.5040907@google.com>
References: <3E356854.1090100@google.com>
	 <1043948091.31674.8.camel@irongate.swansea.linux.org.uk>
	 <3E3959CA.5040907@google.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1043949690.31674.10.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 30 Jan 2003 18:01:30 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-01-30 at 16:58, Ross Biro wrote:
> With the assumption that hwif->irq != 0 which is implicit now.  Perhaps 
> we should make the assumption explicit,
> 
> if (unlikely(hwif->irq == 0)) {
>     BUG();
> }
> if (hwif->irq != masked_irq) ....
> 

Actually I fixed the IRQ 0 assumption in that code while I was at it 8)

