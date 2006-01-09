Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbWAINZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbWAINZi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 08:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbWAINZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 08:25:38 -0500
Received: from h-64-105-110-66.cmbrmaor.covad.net ([64.105.110.66]:18468 "EHLO
	mail.w1nr.net") by vger.kernel.org with ESMTP id S1751441AbWAINZh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 08:25:37 -0500
Message-ID: <001c01c61520$2cbba6b0$6d0ea8c0@LoJackOne.LoJack.com>
From: "Mike McCarthy, W1NR" <lists@w1nr.net>
To: "Stan Gammons" <s_gammons@charter.net>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <1136780835.6695.37.camel@falklands.home.pc>
Subject: Re: 64 bit kernel
Date: Mon, 9 Jan 2006 08:25:35 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2670
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I saw a similar issue many years ago that turned out to be a chipset bug. 
This was a PII system that used 16 bit wide modules.  When using only one 
module, the chipset "fooled" the OS into thinking that it was doing 32 bit 
wide operations.  However, it failed at full speed.  Reducing the memory bus 
speed or installing modules in pairs "fixed" the problem.  I suspect a bus 
or memory controller issue rather than the kernel.

The failure mode was exactly as you describe.  It manifested itself as disk 
errors or DMA failures.  Unfortunately the chipset vendor determined that it 
was a silicon bug and said that they would NOT fix it!

Mike

----- Original Message ----- 
From: "Stan Gammons" <s_gammons@charter.net>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Sent: Sunday, January 08, 2006 11:27 PM
Subject: 64 bit kernel


> Hi everyone,
>
> I was wondering if anyone can tell me if the following is a 64 bit
> kernel problem or if it's a BIOS problem.
>
> I have a Gigabyte K8NSC-939 with an AMD64 3200+ (Venice) CPU version F7
> BIOS. When I first got this board, I put a single 512 Mb PC2700 DIMM in
> it from an older Celeron board I had. 32 bit Suse 10.0 and 32 bit FC4
> loaded fine. When I tried the 64 bit version of either, I kept getting
> DMA errors on boot like the HD or controller was bad. After some
> searching I found others with similar problems and they had to use
> "noapic nolapic" kernel boot options to install and boot the OS. That
> worked for me too and I was able to install the OS.
>
> After I upgraded the memory and put 2 512Mb PC3200 DIMMS in the board. I
> tried a 64 bit install again. This time I no longer had to use the
> "noapic nolapic" options. With a single DIMM, BIOS (during boot)
> reported "single channel" memory. With 2 DIMMS, BIOS (during boot)
> reports "dual channel" memory. My question though is does the 64 bit
> kernel require "dual channel" memory or is this a BIOS problem?
>
>
>
> Stan
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

