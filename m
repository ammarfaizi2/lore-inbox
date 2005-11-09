Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbVKINJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbVKINJk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 08:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbVKINJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 08:09:40 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:14607 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1750724AbVKINJj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 08:09:39 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <fb7befa20511081437p3355ba0aic8c9c518d3cc7b19@mail.gmail.com>
References: <fb7befa20511081304sec70208l5d1a464e5af78f58@mail.gmail.com> <1131487518.2789.26.camel@laptopd505.fenrus.org> <Pine.LNX.4.61.0511081712210.6019@chaos.analogic.com> <fb7befa20511081437p3355ba0aic8c9c518d3cc7b19@mail.gmail.com>
X-OriginalArrivalTime: 09 Nov 2005 13:09:38.0204 (UTC) FILETIME=[D6A0B5C0:01C5E52E]
Content-class: urn:content-classes:message
Subject: Re: Creating new System.map with modules symbol info
Date: Wed, 9 Nov 2005 08:09:37 -0500
Message-ID: <Pine.LNX.4.61.0511090805020.8435@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Creating new System.map with modules symbol info
Thread-Index: AcXlLtanRgrqJ5QZQP66Om3eJa6X4Q==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Adayadil Thomas" <adayadil.thomas@gmail.com>
Cc: "Arjan van de Ven" <arjan@infradead.org>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 8 Nov 2005, Adayadil Thomas wrote:

> I am trying to use lcrash to debug a panic
>
> I have the System.map of the original kernel (without modules loaded),
> Kerntypes file and the dump file
>
>    <4>Modules linked in: ip_conntrack_dos
>    <4>CPU:    0
>    <4>EIP:    0060:[<f8bb245b>]    Tainted: P      VLI
>    <4>EFLAGS: 00010246   (2.6.12)
>    <4>EIP is at init_conntrack_syn+0x193/0x214 [ip_conntrack_dos]
>    <4>eax: dd0f34b3   ebx: f48de908   ecx: f48de900   edx: 00000000
>    <4>esi: f4c65bc8   edi: f48de900   ebp: 00100100   esp: c040dae0
>    <4>ds: 007b   es: 007b   ss: 0068
>
>
> If i Use the original System.map, it doesnt find the symbol for the
> init_conntrack_syn
> ( EIP is pointing there)
> However, kallsyms has an entry for that
> f8b752c8 t init_conntrack_syn
>
> If kallsyms has all the symbols, I am wondering why does it have lesser lines ?
>
> wc -l
> 12343 kallsyms
> 32127 System.map
>
> Will it work if I cat System.map and kallsyms together and do a sort and uniq
> so that i get the union of both ?
>

Look at the CONTENT of both files! System.map has more information.
You can execute `man nm` to find out what each of the symbol types
mean.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
