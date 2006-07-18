Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbWGRKBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbWGRKBR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 06:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbWGRKBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 06:01:17 -0400
Received: from [216.208.38.107] ([216.208.38.107]:24704 "EHLO
	OTTLS.pngxnet.com") by vger.kernel.org with ESMTP id S932110AbWGRKBQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 06:01:16 -0400
Subject: Re: [RFC PATCH 02/33] Add sync bitops
From: Arjan van de Ven <arjan@infradead.org>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Jeremy Fitzhardinge <jeremy@goop.org>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Zachary Amsden <zach@vmware.com>,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       Christoph Lameter <clameter@sgi.com>
In-Reply-To: <20060718091948.747619000@sous-sol.org>
References: <20060718091807.467468000@sous-sol.org>
	 <20060718091948.747619000@sous-sol.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 18 Jul 2006 11:56:41 +0200
Message-Id: <1153216601.3038.16.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-18 at 00:00 -0700, Chris Wright wrote:
> plain text document attachment (synch-ops)
> Add "always lock'd" implementations of set_bit, clear_bit and
> change_bit and the corresponding test_and_ functions.  Also add
> "always lock'd" implementation of cmpxchg.  These give guaranteed
> strong synchronisation and are required for non-SMP kernels running on
> an SMP hypervisor.

Hi,

this sounds really like the wrong approach; you know you're compiling
for xen, so why not just make set_bit() and the others use the lock'd
instructions at compile time? 

Greetings,
    Arjan van de Ven 

