Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264044AbUD0MdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264044AbUD0MdV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 08:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264039AbUD0MdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 08:33:16 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:50705 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264034AbUD0MdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 08:33:14 -0400
Date: Tue, 27 Apr 2004 13:33:11 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Keith Owens <kaos@sgi.com>
Cc: Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 2.6.6-rc2 Allow architectures to reenable interrupts on contended spinlocks
Message-ID: <20040427133310.A16351@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Keith Owens <kaos@sgi.com>, Paul Mackerras <paulus@samba.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <16526.17872.872703.799153@cargo.ozlabs.ibm.com> <2300.1083067525@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <2300.1083067525@ocs3.ocs.com.au>; from kaos@sgi.com on Tue, Apr 27, 2004 at 10:05:25PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2004 at 10:05:25PM +1000, Keith Owens wrote:
> On Tue, 27 Apr 2004 21:36:48 +1000, 
> Paul Mackerras <paulus@samba.org> wrote:
> >I was just thinking yesterday that it would be good to reenable
> >interrupts during spin_lock_irq on ppc64.  I am hacking on the
> >spinlocks for ppc64 at the moment and this looks like something worth
> >adding.
> >
> >Why not keep _raw_spin_lock as it is and only use _raw_spin_lock_flags
> >in the spin_lock_irq{,save} case?
> 
> Using both _raw_spin_lock and _raw_spin_lock_flags doubles the amount
> of code to maintain.

So define _raw_spin_lock to _raw_spin_lock_flags(lock, 0) in ia64 code?

