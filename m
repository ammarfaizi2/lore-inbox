Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262768AbVHDXBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262768AbVHDXBP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 19:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262717AbVHDXBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 19:01:05 -0400
Received: from fmr22.intel.com ([143.183.121.14]:44975 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S262768AbVHDW7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 18:59:13 -0400
Message-Id: <200508042258.j74Mwsg18638@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Andi Kleen'" <ak@suse.de>
Cc: "Hugh Dickins" <hugh@veritas.com>, <linux-kernel@vger.kernel.org>,
       "Anton Blanchard" <anton@samba.org>, <cr@sap.com>, <linux-mm@kvack.org>
Subject: RE: Getting rid of SHMMAX/SHMALL ?
Date: Thu, 4 Aug 2005 15:58:52 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcWZR3QUjcPD3IqrRQu1MObSuIpYnQAAA5cA
In-Reply-To: <20050804225413.GH8266@wotan.suse.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote on Thursday, August 04, 2005 3:54 PM
> > This might be too low on large system.  We usually stress shm pretty hard
> > for db application and usually use more than 87% of total memory in just
> > one shm segment.  So I prefer either no limit or a tunable.
> 
> With large system you mean >32GB right?

Yes, between 32 GB - 128 GB.  On larger numa box in the 256 GB and upward,
we have to break shm segment into one per-numa-node and then the limit
should be OK.  I was concerned with SMP box with large memory.

> I think on a large systems some tuning is reasonable because they likely
> have trained admins. I'm more worried on reasonable defaults for the
> class of systems with 0-4GB

Sounds reasonable to me.

- Ken

