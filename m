Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263772AbUHNQSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263772AbUHNQSr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 12:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbUHNQSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 12:18:46 -0400
Received: from the-village.bc.nu ([81.2.110.252]:13787 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S263772AbUHNQSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 12:18:45 -0400
Subject: Re: [PATCH] HPT374 kernel panic - regression in 2.6.8
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <411DF42E.5030504@kmlinux.fjfi.cvut.cz>
References: <411DF42E.5030504@kmlinux.fjfi.cvut.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092496584.27144.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 14 Aug 2004 16:16:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-08-14 at 12:14, Jindrich Makovicka wrote:
> Hello,
> 
> HighPoint 374 driver in 2.6.8 can cause kernel panic on boot with 
> non-33MHz timings because some lines from an older version have been 
> included in the source again. After removing the check, HPT374 works 
> just fine using internal PLL.

The HPT374 only supports 33Mhz timings. If you are overclocking it then
its probably going to mostly work. The lines added are not "from an
older source file" but form a port forwards of long missing and
important fixes from 2.4 that have been there for a long long time.

So the first question is why does your late series HPT37x think its
running at > 33Mhz ? Are you overclocking it ?

Alan
