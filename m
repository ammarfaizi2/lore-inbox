Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261614AbULNSzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbULNSzP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 13:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbULNSzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 13:55:15 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:2027 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261608AbULNSzJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 13:55:09 -0500
Date: Tue, 14 Dec 2004 10:59:50 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Brent Casavant <bcasavan@sgi.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
cc: linux-ia64@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH 0/3] NUMA boot hash allocation interleaving
Message-ID: <9250000.1103050790@flay>
In-Reply-To: <Pine.SGI.4.61.0412141140030.22462@kzerza.americas.sgi.com>
References: <Pine.SGI.4.61.0412141140030.22462@kzerza.americas.sgi.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> NUMA systems running current Linux kernels suffer from substantial
> inequities in the amount of memory allocated from each NUMA node
> during boot.  In particular, several large hashes are allocated
> using alloc_bootmem, and as such are allocated contiguously from
> a single node each.

Yup, makes a lot of sense to me to stripe these, for the caches that
are global (ie inodes, dentries, etc).  Only question I'd have is 
didn't Manfred or someone (Andi?) do this before? Or did that never
get accepted? I know we talked about it a while back.

M,


