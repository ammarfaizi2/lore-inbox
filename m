Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261316AbULHScw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbULHScw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 13:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbULHScf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 13:32:35 -0500
Received: from [192.55.52.31] ([192.55.52.31]:403 "EHLO fmsfmr004.fm.intel.com")
	by vger.kernel.org with ESMTP id S261306AbULHSbx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 13:31:53 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: Anticipatory prefaulting in the page fault handler V1
Date: Wed, 8 Dec 2004 10:31:20 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F0284433D@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Anticipatory prefaulting in the page fault handler V1
Thread-Index: AcTdT7+l6Ljoc7ciTY6JVMa4L+1xaAABCsLQ
From: "Luck, Tony" <tony.luck@intel.com>
To: "Christoph Lameter" <clameter@sgi.com>
Cc: <nickpiggin@yahoo.com.au>, "Jeff Garzik" <jgarzik@pobox.com>,
       <torvalds@osdl.org>, <hugh@veritas.com>, <benh@kernel.crashing.org>,
       <linux-mm@kvack.org>, <linux-ia64@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 08 Dec 2004 18:31:22.0570 (UTC) FILETIME=[1E2132A0:01C4DD54]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>We could use that as a way to switch of the preallocation. How 
>expensive is that check?

If you already looked up the vma, then it is very cheap.  Just
check for VM_RAND_READ in vma->vm_flags.

-Tony
