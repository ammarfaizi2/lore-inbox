Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbVHQRJA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbVHQRJA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 13:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbVHQRJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 13:09:00 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:60942 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751168AbVHQRJA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 13:09:00 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <43036243.5070100@rainbow-software.org>
References: <43036243.5070100@rainbow-software.org>
X-OriginalArrivalTime: 17 Aug 2005 17:09:00.0994 (UTC) FILETIME=[5CD18A20:01C5A34E]
Content-class: urn:content-classes:message
Subject: Re: FPU-intensive programs crashing with floating point exception on Cyrix MII
Date: Wed, 17 Aug 2005 13:08:13 -0400
Message-ID: <Pine.LNX.4.61.0508171304260.28430@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: FPU-intensive programs crashing with floating point exception on Cyrix MII
Thread-Index: AcWjTlzrMhVaoDAtQ+a0gDOkkcf42w==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Ondrej Zary" <linux@rainbow-software.org>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 17 Aug 2005, Ondrej Zary wrote:

> My machine (Cyrix MII PR300 CPU, PCPartner TXB820DS board with i430TX
> chipset) exhibits a really weird problem:
> When I run a program that uses FPU, it sometimes crashes with "flaoting
> point exception" - for example, when playing MP3 files using any player.
> Or with Prime95 - http://www.mersenne.org/freesoft.htm - the "torture
> test" does not crash but shows "fatal error" in less than 10 minutes.
> It might be something like this:
> http://lists.suse.com/archive/suse-linux-e/2000-Sep/1080.html
> or this
> http://lists.slug.org.au/archives/slug/2000/11/msg00343.html
>
> The problem appears on 2.4.x kernels and 2.6.x kernels. It works fine in
> Windows 98 - it can play MP3s and run Prime95 for hours without any
> problems.
> I've tracked it down to math_error() in arch/i386/kernel/traps.c and
> "fixed" it (I really don't know anything about FPU programming). The
> patch is attached. It fixes my system - with the patch, I can play MP3s
> fine and Prime95 runs without any problems too.
>
> Does anyone know why these exceptions happen and/or what's the correct
> solution?
>
> --
> Ondrej Zary
>

0x200 is way up into the "condition" codes. There should have never
been an interrupt at all! Your "fix" is as good as you can get.

>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
