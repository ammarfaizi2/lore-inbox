Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752633AbWKBDoa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752633AbWKBDoa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 22:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752635AbWKBDo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 22:44:29 -0500
Received: from outbound-sin.frontbridge.com ([207.46.51.80]:21649 "EHLO
	outbound3-sin-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1752633AbWKBDo2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 22:44:28 -0500
X-BigFish: V
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 8BIT
Subject: RE: Can Linux live without DMA zone?
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Thu, 2 Nov 2006 11:43:38 +0800
Message-ID: <FFECF24D2A7F6D418B9511AF6F358602F2D4E1@shacnexch2.atitech.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Can Linux live without DMA zone?
Thread-Index: Acb+JTnnIw5Rjlw7TcuZKVsmYbT2NgAC1E5g
From: "Conke Hu" <conke.hu@amd.com>
To: "Jun Sun" <jsun@junsun.net>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 02 Nov 2006 03:43:43.0136 (UTC) FILETIME=[17B70200:01C6FE31]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems a good idea.
Is dma zone is still necessay on most modern computers?

Best regards,
Conke @ AMD, Inc.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Jun Sun
Sent: 2006Äê11ÔÂ2ÈÕ 10:16
To: linux-kernel@vger.kernel.org
Subject: Can Linux live without DMA zone?


I am trying to reserve a block of memory (>16MB) starting from 0 and hide it 
from kernel.  A consequence is that DMA zone now has size 0.  That causes
many drivers to grief (OOMs).

I see two ways out:

1. Modify individual drivers and convince them not to alloc with GFP_DMA.
   I have been trying to do this but do not seem to see an end of it.  :)

2. Simply lie and increase MAX_DMA_ADDRESS to really big (like 1GB) so that
   the whole memory region belongs to DMA zone.

#2 sounds pretty hackish.  I am sure something bad will happen
sooner or later (like what?). But so far it appears to be working fine.

The fundamental question is: Has anybody tried to run Linux without 0 sized
DMA zone before?  Am I doing something that nobody has done before (which is
something really hard to believe these days with Linux :P)?

Cheers.

Jun
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



