Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264535AbUD1AKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264535AbUD1AKT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 20:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264519AbUD1AKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 20:10:13 -0400
Received: from holomorphy.com ([207.189.100.168]:2753 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264535AbUD1AFx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 20:05:53 -0400
Date: Tue, 27 Apr 2004 17:05:11 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Joel Schopp <jschopp@austin.ibm.com>, Anton Blanchard <anton@samba.org>,
       Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix cpu iterator on empty bitmask
Message-ID: <20040428000511.GU743@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Joel Schopp <jschopp@austin.ibm.com>,
	Anton Blanchard <anton@samba.org>, Andrew Morton <akpm@osdl.org>,
	lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1083109972.2150.124.camel@bach>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1083109972.2150.124.camel@bach>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2004 at 09:52:53AM +1000, Rusty Russell wrote:
> Name: Fix cpumask iterator over empty cpu set
> Status: Trivial
> Can't use _ffs() without first checking for zero, and if bits beyond
> NR_CPUS set it'll give bogus results.  Use find_first_bit

I sent in something equivalent to this along with a number of other
fixes (cpus_shift_right() leaking junk bits in in and cpus_weight()
and cpus_empty() and cpus_equal() and the like not ignoring tails) and
got a NAK since it clashes with something Paul Jackson's doing.


-- wli
