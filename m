Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265008AbUFVP42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265008AbUFVP42 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 11:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264931AbUFVPwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 11:52:00 -0400
Received: from fmr06.intel.com ([134.134.136.7]:41357 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S264966AbUFVPsK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 11:48:10 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] Export msi_remove_pci_irq_vectors
Date: Tue, 22 Jun 2004 08:47:53 -0700
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E5024057E4EF2@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Export msi_remove_pci_irq_vectors
Thread-Index: AcRYDf9BNpeeg8I4QQmFxz6cEoUrFAAYEvsg
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Roland Dreier" <roland@topspin.com>, <linux-kernel@vger.kernel.org>
Cc: <greg@kroah.com>, "Nguyen, Tom L" <tom.l.nguyen@intel.com>
X-OriginalArrivalTime: 22 Jun 2004 15:47:55.0339 (UTC) FILETIME=[48C0C1B0:01C45870]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, June 21, 2004 Roland Dreier wrote: 

>As a followup to my previous post about the request_mem_region in
>msi.c, I noticed that the region is only released in
>msi_remove_pci_irq_vectors().  Based on the fact that this function is
>declared in linux/pci.h (and stubbed out if CONFIG_PCI_USE_VECTOR is
>not defined), I'm guessing that the intent is for a device driver to
>unconditionally call this when exiting.

The intent of msi_remove_pci_irq_vectors() is to support hot-removed 
operation. This function is not for a device driver to call and
should not be exported. I acknowledged the problem of the MSI-X region 
being only released in msi_remove_pci_irq_vectors(). I'm in a progress 
of updating the existing MSI-X code.

Thanks,
Long
