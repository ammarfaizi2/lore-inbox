Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263984AbUDNIq4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 04:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263992AbUDNIq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 04:46:56 -0400
Received: from fmr06.intel.com ([134.134.136.7]:40595 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S263984AbUDNIq3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 04:46:29 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: Non-Exec stack patches
Date: Wed, 14 Apr 2004 01:45:58 -0700
Message-ID: <9AB83E4717F13F419BD880F5254709E5011EBABC@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Non-Exec stack patches
Thread-Index: AcQh+eJWHFhRWG8BRrCx3qCQ1PMN5gAAPUsg
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: "Jamie Lokier" <jamie@shareable.org>
Cc: "Andrew Morton" <akpm@osdl.org>, "Kurt Garloff" <garloff@suse.de>,
       <linux-kernel@vger.kernel.org>, <mingo@redhat.com>
X-OriginalArrivalTime: 14 Apr 2004 08:45:59.0601 (UTC) FILETIME=[E8E4F210:01C421FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> Has the meaning of PAGE_COPY in asm-ia64/pgtable.h changed in 
> 2.6.5-mm5?

Yes. Kurt's recent patch for parsing PT_GNU_STACK section introduced
this change.

Here is the relevant hunk.
-#define PAGE_COPY      __pgprot(__ACCESS_BITS | _PAGE_PL_3 |
_PAGE_AR_RX)
+#define PAGE_COPY      __pgprot(__ACCESS_BITS | _PAGE_PL_3 |
_PAGE_AR_R)
+#define PAGE_COPY_EXEC __pgprot(__ACCESS_BITS | _PAGE_PL_3 |
_PAGE_AR_RX)

> 
> If so, you want to change __P110 as well as __P111.

No. Only EXEC bit is the difference.

thanks,
suresh
