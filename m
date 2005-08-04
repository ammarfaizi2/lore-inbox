Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262709AbVHDWxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbVHDWxp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 18:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262717AbVHDWvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 18:51:31 -0400
Received: from fmr22.intel.com ([143.183.121.14]:4525 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S262709AbVHDWuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 18:50:04 -0400
Message-Id: <200508042249.j74Mndg18582@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Andi Kleen'" <ak@suse.de>, "Hugh Dickins" <hugh@veritas.com>
Cc: <linux-kernel@vger.kernel.org>, "Anton Blanchard" <anton@samba.org>,
       <cr@sap.com>, <linux-mm@kvack.org>
Subject: RE: Getting rid of SHMMAX/SHMALL ?
Date: Thu, 4 Aug 2005 15:49:37 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcWY99fhD3pWpo+jQQimuJQ+43o7EwATY4KA
In-Reply-To: <20050804132338.GT8266@wotan.suse.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote on Thursday, August 04, 2005 6:24 AM
> I think we should just get rid of the per process limit and keep
> the global limit, but make it auto tuning based on available memory.
> That is still not very nice because that would likely keep it < available 
> memory/2, but I suspect databases usually want more than that. So
> I would even make it bigger than tmpfs for reasonably big machines.
> Let's say
> 
> if (main memory >= 1GB)
> 	maxmem = main memory - main memory/8 

This might be too low on large system.  We usually stress shm pretty hard
for db application and usually use more than 87% of total memory in just
one shm segment.  So I prefer either no limit or a tunable.

- Ken

