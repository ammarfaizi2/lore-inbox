Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265200AbUAWCAb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 21:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265215AbUAWCAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 21:00:31 -0500
Received: from ns1.s2io.com ([216.209.86.101]:17287 "EHLO ns1.s2io.com")
	by vger.kernel.org with ESMTP id S265200AbUAWCA2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 21:00:28 -0500
From: "Leonid Grossman" <leonid.grossman@s2io.com>
To: "'Linux Kernel'" <linux-kernel@vger.kernel.org>
Cc: "'ravinandan arakali'" <ravinandan.arakali@s2io.com>
Subject: pci_alloc_consistent()
Date: Thu, 22 Jan 2004 17:59:47 -0800
Message-ID: <000101c3e154$949dd520$7310100a@S2IOtech.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
In-reply-to: <20040122234803.GC18316@widomaker.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Spam-Score: -106.2
X-Spam-Outlook-Score: ()
X-Spam-Features: BAYES_01,IN_REP_TO,QUOTED_EMAIL_TEXT,USER_IN_WHITELIST
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are there any known issues with pci_alloc_consistent() allocating more
than 1MB?
One of our developers seems to recall a thread but we can't find it...

We are using pci_alloc_consistent() in our 10GbE driver, to allocate
memory for DMA transfers between
host and device. 
If we allocate under 1MB, everything works fine. When the allocation is
more than 1 MB, allocation call does not return any failure but some
data corruption seems to take place beyond the 1 MB space. 

Is this a known problem? The system is 2-way Itanium, running 2.4.21
kernel.

Thanks in advance, Leonid


> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
> Charles Shannon Hendrix
> Sent: Thursday, January 22, 2004 3:48 PM
> To: Linux Kernel
> Subject: Re: Nvidia drivers and 2.6.x kernel
> 
> 
> Thu, 22 Jan 2004 @ 12:12 +0000, Kieran said:
> 
> > How strange. I run slack 9.1 and 2.6.1, just grabbed the 4496
> > pre-patched file from http://www.sh.nu/download/nvidia/ and 
> installed it 
> > as I would on 2.4. Works a charm.
> 
> How's the performance?
> 
> I have found the 4496 and 5328 drivers lowered my performance.
> 
> 5328 is supposed to be faster mip-mapping and faster when 
> running with vertical blank sync, but I didn't see it myself. 
>  It also caused quite a few sound artifacts from my Live! sound card.
> 
> Anyone done a driver-by-driver benchmark?
> 
> I got tired of it, but here's the performance order on my 
> system from fastest to slowest:
> 
> 4620
> 3xxx (last stable 3xxx driver)
> 4496
> 5328
> 
> Mostly what I look for are not benchmark numbers, but notable 
> hesitation in programs and interactive response, and side 
> effects like bad sound artifacts.
> 
> 
> 
> 
> -- 
> UNIX/Perl/C/Pizza____________________s h a n n o n@wido !SPAM 
> maker.com
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

