Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751068AbWD3Ixk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbWD3Ixk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 04:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbWD3Ixk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 04:53:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:33461 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751068AbWD3Ixk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 04:53:40 -0400
From: Andi Kleen <ak@suse.de>
To: Dave McCracken <dmccr@us.ibm.com>
Subject: Re: i386 and PAE: pud_present()
Date: Sun, 30 Apr 2006 10:53:26 +0200
User-Agent: KMail/1.9.1
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Magnus Damm <magnus.damm@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
References: <aec7e5c30604280040p60cc7c7dqc6fb6fbdd9506a6b@mail.gmail.com> <200604281027.22183.ak@suse.de> <2432524299CCD3CA89BB647D@[10.1.1.4]>
In-Reply-To: <2432524299CCD3CA89BB647D@[10.1.1.4]>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604301053.26907.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 April 2006 08:07, Dave McCracken wrote:
> 
> --On Friday, April 28, 2006 10:27:21 +0200 Andi Kleen <ak@suse.de> wrote:
> 
> >> Take a look a little further down the page for the comment.
> >> 
> >> In i386 + PAE, pud is always present.
> > 
> > I think his problem is that the PGD is always present too (in
> > pgtables-nopud.h) Indeed looks strange.
> 
> The PGD is always fully populated on i386 if PAE is enabled.  All three of
> the pmd pages are allocated at page table creation time and persist till
> the page table is deleted.

At least with the new flexmmap it sounds like a waste of memory.

-Andi

