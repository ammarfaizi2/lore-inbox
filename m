Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964810AbWGSMzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbWGSMzT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 08:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964816AbWGSMzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 08:55:19 -0400
Received: from cantor2.suse.de ([195.135.220.15]:975 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964810AbWGSMzR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 08:55:17 -0400
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [RFC PATCH 02/33] Add sync bitops
Date: Wed, 19 Jul 2006 14:54:40 +0200
User-Agent: KMail/1.9.1
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Zachary Amsden <zach@vmware.com>,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       Christoph Lameter <clameter@sgi.com>
References: <20060718091807.467468000@sous-sol.org> <20060718091948.747619000@sous-sol.org> <1153216601.3038.16.camel@laptopd505.fenrus.org>
In-Reply-To: <1153216601.3038.16.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607191454.41019.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 18 July 2006 11:56, Arjan van de Ven wrote:
> On Tue, 2006-07-18 at 00:00 -0700, Chris Wright wrote:
> > plain text document attachment (synch-ops)
> > Add "always lock'd" implementations of set_bit, clear_bit and
> > change_bit and the corresponding test_and_ functions.  Also add
> > "always lock'd" implementation of cmpxchg.  These give guaranteed
> > strong synchronisation and are required for non-SMP kernels running on
> > an SMP hypervisor.
>
> Hi,
>
> this sounds really like the wrong approach; you know you're compiling
> for xen, so why not just make set_bit() and the others use the lock'd
> instructions at compile time?

I guess because they only need it for a small subset of set_bits.

-Andi
