Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752025AbWCBRV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752025AbWCBRV4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 12:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752024AbWCBRV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 12:21:56 -0500
Received: from mail0.lsil.com ([147.145.40.20]:2046 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1752021AbWCBRVz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 12:21:55 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: Question: how to map SCSI data DMA address to virtual address?
Date: Thu, 2 Mar 2006 10:21:51 -0700
Message-ID: <9738BCBE884FDB42801FAD8A7769C2651420C3@NAMAIL1.ad.lsil.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Question: how to map SCSI data DMA address to virtual address?
Thread-index: AcY+HAvFPtIuYUZYSGSIV0ASISplWAAAX4yw
From: "Ju, Seokmann" <Seokmann.Ju@lsil.com>
To: "Christoph Hellwig" <hch@infradead.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
X-OriginalArrivalTime: 02 Mar 2006 17:21:51.0306 (UTC) FILETIME=[CB5692A0:01C63E1D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thursday, March 02, 2006 12:09 PM Christoph Hellwig wrote:
> For each sg list entry do something like:
> 
> 	buffer = kmap_atomic(sg->page, KM_USER0) + sg->offset;
> 	<access buffer>
> 	kunmap_atomic(buffer - sg->offset, KM_USER0);
Thank you for your comment!
I'll try with this.

Thank you again.
