Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267544AbTA3Qas>; Thu, 30 Jan 2003 11:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267545AbTA3Qas>; Thu, 30 Jan 2003 11:30:48 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:12168
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267544AbTA3Qar>; Thu, 30 Jan 2003 11:30:47 -0500
Subject: Re: BUG: [2.4.18+] IDE Race Condition
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ross Biro <rossb@google.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E356854.1090100@google.com>
References: <3E356854.1090100@google.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1043948091.31674.8.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 30 Jan 2003 17:34:52 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-01-27 at 17:11, Ross Biro wrote:
> The condition
> if (masked_irq && hwif->irq != masked_irq)
> in ide_do_request should be replaced with
> if (!masked_irq || hwif->irq != masked_irq)
> in two places.

Which would also shorten to if (hwif->irq != masked_irq) it seems

