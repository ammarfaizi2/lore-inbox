Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263737AbUDNJrX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 05:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263741AbUDNJrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 05:47:23 -0400
Received: from mail.shareable.org ([81.29.64.88]:15776 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S263737AbUDNJrW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 05:47:22 -0400
Date: Wed, 14 Apr 2004 10:47:02 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, Kurt Garloff <garloff@suse.de>,
       linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: Non-Exec stack patches
Message-ID: <20040414094702.GC8888@mail.shareable.org>
References: <9AB83E4717F13F419BD880F5254709E5011EBABA@scsmsx402.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9AB83E4717F13F419BD880F5254709E5011EBABA@scsmsx402.sc.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

People looking at PROT_EXEC page table flags might want to be aware
that <asm-um/pgtable.h> mimics the behaviour of i386: read implies and
is implied by exec, write implies read.

That might mean user-mode linux doesn't provide no-exec-stack
protection even when the underlying kernel does offer it.  I'm not sure.

-- Jamie

