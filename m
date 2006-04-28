Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030348AbWD1I1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030348AbWD1I1Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 04:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030350AbWD1I1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 04:27:24 -0400
Received: from cantor2.suse.de ([195.135.220.15]:42664 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030348AbWD1I1X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 04:27:23 -0400
From: Andi Kleen <ak@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: i386 and PAE: pud_present()
Date: Fri, 28 Apr 2006 10:27:21 +0200
User-Agent: KMail/1.9.1
Cc: Magnus Damm <magnus.damm@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
References: <aec7e5c30604280040p60cc7c7dqc6fb6fbdd9506a6b@mail.gmail.com> <4451CA41.5070101@yahoo.com.au>
In-Reply-To: <4451CA41.5070101@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604281027.22183.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 April 2006 09:54, Nick Piggin wrote:
> Magnus Damm wrote:
> > Hi guys,
> > 
> > In file include/asm-i386/pgtable-3level.h:
> > 
> > On i386 with PAE enabled, shouldn't pud_present() return (pud_val(pud)
> > & _PAGE_PRESENT) instead of constant 1?
> > 
> > Today pud_present() returns constant 1 regardless of PAE or not. This
> > looks wrong to me, but maybe I'm misunderstanding how to fold the page
> > tables... =)
> 
> Take a look a little further down the page for the comment.
> 
> In i386 + PAE, pud is always present.

I think his problem is that the PGD is always present too (in pgtables-nopud.h)
Indeed looks strange.

-Andi
