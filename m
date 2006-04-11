Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750924AbWDKP0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbWDKP0U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 11:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbWDKP0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 11:26:20 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:914 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750914AbWDKP0T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 11:26:19 -0400
Message-ID: <443BCA98.1020805@de.ibm.com>
Date: Tue, 11 Apr 2006 17:26:16 +0200
From: Carsten Otte <cotte@de.ibm.com>
Reply-To: carsteno@de.ibm.com
Organization: IBM Deutschland
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Jes Sorensen <jes@sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, bjorn_helgaas@hp.com
Subject: Re: [patch] do_no_pfn handler
References: <yq0k6a6uc7i.fsf@jaguar.mkp.net> <yq0psjonq2p.fsf@jaguar.mkp.net> <Pine.LNX.4.64.0604110751510.10745@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604110751510.10745@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> At the very least, it would also need a
> 
> 	BUG_ON(is_cow_mapping(vma->vm_flags));
> 
> (or at least make it return VM_FAULT_SIGBUS). Because a COW mapping _will_ 
> confuse the VM and cause it to do random bad things in vm_normal_page(). 
That leaves my use-case out for now. I will need COW for my mapping when
switching to this interface. Looks like a lot of things need rethinking
in memory.c for COW with no struct page behind.
-- 

Carsten Otte
IBM Linux technology center
ARCH=s390
