Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265051AbUJEUfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265051AbUJEUfe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 16:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265093AbUJEUfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 16:35:24 -0400
Received: from fmr12.intel.com ([134.134.136.15]:17325 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S265051AbUJEUfI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 16:35:08 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] 2.6 SGI Altix I/O code reorganization
Date: Tue, 5 Oct 2004 13:34:53 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F0221C989@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 2.6 SGI Altix I/O code reorganization
Thread-Index: AcSrEurd8pNG+kLZSiiy5hvxZy68jgABYRlg
From: "Luck, Tony" <tony.luck@intel.com>
To: "Patrick Gefre" <pfg@sgi.com>
Cc: <cngam@sgi.com>, "Matthew Wilcox" <matthew@wil.cx>,
       "Grant Grundler" <iod00d@hp.com>, "Jesse Barnes" <jbarnes@engr.sgi.com>,
       <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>
X-OriginalArrivalTime: 05 Oct 2004 20:34:54.0841 (UTC) FILETIME=[C5BFFE90:01C4AB1A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>It had been suggested that we submit this as new code - since 
>it can't be transitioned to. And I thought that was what we
>had decided on - a 'kill' patch and an 'add' patch.

Sorry ... I must have missed that.

>I can remove any Lindent'ing of older files if you don't want that.

Yes please.

>I will take out the Kconfig mod.

Good.

>I believe Christoph is the maintainer of the qla driver (he was one of 
>the reviewers).

His fingerprints are all over the revision history.  It looks like the
only real change you want here is deleting the ugly hack for SN2:

< #if defined(CONFIG_IA64_GENERIC) || defined(CONFIG_IA64_SGI_SN2)
< #include <asm/sn/pci/pciio.h>
< /* Ugly hack needed for the virtual channel fix on SN2 */
< extern int snia_pcibr_rrb_alloc(struct pci_dev *pci_dev,
< 				int *count_vchan0, int *count_vchan1);
< #endif

If Christoph signs off on that, then I can feed a separate patch
that does that at the same time as the kill/add.

-Tony


