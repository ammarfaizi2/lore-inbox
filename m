Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750973AbWD3GHZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbWD3GHZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 02:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbWD3GHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 02:07:25 -0400
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:2554 "EHLO
	ms-smtp-01.texas.rr.com") by vger.kernel.org with ESMTP
	id S1750971AbWD3GHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 02:07:25 -0400
Date: Sun, 30 Apr 2006 01:07:15 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Andi Kleen <ak@suse.de>, Nick Piggin <nickpiggin@yahoo.com.au>
cc: Magnus Damm <magnus.damm@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: i386 and PAE: pud_present()
Message-ID: <2432524299CCD3CA89BB647D@[10.1.1.4]>
In-Reply-To: <200604281027.22183.ak@suse.de>
References: <aec7e5c30604280040p60cc7c7dqc6fb6fbdd9506a6b@mail.gmail.com>
 <4451CA41.5070101@yahoo.com.au> <200604281027.22183.ak@suse.de>
X-Mailer: Mulberry/4.0.0b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Friday, April 28, 2006 10:27:21 +0200 Andi Kleen <ak@suse.de> wrote:

>> Take a look a little further down the page for the comment.
>> 
>> In i386 + PAE, pud is always present.
> 
> I think his problem is that the PGD is always present too (in
> pgtables-nopud.h) Indeed looks strange.

The PGD is always fully populated on i386 if PAE is enabled.  All three of
the pmd pages are allocated at page table creation time and persist till
the page table is deleted.

Dave McCracken

