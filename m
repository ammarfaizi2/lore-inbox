Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310324AbSCGNl5>; Thu, 7 Mar 2002 08:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310328AbSCGNlr>; Thu, 7 Mar 2002 08:41:47 -0500
Received: from dsl-213-023-043-059.arcor-ip.net ([213.23.43.59]:30899 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S310324AbSCGNle>;
	Thu, 7 Mar 2002 08:41:34 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, jdike@karaya.com (Jeff Dike)
Subject: Re: [RFC] Arch option to touch newly allocated pages
Date: Thu, 7 Mar 2002 14:36:08 +0100
X-Mailer: KMail [version 1.3.2]
Cc: bcrl@redhat.com (Benjamin LaHaise), hpa@zytor.com (H. Peter Anvin),
        alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <E16iyGp-0002IL-00@the-village.bc.nu>
In-Reply-To: <E16iyGp-0002IL-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16iy41-00037z-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 7, 2002 02:49 pm, Alan Cox wrote:
> Jeff Dike Apparently wrote
> > caller.  This is actually wrong because in this failure case, it effectively
> > changes the semantics of GFP_USER, GFP_KERNEL, and the other blocking GFP_* 
> > allocations to GFP_ATOMIC.  And that's what forced UML to segfault the 
> > compilations.
> 
> GFP_KERNEL will sometimes return NULL.

Sad but true.  IMHO we are on track to fix that in this kernel cycle, with
better locked/dirty accounting and rmap to forcibly unmap pages when necessary.

-- 
Daniel
