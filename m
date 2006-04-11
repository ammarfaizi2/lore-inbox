Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750885AbWDKUwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbWDKUwo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 16:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbWDKUwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 16:52:44 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:64186 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750882AbWDKUwn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 16:52:43 -0400
Message-ID: <443C1735.8080600@de.ibm.com>
Date: Tue, 11 Apr 2006 22:53:09 +0200
From: Carsten Otte <cotte@de.ibm.com>
Reply-To: carsteno@de.ibm.com
Organization: IBM Deutschland
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: carsteno@de.ibm.com, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       bjorn_helgaas@hp.com
Subject: Re: [patch] do_no_pfn handler
References: <yq0k6a6uc7i.fsf@jaguar.mkp.net> <yq0psjonq2p.fsf@jaguar.mkp.net> <Pine.LNX.4.64.0604110751510.10745@g5.osdl.org> <443BCA98.1020805@de.ibm.com> <Pine.LNX.4.64.0604110830260.10745@g5.osdl.org> <443C0B8F.7010501@de.ibm.com> <Pine.LNX.4.64.0604111318120.10745@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604111318120.10745@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Now, the kernel page table accessor macros are certainly generic enough 
> that you could have your own "COW bits" macro, and make this all an 
> architecture-specific feature (and simply not allow it on architectures 
> that don't have a sw-usable COW bit)
> 
> It so happens that S390 seems to be one of the very few architectures that 
> doesn't have room for that bit in its regular page table layout, and 
> that's arguably a design problem for S390. But you _could_ just allocate 
> extra memory for page tables, and put the COW bit there. The VM wouldn't 
> care - at that point it would fit in the "larger picture" of just having 
> the COW information directly in the page tables (even if the "page tables" 
> would be partly just sw-defined).
Interresting idea. Sounds more feasible then splitting vmas, I am going to think about it. Thanks!
-- 

Carsten Otte
IBM Linux technology center
ARCH=s390
