Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264218AbTH1TPy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 15:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264209AbTH1TPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 15:15:54 -0400
Received: from holomorphy.com ([66.224.33.161]:26052 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264218AbTH1TPu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 15:15:50 -0400
Date: Thu, 28 Aug 2003 12:16:59 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make voyager work again after the cpumask_t changes
Message-ID: <20030828191659.GC482@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	James Bottomley <James.Bottomley@steeleye.com>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <1062097375.1952.41.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062097375.1952.41.camel@mulgrave>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 28, 2003 at 03:02:55PM -0400, James Bottomley wrote:
> Most is just simple fixes; however, the needless change from atomic to
> non-atomic operations in smp_invalidate_interrupt() caused me a lot of
> pain to track down since it introduced some very subtle bugs.
> I've also taken phys_cpu_present_map out of smp.h.  Since it
> physid_mask_t is defined in mpspec.h anyway, and contains a duplicate
> definition, I don't believe it can hurt anything.

Sorry about this; I'm not sure what kind of catastrophe brought about
the non-atomic smp_invalidate_interrupt() bits in voyager.c


-- wli
