Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262296AbUCBWsj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 17:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262297AbUCBWri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 17:47:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:54759 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262184AbUCBWqF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 17:46:05 -0500
Date: Tue, 2 Mar 2004 14:47:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jurriaan <thunder7@xs4all.nl>
Cc: linux-kernel@vger.kernel.org, Matthew Wilcox <willy@debian.org>
Subject: Re: 2.6.3-mm4 / 2.5 Gb memory / sym53c8xx_2 won't boot
Message-Id: <20040302144757.60a0630c.akpm@osdl.org>
In-Reply-To: <20040302185518.GA2886@middle.of.nowhere>
References: <20040302185518.GA2886@middle.of.nowhere>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jurriaan <thunder7@xs4all.nl> wrote:
>
> After upgrading my memory from 1 Gb to 2.5 Gb my 2.6.3-mm4 kernel
> wouldn't boot anymore.
> 
> It hang when detecting the scsi-chip.
> I had in my .config:
> 
> CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
> 
> the default value.
> 
> The scsi bus kept resetting before detecting any devices. Interestingly,
> 2.6.3-mm1 did boot with that .config setting. Once I recompiled
> 2.6.3-mm4 with 
> 
> CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=0
> 
> it booted (and worked) fine.
> 
> So, something regressed in 2.6.3-mm4 versus 2.6.3-mm1, so the default
> setting didn't work correctly anymore.

I don't know what caused this - there are a few patches in there which
touch the DMA and BIO highmem areas.  Plus always the latest scsi
development tree.

> If there is anything I can test, please let me know.

Could you test Linus's current tree?  The first link at
http://www.kernel.org/pub/linux/kernel/v2.5/testing/cset/.

If this bug hasn't hit Linus's tree yet, it will soon do so...
