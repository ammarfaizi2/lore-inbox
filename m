Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265644AbTFXCvc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 22:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265641AbTFXCvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 22:51:32 -0400
Received: from www.13thfloor.at ([212.16.59.250]:55426 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S265644AbTFXCva (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 22:51:30 -0400
Date: Tue, 24 Jun 2003 05:05:42 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Brad Tilley <bradtilley@usa.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OS Fails to Load
Message-ID: <20030624030542.GB23390@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
References: <981HFwuLg3008S08.1056399066@uwdvg008.cms.usa.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <981HFwuLg3008S08.1056399066@uwdvg008.cms.usa.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Brad!

On Mon, Jun 23, 2003 at 04:11:06PM -0400, Brad Tilley wrote:
> Hello,
> 
> 50% of the time when I boot RH Linux 9 (2.4.20-18.9) the OS fails to load. The
> failure usually occurs during a period of intense disk activity such as
> 'finding module dependencies' or 'mounting local filesystems'. I can reproduce
> this error with the most recent RH kernel and the kernel that the distro
> originally shipped with and 2.4.21 from Kernel.org built using RH's config
> files. Usually after 4-5 power cycles, the OS loads OK and the machine runs
> fine once it gets going.

I've seen this happen on MDK 8.2 and MDK 9.1 with or
without custom kernel from 2.4.19 - 2.4.20 ...

it seemed to me to be VM related (swapper) but I had no 
time to take a closer look at it ...

you will find many voodoo answers on the net, how this
was cured (like disable usb, change hd, etc ...) but I 
guess this is some kind of VM deadlock, which can be 
triggered by any memory consuming task activated before 
swap is enabled ...

> It's a HP xw4100 with these specs:
> 
> P4 Processor 3.00GHz/800 FSB
> 1.5GB DDR/400 ECC (2x512, 2x256)
> NVIDIA Quadro4 200NVS 64MB AGP
> Ultra320 SCSI Controller
> 18GB Ultra 320 SCSI 15,000rpm Hard Drive (sda)
> 146GB Ultra 320 SCSI 10,000rpm Hard Drive (sdb)
> 48X DVD/CDRW Combo Drive
> 48X CD-RW Drive
> Broadcom Gbit 10/100/1000
> 
> Can someone help me troubleshoot this? I'm at the end of my rope. I have the
> most recent BIOS from HP.

maybe this has been fixed in 2.4.21-rc6 ...

Summary of changes from v2.4.21-rc5 to v2.4.21-rc6
============================================
Andrew Morton <akpm@digeo.com>:
  o Fix IO stalls and deadlocks

if not, you could try to activate magic sys-req and 
dump the current kernel state, or even better, attach
the debugger and have a look whats going on ... 

HTH,
Herbert

> Thanks,
> Brad
> 
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
