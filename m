Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbWEOXkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbWEOXkq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 19:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbWEOXkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 19:40:45 -0400
Received: from mms3.broadcom.com ([216.31.210.19]:19 "EHLO MMS3.broadcom.com")
	by vger.kernel.org with ESMTP id S1750802AbWEOXkp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 19:40:45 -0400
X-Server-Uuid: B238DE4C-2139-4D32-96A8-DD564EF2313E
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [openib-general] Re: [PATCH 21 of 53] ipath - use
 phys_to_virt instead of bus_to_virt
Date: Mon, 15 May 2006 16:40:35 -0700
Message-ID: <54AD0F12E08D1541B826BE97C98F99F149F34B@NT-SJCA-0751.brcm.ad.broadcom.com>
Thread-Topic: [openib-general] Re: [PATCH 21 of 53] ipath - use
 phys_to_virt instead of bus_to_virt
Thread-Index: AcZ4eDu4pNqVJi9HQCSIA//qAkIJTAAAGouQ
From: "Caitlin Bestler" <caitlinb@broadcom.com>
To: "Roland Dreier" <rdreier@cisco.com>, "Grant Grundler" <iod00d@hp.com>
cc: openib-general@openib.org, linux-kernel@vger.kernel.org,
       "Segher Boessenkool" <segher@kernel.crashing.org>
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006051508; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413039303230392E34343639304634362E303031322D412D;
 ENG=IBF; TS=20060515234038; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006051508_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 6877CEFF3NG17318327-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

openib-general-bounces@openib.org wrote:
>     Grant> Aren't remote addresses handled differently than local
>     Grant> ones?  ULP has to map local addresses.  We can't map remote
>     Grant> ones (remote host maps it).  The ULP must know the
>     Grant> difference and can tell the lower level driver which is   
> Grant> which. 
> 
> The problem is that RDMA requests have to be handled by the
> low-level driver (or hardware) without any ULP involvement.
> So every device has to handle getting messages like "send me
> XXX bytes of data from address YYY in the memory region
> corresponding to R_Key ZZZ."
> 

True, but how does that constrain the local interfaces by which
the driver is informed of the set of pages that back a given
memory region? The driver must still ultimately provide dma
accessible addresses to the device. RDMA just changes the
timing of the steps, albeit radically, but not what the
steps are.

