Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751066AbWE3M61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbWE3M61 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 08:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbWE3M61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 08:58:27 -0400
Received: from mail0.lsil.com ([147.145.40.20]:19877 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1751063AbWE3M60 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 08:58:26 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH 1/1] scsi : megaraid_{mm,mbox}: a fix on 64-bit DMAcapability check
Date: Tue, 30 May 2006 06:57:43 -0600
Message-ID: <890BF3111FB9484E9526987D912B261901BD98@NAMAIL3.ad.lsil.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/1] scsi : megaraid_{mm,mbox}: a fix on 64-bit DMAcapability check
Thread-Index: AcZ7ix1482k1i985RTyV3eTVDSALvQIXTUEQ
From: "Ju, Seokmann" <Seokmann.Ju@lsil.com>
To: "James Bottomley" <James.Bottomley@SteelEye.com>
Cc: "Vasily Averin" <vvs@sw.ru>, "Andrew Morton" <akpm@osdl.org>,
       <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 30 May 2006 12:57:43.0937 (UTC) FILETIME=[A455B710:01C683E8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 
> Well, this really isn't quite right.  There are 32 bit platforms which
> will refuse a 64 bit DMA mask on principle.  You need to 
> retry with a 32
> bit mask before erroring out, exactly like you've done in 
> megaraid_sas.c
> 
> Also, it's a bit strange having a 32 bit mask set initially 
> in probe_one
> and then being reset in init_mbox.  Why not just consolidate 
> all the PCI
> register testing and mask setting in probe_one?
Thank you for the points!
A patch containing these changes will followed, soon.

Seokmann
