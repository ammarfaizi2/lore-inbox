Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751666AbWHMWEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751666AbWHMWEf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 18:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751669AbWHMWEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 18:04:35 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:29966 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751641AbWHMWEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 18:04:34 -0400
Date: Mon, 14 Aug 2006 00:04:33 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andi Kleen <ak@suse.de>
Cc: Keith Owens <kaos@ocs.com.au>, linux-arch@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: module compiler version check still needed?
Message-ID: <20060813220433.GS3543@stusta.de>
References: <31645.1155445159@ocs10w.ocs.com.au> <200608132227.24719.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608132227.24719.ak@suse.de>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2006 at 10:27:24PM +0200, Andi Kleen wrote:
> On Sunday 13 August 2006 06:59, Keith Owens wrote:
> > Andi Kleen (on Sun, 13 Aug 2006 06:48:36 +0200) wrote:
> > >
> > >Does anybody know of any reason why we would still need the compiler version
> > >check during module loading? AFAIK on i386 it was only needed to handle
> > >2.95 (which got dropped) and on x86-64 it was never needed. Is there
> > >a need on any other architecture for it?
> > 
> > IA64 still needs the check.  include/asm-ia64/spinlock.h generates
> > different calls to the out of line spinlock handler, depending on the
> > version of gcc.
> 
> Thanks. But I guess it could be used to MODULE_ARCH_VERMAGIC for ia64 only then.
> If nobody else complains I will do that.

People might not complain until this is for some time in a released 
kernel.

Why don't you check yourself?

  grep -r __GNUC__ *
  grep -r cc-version *

There are over 100 results, but it's easy to spot the few requiring a 
deeper look.

> -Andi

cu
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

