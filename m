Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267561AbUHPL7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267561AbUHPL7o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 07:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267563AbUHPL7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 07:59:44 -0400
Received: from the-village.bc.nu ([81.2.110.252]:45795 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267561AbUHPL7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 07:59:42 -0400
Subject: Re: High CPU usage (up to server hang) under heavy I/O load
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mark Watts <m.watts@eris.qinetiq.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200408161013.13829.m.watts@eris.qinetiq.com>
References: <20040813140229.4F48B2FC2C@illicom.com>
	 <1092435364.24960.35.camel@localhost.localdomain>
	 <200408161013.13829.m.watts@eris.qinetiq.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092653845.20528.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 16 Aug 2004 11:57:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-08-16 at 10:13, Mark Watts wrote:
> Would this also mean that if I stick a 64bit SATA raid card (a 3Ware 8506-4LP 
> in this case) into a 32bit pci slot, then I/O is always going to suck badly?
> 
> ... cos I do, and I/O sucks :)

Seperate issue.

64bit DMA is 64bit addressing (ie can DMA from above 4GB). 64bit wide
slot is double the speed for transfers. The 3ware 8xxx I thought could
do 64bit addressing although the driver seems to indicate it cannot,
so with over 4Gb it would hurt.

