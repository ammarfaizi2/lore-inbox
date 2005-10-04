Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964793AbVJDOiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964793AbVJDOiY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 10:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964787AbVJDOiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 10:38:24 -0400
Received: from magic.adaptec.com ([216.52.22.17]:24767 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S964779AbVJDOiX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 10:38:23 -0400
Message-ID: <434293D8.50300@adaptec.com>
Date: Tue, 04 Oct 2005 10:38:16 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Ryan Anderson <ryan@autoweb.net>,
       =?ISO-8859-1?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>,
       andrew.patterson@hp.com, Marcin Dalecki <dalecki.marcin@neostrada.pl>,
       "Salyzyn, Mark" <mark_salyzyn@adaptec.com>, dougg@torque.net,
       Luben Tuikov <ltuikov@yahoo.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F01A9FA11@otce2k03.adaptec.com>  <1128105594.10079.109.camel@bluto.andrew>  <433D9035.6000504@adaptec.com>  <1128111290.10079.147.camel@bluto.andrew>  <433DA0DF.9080308@adaptec.com>  <1128114950.10079.170.camel@bluto.andrew> <433DB5D7.3020806@adaptec.com>  <9B90AC8A-A678-4FFE-B42D-796C8D87D65B@neostrada.pl>  <4341381D.2060807@adaptec.com>  <E93AC7D5-4CC0-4872-A5B8-115D2BF3C1A9@neostrada.pl>  <1128357350.10079.239.camel@bluto.andrew> <43415EC0.1010506@adaptec.com>  <Pine.BSO.4.62.0510032103380.28198@rudy.mif.pg.gda.pl> <1128377075.23932.5.camel@ryan2.internal.autoweb.net> <Pine.LNX.4.64.0510031531170.31407@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510031531170.31407@g5.osdl.org>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Oct 2005 14:38:17.0797 (UTC) FILETIME=[427B2F50:01C5C8F1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/05 18:56, Linus Torvalds wrote:
> So when the SAS people say that the SCSI layer should conform to their 
> needs, next time they should remember that it _also_ needs to conform to 
> the needs of things like USB storage. Which has totally different goals, 
> implementation issues, and bugs. 

It does, Linus, it does.

SAS/USB/SBP all implement pretty close to SAM architecture
whereby the transport layer (SAS/USB/SBP) sits between
SCSI Core (SAM to be) and the interconnect (USB bus, SAS link,
Infiniband, IEEE1394, TCP/IP, FC, etc).

The reason of all this hoopla is that James B, wants to decree
that LSI/MPT is the norm and everything else (USB/SAS/SBP) is
the exception, while in fact it is the other way around.

This is because 10 years ago, all there was was Parallel SCSI,
and all LLDD implemented Parallel SCSI and above them was SCSI Core.
So in effect there was no need for Parallel SCSI Transport _layer_
between an SPI LLDD and SCSI Core.

What you see in my SAS Code is what you see in USB Storage (sans EH)
and what you see in SBP.  It is the same architecture: layered.

	Luben
