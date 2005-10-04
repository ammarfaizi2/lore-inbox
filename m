Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932530AbVJDPTN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932530AbVJDPTN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 11:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbVJDPTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 11:19:13 -0400
Received: from magic.adaptec.com ([216.52.22.17]:33995 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S932239AbVJDPTL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 11:19:11 -0400
Message-ID: <43429D6C.8070909@adaptec.com>
Date: Tue, 04 Oct 2005 11:19:08 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Linus Torvalds <torvalds@osdl.org>, Ryan Anderson <ryan@autoweb.net>,
       =?ISO-8859-1?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>,
       andrew.patterson@hp.com, Marcin Dalecki <dalecki.marcin@neostrada.pl>,
       "Salyzyn, Mark" <mark_salyzyn@adaptec.com>, dougg@torque.net,
       Luben Tuikov <ltuikov@yahoo.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F01A9FA11@otce2k03.adaptec.com>  <1128105594.10079.109.camel@bluto.andrew>  <433D9035.6000504@adaptec.com>  <1128111290.10079.147.camel@bluto.andrew>  <433DA0DF.9080308@adaptec.com>  <1128114950.10079.170.camel@bluto.andrew> <433DB5D7.3020806@adaptec.com>  <9B90AC8A-A678-4FFE-B42D-796C8D87D65B@neostrada.pl>  <4341381D.2060807@adaptec.com>  <E93AC7D5-4CC0-4872-A5B8-115D2BF3C1A9@neostrada.pl>  <1128357350.10079.239.camel@bluto.andrew> <43415EC0.1010506@adaptec.com>  <Pine.BSO.4.62.0510032103380.28198@rudy.mif.pg.gda.pl> <1128377075.23932.5.camel@ryan2.internal.autoweb.net> <Pine.LNX.4.64.0510031531170.31407@g5.osdl.org> <434293D8.50300@adaptec.com> <43429789.8020102@pobox.com>
In-Reply-To: <43429789.8020102@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Oct 2005 15:19:09.0407 (UTC) FILETIME=[F7C12EF0:01C5C8F6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/05 10:54, Jeff Garzik wrote:
> Luben Tuikov wrote:
> 
>>The reason of all this hoopla is that James B, wants to decree
>>that LSI/MPT is the norm and everything else (USB/SAS/SBP) is
>>the exception, while in fact it is the other way around.
> 
> 
> False.  You continue to misunderstand basic stuff about the SCSI core.

Let me repeat: LSI/MPT is not the norm and USB/SAS/SBP, i.e. having
an actual transport layer (handling transport tasks, and error recovery)
is the norm.

Don't make stupid bullshit generalizations that I "continue to
misunderstand basic stuff about the SCSI core".

I've probably misunderstood that LUNs are 32 bit (since SCSI Core
says so) and that REQUEST SENSE clears ACA?

I remember answering your questions on task set aborting several
years ago on linux-scsi.

> We are trying to support all these crazy configurations... at once :)

Oh, I'm well aware of what you're trying to do.

But since the layers are completely upside down one compared
to the other, it would be quite messy unless you can separate
the implementations and at one or the other (but not both)
include a basic emulator.  If there is no basic emulator then
that part would have to be taken by the LLDD.

It would be messy.

	Luben
