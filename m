Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964933AbVIHTkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964933AbVIHTkR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 15:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964963AbVIHTkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 15:40:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2957 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964933AbVIHTkP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 15:40:15 -0400
Date: Thu, 8 Sep 2005 12:39:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Michael Thonke <iogl64nx@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-mm2
Message-Id: <20050908123930.5a28f3ff.akpm@osdl.org>
In-Reply-To: <432072C5.8020200@gmail.com>
References: <20050908053042.6e05882f.akpm@osdl.org>
	<432072C5.8020200@gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Thonke <iogl64nx@gmail.com> wrote:
>
> Hello Andrew,
> 
> I found a problem regarding to multi device support (Linux software Raid).
> 
> The problem first appears now in 2.6.13-mm2, that the kernel didn't initialize the md devices.
> 
> 2.6.13-mm1 works very well, and everything is okay.
> 
> Also one strange thing I found was that my SATA devices were initialized a-sync/disordered e.g
> 
> SATA1 with one hdd then something like USB and IPv4 and such and at least SATA3: with 2nd hdd.
> That I've never seen this order init order before. Seems to be mixed all around.
> 
> I tried irqpoll,pci=routeirq with no success.
> 
> I can't provide some logs, because I can't grep the dmesg since it doesn't boot.
> 
> There are changes in libata driver for sata_nv? Or md driver changes that cause that?
> 

There are changes to both sata_nv and to md in 2.6.13-mm2.  To isolate them
it would be great of you could apply 

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13/2.6.13-mm2/broken-out/linus.patch

to 2.6.13 and see if the problem still happens.  That will separate out the
md changes which are still in -mm.

Thanks.
