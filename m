Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbTENFUK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 01:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbTENFUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 01:20:10 -0400
Received: from angband.namesys.com ([212.16.7.85]:49294 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S261741AbTENFUI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 01:20:08 -0400
Date: Wed, 14 May 2003 09:32:50 +0400
From: Oleg Drokin <green@namesys.com>
To: Andrew Morton <akpm@digeo.com>
Cc: jdike@karaya.com, roland@redhat.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: build problems on architectures where FIXADDR_* stuff is not constant
Message-ID: <20030514053250.GA27433@namesys.com>
References: <20030513122329.GA31609@namesys.com> <20030513134620.3dafeaf3.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030513134620.3dafeaf3.akpm@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, May 13, 2003 at 01:46:20PM -0700, Andrew Morton wrote:
> >    Since there are architectures where FIXADDR_* stuff is not constant (e.g. UML),
> > ...
> > +			fixmap_vma.vm_start = FIXADDR_START;
> > +			fixmap_vma.vm_end = FIXADDR_TOP;
> > +			fixmap_vma.vm_page_prot = PAGE_READONLY;
> >  			pgd = pgd_offset_k(pg);
> >  			if (!pgd)
> >  				return i ? : -EFAULT;
> That's modifying static storage which other, unrelated processes or CPUs
> may be playing with.

Ah, stupid me. Missed the "static" thing :(

Bye,
    Oleg
