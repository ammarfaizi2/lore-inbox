Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932478AbWAFTDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbWAFTDv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 14:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbWAFTDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 14:03:50 -0500
Received: from fmr14.intel.com ([192.55.52.68]:55475 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S932472AbWAFTDs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 14:03:48 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 2.6.15] ia64: use i386 dmi_scan.c
Date: Fri, 6 Jan 2006 11:03:17 -0800
Message-ID: <D36CE1FCEFD3524B81CA12C6FE5BCAB00C081899@fmsmsx406.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.15] ia64: use i386 dmi_scan.c
Thread-Index: AcYS55ML09WcJ0agSpGAtXG7y0eATwACoFPQ
From: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
To: "Matt Domsch" <Matt_Domsch@Dell.com>, <linux-ia64@vger.kernel.org>,
       <ak@suse.de>, <openipmi-developer@lists.sourceforge.net>,
       <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 06 Jan 2006 19:03:20.0376 (UTC) FILETIME=[DBFCAB80:01C612F3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Domsch <> wrote:
> Enable DMI table parsing on ia64.
...
> +#ifndef CONFIG_EFI
> +void __init dmi_scan_machine(void)
> +{
>  	char __iomem *p, *q;
> +	int rc;

Hi Matt,

You could potentially consolidate the two dmi_scan_machine functions
and lose the ifdef (and duplication) by checking efi_enabled instead.  
'efi_enabled' is already ifdef'd in the EFI header (defined to 1 for 
ia64) specifically for this situation.  

matt
