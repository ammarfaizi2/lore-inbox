Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262674AbSJBWmp>; Wed, 2 Oct 2002 18:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262675AbSJBWmp>; Wed, 2 Oct 2002 18:42:45 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:44542 "EHLO
	baldur.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S262674AbSJBWmo>; Wed, 2 Oct 2002 18:42:44 -0400
Date: Wed, 02 Oct 2002 17:48:01 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>
cc: Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Snapshot of shared page tables
Message-ID: <183710000.1033598881@baldur.austin.ibm.com>
In-Reply-To: <15771.30104.815144.546550@argo.ozlabs.ibm.com>
References: <45850000.1033570655@baldur.austin.ibm.com>
 <15771.30104.815144.546550@argo.ozlabs.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Thursday, October 03, 2002 08:39:20 +1000 Paul Mackerras
<paulus@samba.org> wrote:

> Interesting.  I notice that you are using the _PAGE_RW bit in the
> PMDs.  Are you relying on the hardware to do anything with that bit,
> or is it only used by software?
> 
> (If you are relying on the hardware to do something different when
> _PAGE_RW is clear in the PMD, then your approach isn't portable.)

Yes, I am relying on the hardware.  I was under the impression that it was
pretty much universal that making the pmd read-only would make the hardware
treat all ptes under it as read-only.  This came out of a discussion on
lkml last winter where this assertion was made.

Do you know of a page table-based architecture that doesn't have and honor
read-only protections at the pmd level?

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

