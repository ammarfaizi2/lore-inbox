Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752809AbWKBKdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752809AbWKBKdd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 05:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752810AbWKBKdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 05:33:33 -0500
Received: from outbound-sin.frontbridge.com ([207.46.51.80]:35203 "EHLO
	outbound2-sin-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1752809AbWKBKdc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 05:33:32 -0500
X-BigFish: V
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 8BIT
Subject: RE: Can Linux live without DMA zone?
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Thu, 2 Nov 2006 18:33:07 +0800
Message-ID: <FFECF24D2A7F6D418B9511AF6F358602F2D5DF@shacnexch2.atitech.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Can Linux live without DMA zone?
Thread-Index: Acb+X8QzRhWkOtZqSru5oAg7bjU8aQACkDeA
From: "Conke Hu" <conke.hu@amd.com>
To: "Arjan van de Ven" <arjan@infradead.org>, "Jun Sun" <jsun@junsun.net>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 02 Nov 2006 10:33:11.0812 (UTC) FILETIME=[4BC97440:01C6FE6A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Most PCs do not have ISA or floppy, so maybe we could add an option to enable DMA zone or not.

Best regards,
Conke @ AMD, Inc.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Arjan van de Ven
Sent: 2006Äê11ÔÂ2ÈÕ 17:16
To: Jun Sun
Cc: linux-kernel@vger.kernel.org
Subject: Re: Can Linux live without DMA zone?

On Wed, 2006-11-01 at 18:15 -0800, Jun Sun wrote:
> I am trying to reserve a block of memory (>16MB) starting from 0 and hide it 
> from kernel.  A consequence is that DMA zone now has size 0.  That causes
> many drivers to grief (OOMs).
> 
> I see two ways out:
> 
> 1. Modify individual drivers and convince them not to alloc with GFP_DMA.
>    I have been trying to do this but do not seem to see an end of it.  :)
> 
> 2. Simply lie and increase MAX_DMA_ADDRESS to really big (like 1GB) so that
>    the whole memory region belongs to DMA zone.
> 
> #2 sounds pretty hackish.  I am sure something bad will happen
> sooner or later (like what?). But so far it appears to be working fine.
> 
> The fundamental question is: Has anybody tried to run Linux without 0 sized
> DMA zone before?  Am I doing something that nobody has done before (which is
> something really hard to believe these days with Linux :P)?

on a PC there are still devices that need memory in the lower 16Mb.....
(like floppy)

Maybe you should reserve another area of memory instead!


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



