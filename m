Return-Path: <linux-kernel-owner+w=401wt.eu-S1030434AbWLILvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030434AbWLILvt (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 06:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967815AbWLILvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 06:51:49 -0500
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:10191 "EHLO
	mtagate3.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967810AbWLILvs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 06:51:48 -0500
Date: Sat, 9 Dec 2006 12:51:37 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Christoph Lameter <clameter@engr.sgi.com>, Andy <apw@shadowen.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] [PATCH] virtual memmap on sparsemem v3 [0/4] introduction
Message-ID: <20061209115137.GA10380@osiris.ibm.com>
References: <20061208155608.14dcd2e5.kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061208155608.14dcd2e5.kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Virtual mem_map is not useful for 32bit archs. This uses huge virtual
> address range.

Why? The s390 vmem_map implementation which I sent last week to linux-mm
is merged in the meantime. It supports both 32 and 64 bit.
The main reason is to keep things simple and avoid #ifdef hell.

Since the maximum size of the virtual array is  about 16MB it's not much
waste of address space. Actually I just changed the size of the vmalloc
area, so that the maximum supported physical amount of memory is still 1920MB.
