Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965211AbWBHVq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965211AbWBHVq7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 16:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965206AbWBHVqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 16:46:55 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:10253 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S965190AbWBHVqy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 16:46:54 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <2753bafa0602081333y2f0f8c37o210b8acb6b3b73d1@mail.gmail.com>
X-OriginalArrivalTime: 08 Feb 2006 21:46:52.0402 (UTC) FILETIME=[2C0AC520:01C62CF9]
Content-class: urn:content-classes:message
Subject: Re: Incomprehensible Boot freeze & Crash - Kernel 2.6.12
Date: Wed, 8 Feb 2006 16:46:46 -0500
Message-ID: <Pine.LNX.4.61.0602081642040.7149@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Incomprehensible Boot freeze & Crash - Kernel 2.6.12
Thread-Index: AcYs+SwUp3KbpcG5RcC0ZRThtpyCag==
References: <2753bafa0602081333y2f0f8c37o210b8acb6b3b73d1@mail.gmail.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "thomas" <thomas.bsd@gmail.com>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 8 Feb 2006, thomas wrote:

> Hello,
> I'm running Debian GNU/Linux Etch on an Acer Aspire 1682 laptop with
> kernel 2.6.12-1-686. So far the system was rock solid but I'm now
> experiencing a boot freeze:
>
> ... Setting up ICE socket directory /tmp/ICE-Unix... done
> INIT: Entering runlevel: 2
> Starting system log daemon: syslogd
>
> Then, nothing. However I can boot in "recover mode" (that is, single
> user & root login). There does not seem to be any hardware failure,
> the partitions are properly mounted, and there is engough free space
> on any of them. When I shut down the box, hundreds of lines of errors
> messages are outputted. I cannot read them all but here are the last
> ones:
>
> EIP is at do_page_fault+0xd6/0x6bf
> eax: dfa40000 ebx:00000000 ecx:0000007b edx:ffffff7b esi:00030001
> edi:0000000d ebp:0000000b esp: dfa417c8
> ds: 007b es:007b ss:0008
       ^^^^^^^^^^^____ These are not correct segments!

Something is corrupting the GDT or setting incorrect segments directly.
Perhaps a driver? Or maybe your CPU is way too hot and is corrupting
segments itself?

> Unable to handle kernel paging request at virtual address ffffffef
> printing eip:
> c0114fe6
> *pde=00002067
> *pte=00000000
> Recursive die() failure, output suppressed
> <0> Kernel panic - not syncing: Fatal exception in interrupt
> _
>
> The last time Linux could boot properly, I did not perform any task at
> root: I did not install any hardware, nor I modified any config file.
> I did not change anything in the BIOS either.
>
> I have tried to boot with special options (noapic, nolapic, pci=off,
> pnpbios=off) without success.
>
> I can show any file on my system if needed.
>
> Thanks in advance for your help. I have absolutely no idea of what I
> can do; without your help I can go nowhere.
>
> Best regards,
> Thomas
> -

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.66 BogoMips).
Warning : 98.36% of all statistics are fiction.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
