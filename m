Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964945AbWCQOEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964945AbWCQOEO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 09:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964941AbWCQOEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 09:04:14 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:7360 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S964936AbWCQOEN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 09:04:13 -0500
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, hch@lst.de,
       cotte@de.ibm.com, Hugh Dickins <hugh@veritas.com>
Subject: Re: [patch 2/2] mspec driver
References: <yq0k6auuy5n.fsf@jaguar.mkp.net>
	<20060316163728.06f49c00.akpm@osdl.org>
	<yq0bqw5utyc.fsf_-_@jaguar.mkp.net> <441ABB68.1020502@yahoo.com.au>
From: Jes Sorensen <jes@sgi.com>
Date: 17 Mar 2006 09:04:10 -0500
In-Reply-To: <441ABB68.1020502@yahoo.com.au>
Message-ID: <yq07j6tuq05.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Nick" == Nick Piggin <nickpiggin@yahoo.com.au> writes:

Nick> Jes Sorensen wrote:
>> + vma->vm_flags |= (VM_IO | VM_LOCKED | VM_RESERVED | VM_PFNMAP);

Nick> VM_PFNMAP actually has a fairly specific meaning [unlike the
Nick> rest of them :)] so you should be careful with it. Actually if
Nick> you set vm_pgoff in the right way, then that should enable you
Nick> to do COWs on these areas if that is what you want.

Yup, I went through that when I started using it. I think you guided
me through it :-)

We don't want COW here as the access is backed by special behavior in
the memory controller. We only allow shared mappings for that reason.

Cheers,
Jes
